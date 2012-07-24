class HomeController < ApplicationController
  def index
  end
  
  def search
    uri = URI(FLICKR_API_BASE_URL + '?method=flickr.photos.search&api_key=' + FLICKR_API_KEY + '&text=' + params[:photosearch] + "&format=json&per_page=50&nojsoncallback=1")

    Net::HTTP.start(uri.host, uri.port) do |http|
      request = Net::HTTP::Get.new uri.request_uri

      @response = http.request request      
    end
    
    @json_body = @response.body.html_safe
    
    respond_to do |format|
      format.html
      format.js
    end

  end
end
