class PhotosController < ApplicationController
  def index
    @photos = Photo.with_likes_count
    @liked_photo_ids = current_user.liked_photo_ids
  end
end
