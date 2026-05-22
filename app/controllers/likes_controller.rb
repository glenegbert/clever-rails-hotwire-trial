class LikesController < ApplicationController
  before_action :set_photo

  def create
    @like = @photo.likes.find_or_create_by(user: current_user)
    @photo = Photo.with_likes_count.find(params[:photo_id])
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to photos_path }
    end
  end

  def destroy
    current_user.likes.find_by(id: params[:id])&.destroy
    @like = nil
    @photo = Photo.with_likes_count.find(params[:photo_id])
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to photos_path }
    end
  end

  private

  def set_photo
    @photo = Photo.find(params[:photo_id])
  end
end
