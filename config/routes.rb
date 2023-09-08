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
    root to: 'users#index'
    resources :users, only: [:index, :show, :edit, :update] do
      # ユーザーの投稿一覧ページのルーティング
      get 'posts'
    end
    resources :tags, except: [:new, :show]
    resources :posts, only: [:show, :destroy]
    resources :reports, only: [:index, :show, :update]
  end

   scope module: :public do
    root to:  'homes#top'
    # 退会確認画面のルーティング
    get  '/users/check' => 'users#check'
    # 論理削除のルーティング
    patch  '/users/withdraw' => 'users#withdraw'
    # 通知機能のルーティング
    resources :notifications, only: [:index, :destroy]
    resources :posts do
      collection do
      # タグ検索のルーティング
      get 'search_tag'
      get 'search'
      end
      resource :likes, only: [:create, :destroy]
      resources :comments, only: [:index, :create, :destroy]
    end
    resources :users, except: [:new, :destroy] do
      member do
        # いいねした投稿を取得するため投稿idを付与
        get :likes
        # 下書き一覧ページのルーティング
        get :draft
      end
      # ユーザーを通報するためのルーティング
      resources :reports, only: [:new, :create]
      resource :relationships, only: [:create, :destroy]
      # フォローしてるユーザーを取得するためのルーティング
      get 'followings' => 'relationships#followings', as: 'followings'
      # フォロワーを取得するためのルーティング
    	get 'followers' => 'relationships#followers', as: 'followers'
    end
  end
end
