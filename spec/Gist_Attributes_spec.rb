require_relative '../Gist_Attributes.rb'
require 'spec_helper'

RSpec.describe GistAttributes do
  describe "exist?" do
    it "should be true if file exists" do
      filename = "Main.rb"
      description = "Hello"
      state = true
      gist_attributes = GistAttributes.new(filename, description, state)
      gist_attributes.file()

      expect(gist_attributes.gist_attr.response_status).to eq "201"
    end

    it "should be false if file doesn't exists" do
      filename = "error.rb"
      description = "Hello" 
      state = true
      gist_attributes = GistAttributes.new(filename, description, state)
      gist_attributes.file()
      expect { gist_attributes.file() }.to output("Su archivo no existe\n").to_stdout
    end
  end
end
   
