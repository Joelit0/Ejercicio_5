require 'net/http'
require 'json'
require 'uri'
require 'dotenv/load'
require 'rspec'
# Esta clase es la encargada de crear un Gist, utilizando la API de GitHub.
# @author Joel Alayon.
# @since 0.9.24
class Gist
    # Esta variable almacena el estado del posteo.
    # @return [String] estado del posteo.
    # @example Posteo correcto:
    #   response_status = "201"
    # @example Error de conexión:
    #   response_status = "400"
    attr_reader :response_status
    # Esta variable almacena la respuesta del usuario, con respecto a si quiere intentar otra vez.
    # @note En caso de que haya un error de conexión, se le preguntará al usuario si quiere intentar otra vez.
    # @return [String] respuesta del usuario.
    # @example Si el usuario quiere intentar otra vez:
    #   try_again = "Si"
    # @example Si el usuario NO quiere intentar otra vez:
    #   try_again = "No"
    attr_reader :try_again
    # @author Joel Alayon.
    # Recibe los parametros necesarios de instancia para poder instanciar el objeto.
    # @note Los parametros del metodo de instancia se los pasa el usuario.
    
    def initialize(filename, description, state, content)
        @filename = filename
        @description = description
        @state = state
        @content = content
    end

    # @author Joel Alayon.
    # Recibe los parametros necesarios para poder realizar la petición HTTP a la API.
    # @note Los parametros de este metodo NO se los pasa el usuario.
    # @see https://developer.github.com/v3/gists/ URL de la API.
    def post(uri, request)
        request.basic_auth(ENV['YOUR_USERNAME'], ENV['YOUR_TOKEN'])
        request.body = JSON.dump({"description" => @description,"public" => @state,"files" => {@filename => {"content" => @content}}})
        req_options = { use_ssl: uri.scheme == "https" }
        
        begin
            response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
                http.request(request)
        end
        
        json = response.body
        parsed = JSON.parse(json)
        @response_status = response.code

        if @response_status == "201"
            puts "Tu gist se ha creado con exito. La URL de su gist es: "+ parsed["url"]
        end

        rescue SocketError => se
            puts "Ha ocurrido un error de conexión. Quiere intentar nuevamente?"
            @try_again = gets.chomp.capitalize
        end
    end
end

loop do
    puts "---Ingrese el nombre del archivo que quiere subir como un Gist de GitHub--- "
    puts "---No se olvide de finalizar el archivo con '.txt'---"
    filename = gets.chomp
    
    if File.exist?(filename) 
        puts "---Añade una descripción---"
        description = gets.chomp
        puts "---Quieres que tu repositorio sea publico?---"
        state = gets.chomp.capitalize

        if state == "Si" 
            state = true;
        elsif state == "No"
            state = false;
        else
            puts "Responde Si o No..."
        end

        open(filename, "r") { |file| @content_file = file.read() } 
        content = @content_file
        GITHUB_URL = "https://api.github.com/gists"
        uri = URI.parse(GITHUB_URL)
        request = Net::HTTP::Post.new(uri)
        gist = Gist.new(filename,description,state,content)
        gist.post(uri, request)
        
        break if gist.response_status == "201"
        break if gist.try_again == "No"
    else
        puts "El archivo no existe..."
        puts "Queres intentar de nuevo?"
        continue = gets.chomp.capitalize
        break if continue == "No"
    end
end