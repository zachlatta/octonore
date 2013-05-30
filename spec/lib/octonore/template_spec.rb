require_relative '../../spec_helper'

describe Octonore::Template do

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

    it "should have a reload method" do
      template.should respond_to :reload
    end

    it "should reload data from Github" do
      template.source = nil
      template.reload
      template.source.should_not equal nil
    end

    it "should raise an error if template doesn't exist" do
      expect {
        bad_template = Octonore::Template.new('invalid') }.to raise_error
    end

    it "should list gitignore templates" do
      templates = Octonore::Template.list      
      templates.should be_an_instance_of Array
      templates.should include("C")
    end
    
  end

end
