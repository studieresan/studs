class MainController < ApplicationController
  def index
  	@posts = Post.where(published: true).order("created_at DESC").limit(2)
  end

  def earlier
  end

  def contact
  end

  def pub
  end
end
