Rails.application.routes.draw do
  namespace :users do
    get 'profiles/show'
    get 'profiles/edit'
    get 'profiles/update'
    resource :profile, only: %i[show edit update], controller: 'profiles'
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root 'home#index'

  devise_for :users, controllers: { registrations: 'users/registrations' }

  post 'exercises/:exercise_id/submissions', to: 'submissions#create'

  resources :exercises do
    resources :submissions
  end

  devise_scope :user do
    get '/users/sign_out', to: 'devise/sessions#destroy'
  end
  # to get all user submissions
  get 'users/:id/submissions', to: 'submissions#user_submissions', as: 'user_submissions'
  get 'submissions/:id', to: 'submissions#show', as: 'submission'

  # to get all exercises that create by user
  get 'users/:id/exercises', to: 'exercises#user_exercises', as: 'user_exercises'
  # get 'exercises/:id', to: 'exercises#show', as: 'exercises'

  get 'lib/odsaUtils-min.js' => proc { [200, {}, [File.read(Rails.root.join('public', 'lib', 'odsaUtils.js'))]] }
  get 'lib/odsaAV-min.js' => proc { [200, {}, [File.read(Rails.root.join('public', 'lib', 'odsaAV.js'))]] }

  resources :groups do
    resources :members, only: %i[create destroy]
  end

  Rails.application.routes.draw do
    resources :groups do
      resources :members, only: %i[create destroy]
    end
  end

  resources :groups do
    resources :tasks
  end
  resources :groups, only: %i[new create show] do
    post 'group_tasks', on: :member
  end

  resources :groups, only: %i[new create show] do
    post 'tasks', to: 'tasks#create'
  end
  get 'editor', to: 'editor#index'
  get 'editor/fa', to: 'editor#fa'
  get 'editor/pda', to: 'editor#pda'
  get 'editor/reTOfa', to: 'editor#reTOfa'
  get 'editor/tm', to: 'editor#tm'
  get 'editor/grammar', to: 'editor#grammar'
  get 'editor/fAFixer', to: 'editor#fAFixer'

  get '/FA.html', to: redirect('/editor/fa')
  get '/FAFixer.html', to: redirect('/editor/fAFixer')
  get '/user_submissions', to: 'submissions#user_submissions'
  get '/groups/:id/dashboard', to: 'groups#dashboard', as: 'group_dashboard'
end
