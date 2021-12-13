class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]
  # GET /users or /users.json
  def main
    if session[:user_id]== nil
      redirect_to login_path
    end
    @channel= Channel.find_by(user_id:session[:user_id])
    @follow_tag = Tag.where(user_id:session[:user_id])
    @current_user = User.find_by(id:session[:user_id])
    if @current_user != nil
    @channel_followed= @current_user.channels
    end
  end
  def check_login
    @email = params[:email]
    @password = params[:password]
    @user = User.find_by(email:@email)
    puts @password
    respond_to do |format|
      unless(@user.present? && @user.authenticate(@password))
        format.html { redirect_to login_path , alert: "Email/password not valid" }
      else
        session[:user_id] = @user.id
        format.html{ redirect_to main_path, notice: "Login successfully"}
      end
    end
  end
  def login
    session[:user_id] = nil
  end
  def logout
    session[:user_id] = nil
    redirect_to login_path , notice: "Log out successfully"
  end
  def index
    @users = User.all
  end
  def test
  end

  # GET /users/1 or /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to login_path, notice: "User was successfully created." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:username, :email, :password )
    end
end
