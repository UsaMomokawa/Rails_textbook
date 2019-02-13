Rails.application.routes.draw do
  # We need to define devise_for just omniauth_callbacks:auth_callbacks otherwise it does not work with scoped locales
  # see https://github.com/plataformatec/devise/issues/2813
  devise_for :users, only: :omniauth_callbacks, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  scope "(:locale)" do
    root 'books#index'
    resources :books
    devise_for :users, skip: :omniauth_callbacks
  end
end
