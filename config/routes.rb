require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'

  root to: redirect('/reminders')

  resources(:users, only: [:new, :create])

  resources(:sessions, only: []) do
    collection do
      get(:sign_in)
      post(:authenticate)
      delete(:unauthenticate)
    end
  end

  resources(:reminders)
end
