Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
	  namespace :v1 do
		  resources :messages do 
		  	collection do 
		  		get :get_public_messages
		  	end
		  end

		  resources :groups do 
		  	member do 
		  		get :get_members
		  		post :set_members
		  		post :remove_members
		  	end
		  end

		end
	end
end
