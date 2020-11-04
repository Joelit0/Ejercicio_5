require_relative '../Gist_Request.rb'
require 'spec_helper'

filename = "test.txt"
description = "descripción"
state = true
content = "contenido"

RSpec.describe GistRequest do
  describe "#post" do
    it "should return 422 if fields are invalid" do
      gist_create = GistRequest.new(filename, content, state, description)
      gist_create.post()
      expect(gist_create.response_status).to eq HTTP_STATUS_INVALID
    end
   
    it "should return 201 if fields are valid" do
      gist_create = GistRequest.new(description, state, filename, content )
      gist_create.post()
      expect(gist_create.response_status).to eq HTTP_STATUS_CREATED
    end
  end
end
