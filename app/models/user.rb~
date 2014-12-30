class User < ActiveRecord::Base

	attr_accessor :password
	
	validates :nom, presence: true, length: {maximum: 50}
								 
	validates :email, presence: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }, uniqueness: {case_sensitive: false}
								 
	validates :password, presence: true, confirmation: true, length: 6..20
	
	before_save :encrypt_password
	
	
	# Retourne true si le mot de passe correspond.
	def has_password?(password_soumis)
		# Compare encrypted_password avec la version cryptée de password_soumis.
    encrypted_password == encrypt(password_soumis)
  end
  
  
  #Authentification de l'utilisateur
  def self.authenticate(email, submitted_password)
  	user = find_by_email(email)
  	
  	#(user && user.has_password?(submitted_password)? user : nil
  	
  	return nil if user.nil?
  	return user if user.has_password?(submitted_password)
  end
  
  def self.authenticate_with_salt(id, cookie_salt)
  	user = find_by_id(id)
  	(user && user.salt == cookie_salt)? user : nil
  	
  	#Ces deux lignes sont équivalentes à la ligne au dessus qui utilise l'opérateur ternaire
  	
  	#return nil if user.nil?
  	#return user if user.salt == cookie_salt
  end
	
	
	
	#Les fonctions qui suivent servent a sécuriser le mot de passe
	private
	
		#Crypte le mot de passe avec un "salt"
		def encrypt_password
			self.salt = make_salt if new_record? #new_record? retourne "true" si l'objet n'est pas dans la base de données
			self.encrypted_password = encrypt(password)
		end
		
		#Appelle la fonction de hashage pour crypter le mot de passe, en le mélangeant avec le salt
		def encrypt(string)
			secure_hash("#{salt}--#{string}")
		end
		
		#Génère un salt pour crypter le mot de passe
		def make_salt
			secure_hash("#{Time.now.utc}--#{password}")
		end
		
		#Fonction de hashage
		def secure_hash(string)
			Digest::SHA2.hexdigest(string)
		end
end
