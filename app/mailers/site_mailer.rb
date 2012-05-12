class SiteMailer < ActionMailer::Base
  default from: "ringomercedes@gmail.com"

  def site_cataloged_email(site)
    @user = site.user
    @site  = site
    mail(:to => @user.email, :subject => "The site you added has been cataloged.")
  end
end
