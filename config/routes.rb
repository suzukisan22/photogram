Rails.application.routes.draw do

  resources :user, only: [:index]

  resources :relationships, only: [:create, :destroy]

  resources :requests, only: [:create, :show, :destroy] do
    collection do
      patch :admit
    end
  end

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  resources :pictures do
    member do
      get :liking_users
    end
    resources :comments
  end

  resources :conversations do
    resources :messages
  end

  post '/like/:picture_id' => 'likes#like', as: 'like'
  delete '/unlike/:picture_id' => 'likes#unlike', as: 'unlike'


  devise_for :users, controllers: {
    registrations: "users/registrations",
    omniauth_callbacks: "users/omniauth_callbacks"
}

  get '/search', to: 'user#search'

  # Userログイン時
  authenticated :user do
    root :to => "pictures#index", :as => "authenticated_root"
  end


  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

  get '/:username', to: 'about#index', as: "user_profile"
  get '/:username/following', to: 'about#following', as: "following"
  get '/:username/follower', to: 'about#follower', as: "follower"

  # User非ログイン時
  root "top#index"

end
