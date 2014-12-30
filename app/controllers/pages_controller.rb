class PagesController < ApplicationController
  def home
  	@titre = "Accueil" #lie l'action a la vue, il suffira de rappeler cette variable dans la vue
  end

  def contact
  	@titre = "Contact"
  end
  
  def about
  	@titre = "A propos"
  end
  
  def help
  	@titre = "Aide"
  end
  
end
