Rails.application.routes.draw do

  # customer側ルーティング
  devise_for :customers, skip:[:passwards],controllers: {
   sessions:      'public/sessions',
   registrations: 'public/registrations'
  }


  scope module: :public do
   root to: "homes#top"
   resources :items, only: [:show, :index]
   get 'about' => 'items#about'
   resources :genres, only: [:show]
   patch 'customers/withdraw' => 'customers#withdraw', as: 'customers_withdraw'
   get 'show' => 'customers#show'
   patch 'customers/edit' => 'customers#edit'
   patch 'update' => 'customers#update'
   get 'quit' => 'customers#quit'
   post 'orders/check' => 'orders#check'
   get 'orders/complete' => 'orders#complete'
   resources :orders, only: [:create, :new, :index, :show]
   resources :cart_items, only: [:index, :create, :update, :destroy]
   delete 'cart_items' => 'cart_items#all_destroy', as: 'all_destroy'
   resources :shipping_addresses, only: [:index, :create, :destroy, :edit, :update]
  end

  # admin側ルーティング
  devise_for :admins, skip:[:registrations,:passwards],controllers: {
   sessions: 'admin/sessions'
  }

  namespace :admin do
   root to: "homes#top"
   resources :customers, only: [:index, :edit, :update, :show]
   resources :genres, only: [:index, :create, :edit, :update]
   resources :items, only: [:show, :index, :new, :create, :edit, :update]
   resources :orders, only: [:index, :show, :update]
   resources :order_details, only: [:update]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end