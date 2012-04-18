require 'spec_helper'

describe Site do
  context "parseable" do 
    it "should say the site is parseable" do
      site = Site.make
      site.parseable?.should == true
    end

    it "should say the site is not parseable" do
      site = Site.new
      site.parseable?.should == false
    end
  end
  
end
