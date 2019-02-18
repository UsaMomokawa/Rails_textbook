Rails.application.routes.draw do
  devise_for :users,
  only: :omniauth_callbacks,
  controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  scope '(:locale)', locale: /en|ja/ do
    root 'books#index'
    get '/locale', to: 'books#index'
    resources :books
    devise_for :users,
    skip: :omniauth_callbacks,
    controllers: {
      registrations: 'users/registrations'
    }
  end
end
