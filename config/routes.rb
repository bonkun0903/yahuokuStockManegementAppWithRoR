Rails.application.routes.draw do

  get 'homes/index'
  namespace :api, { format: "json" } do
    namespace :v1 do
      resources :todos, :only => [:index, :show, :create, :update, :destroy]
    end
  end
end