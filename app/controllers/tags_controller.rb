class TagsController < ApplicationController
  def show
    @tag = Tag.find_by(name: params[:id].downcase)
    @microposts = @tag.microposts.paginate(page: params[:page]) if @tag
  end
end
