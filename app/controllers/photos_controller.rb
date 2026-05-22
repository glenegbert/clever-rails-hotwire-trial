class PhotosController < ApplicationController
  def index
    @photos = Photo.with_likes_count
    @likes_by_photo_id = current_user.likes.index_by(&:photo_id)
  end
end
