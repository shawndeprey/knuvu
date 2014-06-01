Knuvu::Application.routes.draw do
  #namespace :api, :constraints => {:format => 'json'} do
  #  namespace :v1 do
  #    resources :betalists
  #  end
  #end

  #admin_constraint = lambda { |request| request.env["rack.session"]["user_id"] && User.find(request.env["rack.session"]["user_id"]).admin? }
  #constraints admin_constraint do
  #  mount Sidekiq::Web => '/admin/sidekiq'
  #end

  #root 'default#index'
  #get  '*path' => 'default#index'
end