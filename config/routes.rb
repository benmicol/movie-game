Rails.application.routes.draw do
	root to: 'application#index'
	#resources :application
	#get '/play' => 'application#index'
	post '/play' => 'application#index', as: :play
end
