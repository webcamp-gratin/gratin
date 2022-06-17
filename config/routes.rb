Rails.application.routes.draw do
  devise_for :customers, controllers: {
    registrations: "customer/registrations",
    sessions: 'customer/sessions'
  }

  devise_for :admin, controllers: {
    sessions: "admin/sessions"
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
    resources :items, only:[:show, :index]
    resources :cart_items, only:[:index, :update, :destroy, :create] do
      collection do
        delete '/destroy_all', action: :destroy_all
      end
    resources :addresses, except:[:new, :show]
    resources :orders, only:[:new, :create, :show, :index]
    get '/unsubscribe' => 'customer/customers#unsubscribe'
    get '/withdraw' => 'customer/customers#withdraw'
    get '/confirm' => 'customer/orders#confirm'
    get '/complete' => 'customer/orders#complete'

    end
  end
end