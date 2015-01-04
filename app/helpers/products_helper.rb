module ProductsHelper
	def current_user=(user)
		@current_user = user
	end
	
	def is_empty?
		@user = User.find(params[:id])
		@product = Product.find(params[user.id]).nil?
	end
end
