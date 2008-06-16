$:.push('lib')
require 'remember-the-ruby'
include RememberTheRuby

require File.join(File.dirname(__FILE__), 'settings')

describe RememberTheRuby::API do

  before(:all) do
    @api = api_from_settings
  end

  it "should not be nil" do
    @api.should_not be_nil
  end
  
  it "should return an EntityList for #lists" do
    @api.lists.should be_an_instance_of(EntityList)
  end
  
  it "should return a Hash for #settings" do
    @api.settings.should be_an_instance_of(Hash)
  end
  
  it "should return an EntityList for #tags" do
    @api.tags.should be_an_instance_of(EntityList)
  end
  
  it "should return an EntityList for #tasks" do
    @api.tasks.should be_an_instance_of(EntityList)
  end
  
end