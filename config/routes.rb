Shokuget::Application.routes.draw do
  root 'jobs#index'

  resources :captchas

  resources :email_templates, only: [:index] do
    collection do
      get 'submissions_mailer'
    end
  end

  resources :feedbacks, only: [:create]
  get 'contact', to: 'feedbacks#new'

  resources :filters

  resources :jobs do
    member do
      resources :submissions, only: [:create]
      get 'review'
      post 'redeem'
      resources :orders, only: [:new, :create] do
        collection { get 'success' }
      end
    end
  end

  resources :promos do
    member { post 'close' }
  end

  get 'about', to: 'static_pages#about'
  get 'blank', to: 'static_pages#blank'

end
