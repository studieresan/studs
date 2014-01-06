Studs::Application.routes.draw do



  scope '/(:locale)', locale: /en|sv/ do
    
    resources :posts do
      get 'delete', on: :member
    end
    get 'newsfeed' => 'posts#feed'
    
    resources :contact_form, only: :create
    
    resources :resumes do
      get 'mine'  , on: :collection
      get 'delete', on: :member

      resources :experiences, except: [:index, :show] do
        get 'delete', on: :member
      end
    end

    resources :zip

    resources :users, except: [:show] do
      collection do
        get :me
        get :intro
      end
      get 'delete', on: :member
    end

    resources :files, only: [:index, :create, :destroy], id: /[^\/]+/ do
      get 'delete', on: :member
    end

    resources :external_posts, only: [:destroy] do
      get 'delete', on: :member
    end

    # Authentication
    get  'login'  => 'session#new',     as: :login
    post 'login'  => 'session#create',  as: :login_do
    get  'logout' => 'session#destroy', as: :logout

    # External redirects
    get '/'       => 'main#index', as: :index
  end

  root to: 'main#index'

  match '*not_found', to: 'application#not_found'
end
