require 'open-uri'
class SitesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :authenticate_admin, :except => [:cataloged, :add_site]

  # GET /sites
  # GET /sites.json
  def index
    @sites = Site.order("created_at").page(params[:page]).per(10)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @sites }
    end
  end

  def cataloged
    @sites = Site.cataloged.order("created_at").page(params[:page]).per(10)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @sites }
    end
  end

  def add_site
    @sites = Site.cataloged.order("created_at").page(params[:page]).per(10)
    @site = Site.new

    url = URI.parse(params[:url])
    @site.url = url.to_s
    @site.user = current_user

    if url.class == URI::HTTP || url.class == URI::HTTPS # user entered full url i.e. http://www.taste.com.au
      @site.domain = url.host
    else
      @site.domain = url.to_s 
    end

    if @site.save
      flash[:notice] = "Thanks for requesting #{@site.domain}. You will get an email when this site has been cataloged."
    else
      flash[:notice] = "Sorry, something went wrong. Please try again."
    end

    render action: "cataloged"
  end

  # GET /sites/1
  # GET /sites/1.json
  def show
    @site = Site.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @site }
    end
  end


  # GET /sites/new
  # GET /sites/new.json
  def new
    @site = Site.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @site }
    end
  end

  # GET /sites/1/edit
  def edit
    @site = Site.find(params[:id])
  end

  # POST /sites
  # POST /sites.json
  def create
    @site = Site.new(params[:site])

    respond_to do |format|
      if @site.save
        format.html { redirect_to @site, notice: 'Site was successfully created.' }
        format.json { render json: @site, status: :created, location: @site }
      else
        format.html { render action: "new" }
        format.json { render json: @site.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /sites/1
  # PUT /sites/1.json
  def update
    @site = Site.find(params[:id])

    respond_to do |format|
      if @site.update_attributes(params[:site])
        if @site.parseable? && !@site.user.blank?
          SiteMailer.site_cataloged_email(@site).deliver
        end
        format.html { redirect_to @site, notice: 'Site was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @site.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sites/1
  # DELETE /sites/1.json
  def destroy
    @site = Site.find(params[:id])
    @site.destroy

    respond_to do |format|
      format.html { redirect_to sites_url }
      format.json { head :no_content }
    end
  end

  private

  def authenticate_admin
    if current_user
      unless current_user.is_admin?
        redirect_to :controller => :recipes
      end
    else
      redirect_to :controller => :recipes
    end
  end
end
