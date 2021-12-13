class ChannelsController < ApplicationController
  before_action :set_channel, only: %i[ show edit update destroy ]

  # GET /channels or /channels.json
  def index
    @channels = Channel.all
  end
  # GET /channels/1 or /channels/1.json
  def show
    @current_user = User.find_by(id:session[:user_id])
    @channel_followed= @current_user.channels
    @channel = Channel.find_by(id:params[:id])
    @allvideo = @channel.videos
    puts @channel.user_id
    puts @current_user.id
  end
  def my_channel
    @current_user = User.find_by(id:session[:user_id])
    @channel_followed= @current_user.channels
    @channel = Channel.find_by(user_id:session[:user_id])
    @allvideo = @channel.videos
  end
  def all_channel
    @channels = Channel.all
    @current_user = User.find_by(id:session[:user_id])
    @channel_followed= @current_user.channels
  end
  def this_channel
    @current_user = User.find_by(id:session[:user_id])
    @channel_followed= @current_user.channels
    @channel= Channel.find_by(channel_name:params[:channel.channel_name])
  end
  def follow
    @channel = Channel.find_by(id:params[:id])
    @current_user = User.find_by(id:session[:user_id])
    @new_follow = Follow.new(user_id:@current_user.id,channel_id:@channel.id)
    @new_follow.save
    redirect_to channel_path(@channel.id)
  end
  def unfollow
    @channel = Channel.find_by(id:params[:id])
    @current_user = User.find_by(id:session[:user_id])
    @destroy = Follow.find_by(user_id:@current_user.id,channel_id:@channel.id)
    @destroy.destroy
    redirect_to channel_path(@channel.id)
  end

  # GET /channels/new
  def new
    @current_user = User.find_by(id:session[:user_id])
    @channel_followed= @current_user.channels
    @channel = Channel.new
  end

  # GET /channels/1/edit
  def edit
  end
  # POST /channels or /channels.json
  def create
    @channel = Channel.new(channel_params)
    @channel.user_id = session[:user_id]
    respond_to do |format|
      if @channel.save
        format.html { redirect_to @channel, notice: "Channel was successfully created." }
        format.json { render :show, status: :created, location: @channel }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @channel.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /channels/1 or /channels/1.json
  def update
    respond_to do |format|
      if @channel.update(channel_params)
        format.html { redirect_to my_channel_path, notice: "Channel was successfully updated." }
        format.json { render :show, status: :ok, location: @channel }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @channel.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /channels/1 or /channels/1.json
  def destroy
    @channel.destroy
    respond_to do |format|
      format.html { redirect_to channels_url, notice: "Channel was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_channel
      @channel = Channel.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def channel_params
      params.require(:channel).permit(:channel_name, :about, :user_id , :thumbnail)
    end
end
