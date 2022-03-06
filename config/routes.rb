Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
  
  get '/listing_items', to: 'application#listing_items'

  scope module: :v1 do
    resources :carts, except: [:index, :create, :update, :destroy] do
      get :cart_items, on: :collection
      put :update_cart_item, on: :collection

      delete :remove_item, on: :collection
    end
  end
end
