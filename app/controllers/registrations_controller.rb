# class RegistrationsController < Devise::RegistrationsController
#   before_filter :authenticate_user!, :only => :token

#     def new
#       super
#     end
  
#     def create
#       @user = User.new(params[:user])
#       if @user.save
#         # simple_sign_in @user
#         flash[:notice] = "You have signed up successfully. Currently NO e-mail will be send out to you though... ;-(."
#         redirect_to root_url
#       else
#         render :action => :new
#       end
#     end

#     def update
#       super
#     end
# end 
