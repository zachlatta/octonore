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

    it "should have a name attribute" do
      template.should respond_to :name
    end

    it "should have the right name" do
      template.name.should eq('C')
    end

  end

  describe "GET template" do

    let(:template) { Octonore::Template.new('C') }

    before { VCR.insert_cassette 'template', :record => :new_episodes }

    after { VCR.eject_cassette }

    it "should have a data method" do
      template.should respond_to :data
    end

    it "should parse the api response from JSON to Hash" do
      template.data.should be_instance_of Hash
    end

    it "should get the right data" do
      template.data["name"].should eq('C')
    end
    
    describe "caching" do

      before do
        template.data
        stub_request(:any, /api.github.com/).to_timeout
      end

      it "must cache the data" do
        template.data.should be_instance_of Hash
      end

      it "must refresh the data if forced" do
        lambda { template.data(true) }.should raise_error Timeout::Error
      end

    end

  end

end
