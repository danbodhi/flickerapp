class HomeController < ApplicationController
  def index
  end
  
  def search
    @search_text = CGI::escape(params[:photosearch])
    @json_body = search_flickr(@search_text)
    
    respond_to do |format|
      format.html
      format.js
    end
  end
  
  def get_page
    @search_text = params[:photosearch]
    page_num = params[:page]
    @json_body = search_flickr(@search_text, page_num)
    
    respond_to do |format|
      format.html
      format.js { render "search" }
    end
  end
  
  private
  
    def search_flickr(search_text, page_num = "1")
      url_str = FLICKR_API_BASE_URL + '?method=flickr.photos.search&api_key=' + FLICKR_API_KEY + '&text=' + search_text + "&format=json&per_page=36&nojsoncallback=1&page=" + page_num
      uri = URI(url_str)

      Net::HTTP.start(uri.host, uri.port) do |http|
        request = Net::HTTP::Get.new uri.request_uri

        @response = http.request request      
      end
      return @response.body.html_safe
    end
end
