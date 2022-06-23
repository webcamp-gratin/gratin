Rails.application.routes.draw do
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "customer/registrations",
    sessions: 'customer/sessions'
  }

  namespace :admin do
    root to: "admins/orders#index"
    resources :customers, only:[:show, :index, :edit, :update]
    resources :orders, only:[:show, :index, :update]
    resources :items, except:[:destroy]
    resources :genres, only:[:create, :index, :edit, :update]
    resources :ordered_items, only:[:update]
  end

  root to: "customer/homes#top"
  get '/about' => 'customer/homes#about'

  scope module: :customer do
    resources :customers, only:[:show, :edit, :update]
    get 'customers/:id/unsubscribe' => 'customers#unsubscribe', as: 'unsubscribe'
    patch 'customers/:id/withdraw' => 'customers#withdraw', as: 'withdraw'
    post '/orders/confirm' => 'orders#confirm'
    get '/orders/complete' => 'orders#complete'
    resources :items, only:[:show, :index]
    resources :addresses, except:[:new, :show]
    resources :orders, only:[:new, :create, :show, :index]
    resources :cart_items, only:[:index, :update, :destroy, :create] do
      collection do
        delete '/destroy_all', action: :destroy_all
      end
    end
  end
end