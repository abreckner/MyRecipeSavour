require "spec_helper"

describe SiteMailer do
  describe "site_cataloged_email" do
    before :each do 
      @site = Site.make
      @user = User.make
      @site.user = @user
      @site.save!
      @mail = SiteMailer.site_cataloged_email @site
    end

    it "renders the headers" do
      @mail.subject.should eq("The site you added has been cataloged.")
      @mail.to.should eq(["test@test.com"])
      @mail.from.should eq(["ringomercedes@gmail.com"])
    end

    it "renders the body" do
      @mail.body.encoded.should include "The site you added (www.taste.com.au) has been cataloged"
      @mail.body.encoded.should include "You can now add recipes from www.taste.com.au either by url or by using the bookmarklet"
    end
  end
end
