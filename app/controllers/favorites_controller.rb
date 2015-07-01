class FavoritesController < ApplicationController

  def create
    post = Post.find(params[:post_id])
    favorite = current_user.favorites.build(post: post)

    authorize favorite

    if !favorite.save
      flash[:error] = "Unable to favorite post. Please try again."
    end

    redirect_to [post.topic, post]
  end

  def destroy
    post = Post.find(params[:post_id])
    favorite = current_user.favorites.find(params[:id])

    authorize favorite

    if !favorite.destroy
      flash[:error] = "Unable to unfavorite post. Please try again."
    end

    redirect_to [post.topic, post]
  end

end
