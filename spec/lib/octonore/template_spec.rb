require_relative '../../spec_helper'

describe Octonore::Template do

  describe "default attributes" do

    it "should have httparty methods" do
      Octonore::Template.should include(HTTParty)
    end

    it "should have the base url set to the Github API gitignore endpoint" do
      Octonore::Template.base_uri.should eq('https://api.github.com/gitignore')
    end

  end

  describe "default instance attributes" do

    let(:template) { Octonore::Template.new('C') }

    before { VCR.insert_cassette 'template', :record => :new_episodes }

    after { VCR.eject_cassette }

    it "should have a name attribute" do
      template.should respond_to :name
    end

    it "should have a source attribute" do
      template.should respond_to :source
    end

    it "should have the right name" do
      template.name.should eq('C')
    end

  end

  describe "GET template" do

    let(:template) { Octonore::Template.new('C') }

    before { VCR.insert_cassette 'template', :record => :new_episodes }

    after { VCR.eject_cassette }

    it "should have an update method" do
      template.should respond_to :update
    end

    it "should get update data from Github" do
      template.source = nil
      template.update
      template.source.should_not equal nil
    end
    
  end

end
