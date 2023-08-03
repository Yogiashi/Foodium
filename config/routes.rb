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

# ゲストログイン用のパス
devise_scope :user do
  post 'users/guest_sign_in', to: 'public/sessions#guest_sign_in'
end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :admin do
    root to: "posts#index"
   end

   scope module: :public do
    root to: "posts#index"
    # 退会確認画面
    get  '/users/check' => 'users#check'
    # 論理削除用のルーティング
    patch  '/users/withdraw' => 'users#withdraw'
    # 通知機能のルーティング
    resources :notifications, only: [:index, :destroy]
    resources :posts do
      resource :likes, only: [:create, :destroy]
      resources :comments, only: [:index, :create, :destroy]
    end
    resources :users, except: [:new] do
      resource :relationships, only: [:create, :destroy]
      # フォローしてるユーザーを取得するためのルーティング
      get 'followings' => 'relationships#followings', as: 'followings'
      # フォロワーを取得するためのルーティング
    	get 'followers' => 'relationships#followers', as: 'followers'
    end
  end
end
