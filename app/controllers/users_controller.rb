class UsersController < ApplicationController

	before_filter :authenticate, :only => [:edit, :update]	
	
	def index
		@users = User.all
	end
	
  def new
  	@user = User.new
  	@titre = "Inscription"
  end
  
  def create
  	@user = User.new(user_params)
  		if@user.save
  			sign_in @user
  			#flash[:success] = "Bienvenu dans notre application Ruby on Rails !"
  			redirect_to @user
  		else
  			@titre = "Inscription"
  			render 'new'
  		end
  end
    
  def show
  	@user = User.find(params[:id])
  	@titre = @user.nom
  end
  
  def edit
  	@user = User.find(params[:id])
  	@titre = "Edition profil"
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profil actualisé."
      redirect_to @user
    else
      @titre = "Édition profil"
      render 'edit'
    end
  end
  
  def destroy
  	@user = User.find(params[:id]).destroy
  	redirect_to users_path
  end
  
  private
  
  def user_params
      params.require(:user).permit(:nom, :email, :password, :password_confirmation)
  end
  
  def authenticate
  	deny_access unless signed_in?
  end
  
  def correct_user
  	@user = User.find(params[:id])
  	redirect_to(root_path) unless current_user?(user)
  end
  
  def admin_user
  	redirect_to(root_path) unless current_user.admin?
  end

end
