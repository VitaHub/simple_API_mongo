Rails.application.routes.draw do
  	get '/' => "artists#index"
  	get '/:id' => "artists#show"

	match '*any' => 'application#options', :via => [:options] 
end
