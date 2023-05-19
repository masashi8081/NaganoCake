Rails.application.routes.draw do

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: 'admin/sessions'
  }

  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  namespace :admin do
    get  "/" => "homes#top"
    resources :customers, only: [:index, :show, :edit, :update]
    resources :items, only: [:new, :show, :edit, :index, :create, :update]
    resources :orders, only: [:show, :update]
  end

  scope module: :public do
    delete "/cart_items/destroy_all" => "cart_items#destroy_all"
    resources :cart_items, only: [:index, :create, :destroy, :update]
    get "/customers/quit" => "customers#quit"
    patch "/customers/out" => "customers#out"
    resources :customers, only: [:show, :update, :edit]
    resources :items, only: [:index, :show]
    post "/orders/confirm" => "orders#confirm"
    get "/orders/thanks" => "orders#thanks"
    resources :orders, only: [:new, :index, :show, :create]
    root to: "homes#top"
    get '/home/about' => 'homes#about', as: 'about'
  end



  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
