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
    resources :ordered_item, only:[:update]
  end

  root to: "customer/homes#top"
  get '/about' => 'customer/homes#about'

  resources :customers, only:[:show, :edit, :update] do
    get 'customer/:id/unsubscribe' => 'customers#unsubscribe', as: 'unsubscribe'
    patch 'customer/:id/withdraw' => 'customers#withdraw', as: 'withdraw'
    get '/confirm' => 'customer/orders#confirm'
    get '/complete' => 'customer/orders#complete'
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