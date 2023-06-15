Rails.application.routes.draw do
 
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
    root "home#index"
    devise_for :users, controllers: { registrations: "users/registrations" }
    post 'exercises/:exercise_id/submissions', to: 'submissions#create'
    resources :exercises do 
      resources :submissions
    
    end 
    get "lib/odsaUtils-min.js" => proc { [200, {}, [File.read(Rails.root.join("public", "lib", "odsaUtils.js"))]] }
    get "lib/odsaAV-min.js" => proc { [200, {}, [File.read(Rails.root.join("public", "lib", "odsaAV.js"))]] }
   
    
    
end
