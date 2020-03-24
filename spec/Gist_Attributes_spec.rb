require_relative '../Gist_Attributes.rb'
require 'spec_helper'

RSpec.describe GistAttributes do
  describe "File_exist" do
    it "Archivo existente" do
      filename = "Main.rb"
      description = "Holas"
      state = true
      gist_attributes = GistAttributes.new(filename, description, state)
      gist_attributes.file()

      expect(gist_attributes.gist_attr.response_status).to eq "201"
    end

    it "Archivo inexistente" do
      filename = "error.rb"
      description = "Holas" 
      state = true
      gist_attributes = GistAttributes.new(filename, description, state)
      gist_attributes.file()
      expect { gist_attributes.file() }.to output("Su archivo no existe\n").to_stdout
    end
  end
end
   
  

  