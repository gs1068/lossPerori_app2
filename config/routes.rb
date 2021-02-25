Rails.application.routes.draw do
  scope :lossperori do
    mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  
    root 'static_pages#home'

    get   'inquiry'         => 'inquiry#index'
    post  'inquiry/confirm' => 'inquiry#confirm'
    post  'inquiry/thanks'  => 'inquiry#thanks' 

    devise_for :users, :controllers => {
      :registrations => 'users/registrations',
      :sessions => 'users/sessions'   
    } 

    devise_scope :user do
      get "sign_in", :to => "users/sessions#new"
      get "sign_out", :to => "users/sessions#destroy" 
    end

    resources :users, :only => [:show, :edit, :update]
    
    resources :products do
      collection do
        get :self_index
        get :search
      end
    end

    resources :purchases do
      collection do
        post :confirm
        get :thanks
      end
    end
  end
end
