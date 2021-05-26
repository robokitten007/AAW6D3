class UsersController < ApplicationController

  def index 
    @users = User.all
    render json: @users
  end

  def create
    @user = User.new(user_params)  
    if @user.save
      render json: @user
    else
      render json: @user.errors.full_messages, status: :unprocessable_entity
    end
  end 

  def show 
    user = User.find(params[:id])
    render json: user
  end 

  def user_params
    params.require(:user).permit(:name, :email) # keep in mind for assessment   # prefixes are the helper methods
  end
    # Using a private method to encapsulate the permissible parameters
    # is just a good pattern since you'll be able to reuse the same
    # permit list between create and update. Also, you can specialize
    # this method with per-user checking of permissible attributes.

  def update
    @user = User.find(params[:id]) # for practice assessment, no update method 
    if @user.update(user_params) # but you have to build it yourself
      redirect_to user(@user) # know the difference between create and update 
    else
      render json:@user.errors.full_messages, status: unprocessable_entity
    end
  end

  def destroy
      @user = User.find(params[:id])
      @user.destroy
      # redirect_to users
  end

end

=begin 
find_by(*args) public

Finds the first record matching the specified conditions. 
There is no implied ordering so if order matters, you should specify it yourself.

If no record is found, returns nil.

Post.find_by name: 'Spartacus', rating: 4
Post.find_by "published_at < ?", 2.weeks.ago

=end



=begin 

Specifying a resource route will also create a number of routing
helper methods that your controllers and views can use to build
URLs. In the case of resources :photos:
photos_url	http://www.example-site.com/photos
new_photo_url	http://www.example-site.com/photos/new
photo_url(@photo)	http://www.example-site.com/photos/#{@photo.id}
edit_photo_url(@photo)	http://www.example-site.com/photos/#{@photo.id}/edit

=end