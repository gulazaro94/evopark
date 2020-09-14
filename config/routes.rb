Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: redirect('/reminders')

  resources(:sessions, only: []) do
    collection do
      get(:sign_in)
      post(:authenticate)
      delete(:unauthenticate)
    end
  end

  resources(:reminders, only: [:index])
end
