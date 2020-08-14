require 'net/http'
require 'json'
require 'uri'
require 'pathname'
require 'dotenv/load'

GITHUB_URL = "https://api.github.com/gists"
HTTP_STATUS_CREATED = "201"

loop do
  puts "========================================================================================"
  puts "---Ingrese si quiere subir un archivo o un ruta---"
  puts "========================================================================================"
  file_or_route= gets.chomp.capitalize
  puts "========================================================================================"
  
  if file_or_route == "Archivo"
    puts "---Ingrese el nombre del archivo que quiere subir como un Gist de GitHub--- " 
    puts "========================================================================================"
    filename= gets.chomp  
    puts "========================================================================================"

    if File.exist?(filename)   
      puts "---Añade una descripción---"
      puts "========================================================================================"
      description = gets.chomp
      puts "---Quieres que tu repositorio sea público? Si/No, por defecto el repositorio será público---"
      puts "========================================================================================"
      state = gets.chomp.capitalize
      state = state != "No"
      open(filename, "r:UTF-8") { |file| @content = file.read() }
      uri = URI.parse(GITHUB_URL)
      request = Net::HTTP::Post.new(uri)
      request.basic_auth(ENV[ 'YOUR_USERNAME' ], ENV[ 'YOUR_TOKEN' ])
      request.body = JSON.dump({ "description" => description, "public" => state, "files" => { filename => { "content" => @content }}})
      req_options = { use_ssl: uri.scheme == "https" }

      begin
        response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
          http.request(request)
      end
          
      json = response.body
      parsed = JSON.parse(json)
      response_status = response.code

      if response_status== HTTP_STATUS_CREATED
        puts "========================================================================================"
        puts "Tu gist se ha creado con exito. La URL de su gist es: "+ parsed["url"]
        puts "========================================================================================"
        break
      end
      
      rescue SocketError => se 
        puts "========================================================================================"
        puts "Ha ocurrido un error de conexión. Quiere intentar nuevamente?"
        puts "========================================================================================"
        try_again = gets.chomp.capitalize
        break if try_again == "No"
      end
  else
    puts "Su archivo no existe"
    puts "========================================================================================"
  end

  elsif file_or_route == "Ruta"
    puts "---Ingrese la ruta del directorio que desea subir como un gist de Github---"
    puts "========================================================================================"
    route = gets.chomp
    puts "========================================================================================"
    
    if File.exist?(route)
      puts "---Añade una descripción---"
      puts "========================================================================================"
      description = gets.chomp
      puts "========================================================================================"
      puts "---Quieres que tu repositorio sea público? Si/No, por defecto el repositorio será público---"
      puts "========================================================================================"
      state = gets.chomp.capitalize
      state = state != "No"
      
      only_files = Dir.glob(route +'/**/*').reject do |path|
        File.directory?(path)
      end
      
      @bar ={ :description => description,:public => state,:files =>{} }
      
      only_files.each do |f|
        @name = Pathname.new(f).basename 
        puts @name

        open(f, "r:UTF-8") do |file|
          @content = file.read()
          @bar[:files][@name] = { :content => @content } 
        end
      end
      
      puts "========================================================================================"
      @bar = @bar.to_json
      uri = URI.parse(GITHUB_URL)
      request = Net::HTTP::Post.new(uri)
      request.basic_auth(ENV['YOUR_USERNAME'], ENV['YOUR_TOKEN'])
      request.body = @bar
      req_options = { use_ssl: uri.scheme == "https" }
      
      begin
        response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
          http.request(request)
      end
      
      json = response.body
      parsed = JSON.parse(json)
      response_status = response.code
  
      if response_status == HTTP_STATUS_CREATED
        puts "Tu gist se ha creado con exito. La URL de su gist es: "+ parsed["url"]
        break
      end
  
      rescue SocketError => se
        puts "Ha ocurrido un error de conexión. Quiere intentar nuevamente?"
        try_again = gets.chomp.capitalize
        break if try_again == "No"
      end
    else
      puts "---Su ruta no existe---"
    end
  end
end
