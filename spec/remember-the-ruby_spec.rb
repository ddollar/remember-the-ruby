$:.push('lib')
require 'remember-the-ruby'
include RememberTheRuby

describe RememberTheRuby do
  
  describe 'api' do

    
    it "should have a version" do
      lambda { RememberTheRuby.version }.should_not raise_error
    end
    
    it "should have a libpath" do
      lambda { RememberTheRuby.libpath }.should_not raise_error
    end
    
    it "should have a path" do
      lambda { RememberTheRuby.path }.should_not raise_error
    end

  end
  
end