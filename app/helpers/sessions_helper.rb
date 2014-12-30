module SessionsHelper
	
	#Fonction de connexion
	def sign_in(user)
		cookies.permanent.signed[:remember_token] = [user.id, user.salt]
		self.current_user = user
	end
	
	def current_user=(user)
		@current_user = user
	end
	
	#Fonction de définition de current_user
	def current_user
		#Appelle user_from_remember_token si @current_user n'est pas défini (donc au premier appel de current_user)
		@current_user ||= user_from_remember_token
	end
	
	#Fonction de vérification de connexion
	def signed_in?
		!current_user.nil?
	end
	
	def deny_access
		redirect_to signin_path, :notice => "Merci de vous identifier si vous souhaitez accéder à cette page"
	end
	
	#Fonction de déconnexion
	def sign_out
		cookies.delete(:remember_token)
		self.current_user = nil
	end
	
	private
		
		def user_from_remember_token
			#Authentification de l'utilisateur avec le sel défini pour le password
			User.authenticate_with_salt(*remember_token)
		end
		
		def remember_token
			cookies.signed[:remember_token] || [nil, nil]
		end
end
