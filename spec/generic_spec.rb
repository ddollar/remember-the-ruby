$:.push('lib')
require 'generic'
include Generic

describe Generic do
  
  describe 'rspec' do

    it "should have a version" do
      lambda { Generic.version }.should_not raise_error
    end
    
    it "should have a libpath" do
      lambda { Generic.libpath }.should_not raise_error
    end
    
    it "should have a path" do
      lambda { Generic.path }.should_not raise_error
    end

  end
  
end