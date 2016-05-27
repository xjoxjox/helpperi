class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update]

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.active
    if current_user
      @user_posts = current_user.posts
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
    @edit = false
  end

  # GET /posts/1/edit
  def edit
    @edit = true
  end

  # POST /posts
  # POST /posts.json
  def create
    if current_user
      @post = Post.new(post_params)
      @post.user_id = current_user.id
      @post.deleted = false

      respond_to do |format|
        if @post.save
          format.html { redirect_to @post, notice: 'Ilmoitus luotu onnistuneesti.' }
          format.json { render :show, status: :created, location: @post }
        else
          format.html { render :new }
          format.json { render json: @post.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params) and @post.user == current_user
        format.html { redirect_to @post, notice: 'Ilmoitus muokattu onnistuneesti.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def delete_post
    post = Post.find(params[:post_id])
    if post.user.id == current_user.id
      post.update_attribute(:deleted, true)
    end
    if post.deleted
      redirect_to posts_url, notice: 'Ilmoitus on poistettu onnistuneesti.'
    else
      redirect_to back, notice: 'Ilmoitusta ei voitu poistaa. Ole yhteydessä asiakaspalveluun.'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :description, :price)
    end
end