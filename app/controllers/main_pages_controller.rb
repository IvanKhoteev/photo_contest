class MainPagesController < ApplicationController

  def index
  	@photo_galleries = PhotoGallery.all
  end

end
