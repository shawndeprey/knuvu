require 'sidekiq/web'

Knuvu::Application.routes.draw do
  namespace :api, constraints: {format: 'json'} do
    namespace :v1, constraints: {format: 'json'} do
      # Users
      post '/users/password_reset_request' => 'users#password_reset_request'
      post '/users/reset_password' => 'users#reset_password'

      # Rails Generated
      resource :session
      resources :users
    end
  end

  admin_constraint = lambda { |request| request.env["rack.session"]["user_id"] && User.find(request.env["rack.session"]["user_id"]).admin? }
  constraints admin_constraint do
    mount Sidekiq::Web => '/admin/sidekiq'
  end

  root 'default#index'
  get  '*path' => 'default#index'
end