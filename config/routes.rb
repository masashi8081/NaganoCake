Rails.application.routes.draw do

  namespace :admin do
    get  "/" => "homes#top"
    resources :customers, only: [:index, :show, :edit, :update]
    resources :items, only: [:new, :show, :edit, :index, :create, :update]
    resources :orders, only: [:new, :index, :show]
  end

  scope module:  :public do
    resources :cart_items, only: [:index, :create, :destroy, :update]
    resources :customers, only: [:show, :update, :edit, :quit]
    resources :items, only: [:index, :show]
    root to: "homes#top"
    get '/home/about' => 'homes#about', as: 'about'
  end

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: 'admin/sessions'
  }

  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
