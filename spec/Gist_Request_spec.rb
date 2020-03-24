require_relative '../Gist_Request.rb'
require 'spec_helper'

RSpec.describe GistRequest do
  describe "#post" do
    it "campos no válidos" do
      filename = "test.txt"
      description = "descripción"
      state = true
      content = "contenido"
      gist_create = GistRequest.new(filename, content, state, description)
      gist_create.post()
      expect(gist_create.response_status).to eq "422"
    end
   
    it "gist creado" do
      filename = "test.txt"
      description = "descripción"
      state = true
      content = "contenido"
      gist_create = GistRequest.new(description ,state ,filename ,content )
      gist_create.post()
      expect(gist_create.response_status).to eq "201"
    end
  end
end
   
  

  