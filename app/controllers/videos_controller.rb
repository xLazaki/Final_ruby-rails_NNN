class VideosController < ApplicationController
  before_action :set_video, only: %i[ show edit update destroy ]

  # GET /videos or /videos.json
  def index
    @videos = Video.all
  end

  # GET /videos/1 or /videos/1.json
  def show
    if session[:user_id]== nil
      redirect_to login_path
    end
    @current_user = User.find_by(id:session[:user_id])
    if @current_user != nil
    @channel_followed= @current_user.channels
    end
    @video = Video.find_by(id:params[:id])
    @channel = @video.channel
    @comments = Comment.where(video_id:@video.id)
  end

  # GET /videos/new
  def new
    @video = Video.new
  end
  def create_comment
    @video = Video.find_by(id:params[:id])
    @comment = Comment.new()
    @comment.user_id = User.find_by(id:session[:user_id]).id
    @comment.comment = params[:body]
    @comment.video_id = @video.id
    @comment.save
    redirect_to video_path(@video.id)

  end
  def like
    @video = Video.find_by(id:params[:id])
    @current_user = User.find_by(id:session[:user_id])
    @new_like = Like.new(user_id:@current_user.id,video_id:@video.id)
    @new_like.save
    redirect_to video_path(@video.id)
  end
  def unlike
    @video = Video.find_by(id:params[:id])
    @current_user = User.find_by(id:session[:user_id])
    @destroy = Like.find_by(user_id:@current_user.id,video_id:@video.id)
    @destroy.destroy
    redirect_to video_path(@video.id)
  end
  def unfollow_tag
    @current_user = User.find_by(id:session[:user_id])
    @destroy = Tag.find_by(tag_name:params[:tag],user_id:@current_user.id)
    @destroy.destroy
    redirect_to select_tag_path
  end
  def follow_tag
    @current_user = User.find_by(id:session[:user_id])
    @follow = Tag.new(tag_name:params[:tag],user_id:@current_user.id)
    @follow.save
    redirect_to select_tag_path

  end
  # GET /videos/1/edit
  def edit
  end
  def select_tag
    if session[:user_id]== nil
      redirect_to login_path
    end
    @current_user = User.find_by(id:session[:user_id])
    if @current_user != nil
    @channel_followed= @current_user.channels
    end
  end
  def show_tag
    if session[:user_id]== nil
      redirect_to login_path
    end
    @current_user = User.find_by(id:session[:user_id])
    if @current_user != nil
    @channel_followed= @current_user.channels
    end
    @allvideo = Video.where(:tag => params[:name_tag])
  end

  # POST /videos or /videos.json
  def create
    @current_user = User.find_by(id:session[:user_id])
    if @current_user != nil
    @channel_followed= @current_user.channels
    end
    @video = Video.new(video_params)
    @channel = Channel.find_by(user_id:session[:user_id])
    @video.channel_id = @channel.id
    respond_to do |format|
      if @video.save
        format.html { redirect_to @video, notice: "Video was successfully created." }
        format.json { render :show, status: :created, location: @video }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @video.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /videos/1 or /videos/1.json
  def update
    respond_to do |format|
      if @video.update(video_params)
        format.html { redirect_to @video, notice: "Video was successfully updated." }
        format.json { render :show, status: :ok, location: @video }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @video.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /videos/1 or /videos/1.json
  def destroy
    @video.destroy
    respond_to do |format|
      format.html { redirect_to videos_url, notice: "Video was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_video
      @video = Video.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def video_params
      params.require(:video).permit(:title, :description, :tag, :clip ,:thumbnail)
    end
end
