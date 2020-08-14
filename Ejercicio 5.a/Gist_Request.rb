require 'net/http'
require 'json'
require 'uri'
require 'dotenv/load'
require 'rspec'

GITHUB_URL = "https://api.github.com/gists"
HTTP_STATUS_CREATED = "201"
HTTP_STATUS_INVALID = "422"

class GistRequest
  attr_reader :response_status, :try_again

  def initialize(filename, state, content, description)
    @filename = filename
    @state = state
    @content = content
    @description = description
  end

  def post()
    uri = URI.parse(GITHUB_URL)
    request = Net::HTTP::Post.new(uri)
    request.basic_auth(ENV['YOUR_USERNAME'], ENV['YOUR_TOKEN'])
    
    request.body = JSON.dump({ 
      "description" => @description,
      "public" => @state,
      "files" =>
        { @filename => { "content" => @content }}
      })
    
    req_options = { use_ssl: uri.scheme == "https" }
    
    begin
      response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
        http.request(request)
    end
    
    json = response.body
    parsed = JSON.parse(json)
    @response_status = response.code

    if @response_status == HTTP_STATUS_CREATED
      puts "Tu Gist se creó, la url es " + parsed["url"]
      puts "===================================================================================================="
    end

    rescue SocketError => se
      puts "Ocurrió un error de conexion, Quieres intentar de nuevo?"
      puts "===================================================================================================="
      @try_again = gets.chomp.capitalize
    end
  end
end
