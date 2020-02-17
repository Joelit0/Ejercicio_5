require './git_clases.rb'

RSpec.describe Gist do
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

      it "error al crear gist" do
        filename = "test.txt"
        description = "descripción"
        state = true
        content = "contenido"
  
        gist = described_class.new(filename, description, state, content)
  
        uri = URI.parse("https://api.github.com/gists")
        request = Net::HTTP::Post.new(uri)
        gist.post(uri, request)
  
        expect(gist.response_status).to eq 400
      end
    end
  end