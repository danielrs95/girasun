class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy]
  before_action :require_admin, except: %i[index show]

  def index
    @posts = Post.all
  end

  def show
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to @post, notice: 'Post creado exitosamente'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to @post, notice: 'Post actualizado exitosamente'
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])

    Post.transaction do
      @post.destroy
    end

    redirect_to posts_path, notice: 'El post ha sido eliminado exitosamente.'
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :content)
  end
end
