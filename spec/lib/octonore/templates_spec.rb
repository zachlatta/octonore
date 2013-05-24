require_relative  '../../spec_helper.rb'

describe Octonore::Templates do

  describe "GET template" do

    before { VCR.insert_cassette 'templates', :record => :new_episodes }

    after { VCR.eject_cassette }

    it "should list gitignore templates" do
      templates = Octonore::Templates.list      
      templates.should be_an_instance_of Array
      templates.should include("C")
    end

    it "should get a specified template by name" do
      template = Octonore::Templates.get("C")
      template.values_at("name", "source").should_not include(nil)
    end

    it "should get a specified template by index" do
      template = Octonore::Templates.get_index(3)
      template.values_at("name", "source").should_not include(nil)
    end

    it "should get specified templates in an array" do
      templates = Octonore::Templates.get_array(["Java", "C"])
      templates[0].values_at("name", "source").should_not include(nil)
      templates[1].values_at("name", "source").should_not include(nil)
    end

    it "should raise an error if template name doesn't exist" do
      expect {
        bad_template = Octonore::Templates.get('invalid') }.to raise_error
    end

    it "should raise an error if template index doesn't exist" do
      template_count= Octonore::Templates.list.length

      expect {
        bad_template = Octonore::Templates.get_index(template_count + 1)
      }.to raise_error
    end

  end

end
