require '/Users/joel.alayon/Desktop/Moove-it/Apprenticeship - Basic/Ruby/Ejercicio 5/Ejercicio_5a/git_clases.rb'

describe Gist do
    describe "#post" do
      it "crear gist" do
        filename = "test.txt"
        description = "descripción"
        state = true
        content = "contenido"
  
        gist = described_class.new(filename, description, state, content)
  
        uri = URI.parse("https://api.github.com/gists")
        request = Net::HTTP::Post.new(uri)

        gist.post(uri, request)
  
        expect(gist.response_status).to eq 201
      end
    end
  end