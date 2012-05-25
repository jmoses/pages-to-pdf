class PagesController < ApplicationController
  before_filter :ensure_url, :except => :index
  def index
  end

  def create
    page = Page.new params[:url]

    begin
      send_data page.pdf, :filename => File.basename(page.url, '.pages') + ".pdf", :type => "application/pdf"
    rescue => ex
      redirect_to pages_path(:url => params[:url]), :error => "Processing the file raised an error: #{ex.class.name}"
    end
  end

  def show
    @page = Page.new params[:url] 
  end

  protected
    def ensure_url
      unless params[:url].present?
        redirect_to pages_path, :alert => "Please supply a url."
        return false
      end
    end

end
