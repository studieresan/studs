Studs::Application.routes.draw do

  get "leadgroup/leadgroup"

  scope '/(:locale)', locale: /en|sv/ do
    resources :instagram, only: [:index]

    resources :post_images

    resources :posts do
      get 'delete', on: :member
    end
    get 'newsfeed' => 'posts#feed'
    
    resources :contact_form, only: :create
  
    resources :events do
      get 'delete', on: :member
    end
    
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

    resources :external_posts, only: [:index, :destroy] do
      get 'delete', on: :member
    end

    # Authentication
    get  'login'  => 'session#new',     as: :login
    post 'login'  => 'session#create',  as: :login_do
    get  'logout' => 'session#destroy', as: :logout

    # External redirects
    get '/'       => 'main#index', as: :index

    get 'apply' => 'main#apply', as: :apply
    get 'ansokan' => 'main#ansokan', as: :ansokan
    get 'leadgroup' => 'main#leadgroup', as: :leadgroup
  end

  root to: 'main#index'

  match '*not_found', to: 'application#not_found'

end
