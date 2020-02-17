require 'net/http'
require 'json'
require 'uri'
require 'pathname'

loop do
    puts "========================================================================================"
    puts "---Ingrese si quiere subir un archivo o un ruta---"
    puts "========================================================================================"
    file_or_route= gets.chomp.capitalize
    puts "========================================================================================"
    
    if file_or_route == "Archivo"
        puts "---Ingrese el nombre del archivo que quiere subir como un Gist de GitHub--- " # Interfaz Principal
        puts "---No se olvide de finalizar el archivo con '.txt'---" 
        puts "========================================================================================"
        filename= gets.chomp  
        puts "========================================================================================"

        if File.exist?("#{filename}")   
            puts "---Añade una descripción---"
            puts "========================================================================================"
            description = gets.chomp
            puts"---Quieres que tu repositorio sea publico?---"
            puts "========================================================================================"
            state = gets.chomp.capitalize

            if state == "Si" 
                state = true;
            elsif state == "No"
                state = false;
            else
                puts "Responde Si o No..."
            end
            
            open(filename, "r") { |file| @content = file.read() }
            uri = URI.parse("https://api.github.com/gists")
            request = Net::HTTP::Post.new(uri)
            request.basic_auth("JoelAlayon123", "682807ccf3ed3f1700ada5d590f27da282ab2576")

            request.body = JSON.dump({
                "description" => "#{description}",
                "public" => state,
                "files" => {
                    "#{filename}" => {
                        "content" => "#{@content}"
                    }
                }})

            req_options = {use_ssl: uri.scheme == "https",}

            begin
                response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
                    http.request(request)
            end
                
            json = response.body
            parsed = JSON.parse(json)
            response_status = "#{response.code}"

            if response_status== "201"
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
        
        if File.exist?("#{route}")
            puts "---Añade una descripción---"
            puts "========================================================================================"
            description = gets.chomp
            puts "========================================================================================"
            puts"---Quieres que tu repositorio sea publico?---"
            puts "========================================================================================"
            state = gets.chomp.capitalize
            puts "========================================================================================"

            if state == "Si" 
                state = true;
            elsif state == "No"
                state = false;
            else
                puts "Responde si o no..."
            end

            only_files = Dir.glob("#{route}"+'/**/*').reject do |path|
                File.directory?(path)
            end
            
            @bar ={:description => description,:public => state,:files =>{}}
            
            only_files.each do |f|
                @name = Pathname.new("#{f}").basename 
                puts @name

                open(f, "r:UTF-8") do |file| # Leer el contenido del archivo
                    @content = file.read()
                    @bar[:files][@name] = {:content => @content}
                end
            end
            
            puts "========================================================================================"
            puts @bar
            @bar = @bar.to_json
            uri = URI.parse("https://api.github.com/gists")
            request = Net::HTTP::Post.new(uri)
            request.basic_auth("JoelAlayon123", "682807ccf3ed3f1700ada5d590f27da282ab2576")
            request.body = @bar
            
            req_options = {
              use_ssl: uri.scheme == "https",
            }
            
            begin
                response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
                   http.request(request)
            end
            
            json = response.body
            parsed = JSON.parse(json)
            response_status = "#{response.code}"
        
            if response_status == "201"
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