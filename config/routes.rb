Rails.application.routes.draw do

# 顧客用
devise_for :users,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

# 管理者用
devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :admin do
    root to: "posts#index"
   end

   scope module: :public do
    root to: "posts#index"
    resources :posts do
      resource :likes, only: [:create, :destroy]
      resources :comments, only: [:index, :create, :destroy]
    end
    resources :users, except: [:new] do
      resource :relationships, only: [:create, :destroy]
      get 'followings' => 'relationships#followings', as: 'followings'
    	get 'followers' => 'relationships#followers', as: 'followers'
    end
  end
end
