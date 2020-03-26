require_relative 'Gist_Request'

class GistAttributes
  attr_reader :filename, :description, :content, :gist_attr
  
  def initialize(filename, description, state)
    @filename = filename
    @description = description
    @state = state
  end

  def file
    File.exist?(@filename) ? self.attributes : puts("Su archivo no existe")
  end

  def attributes
    open(@filename, "r:UTF-8") { |file| @content_file = file.read() } 
    content = @content_file
    @gist_attr = GistRequest.new(@filename, @state, content, @description)
    @gist_attr.post()
  end
end
