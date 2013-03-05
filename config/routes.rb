Studs::Application.routes.draw do
  scope '/(:locale)', locale: /en|sv/ do
    resources :resumes do
      get 'mine'  , on: :collection
      get 'delete', on: :member

      resources :experiences, except: [:index, :show] do
        get 'delete', on: :member
      end
    end

    resources :users, except: [:show] do
      get 'me'    , on: :collection
      get 'delete', on: :member
    end

    resources :files, only: [:index, :create, :destroy], id: /[^\/]+/ do
      get 'delete', on: :member
    end

    # Authentication
    get  'login'  => 'session#new',     as: :login
    post 'login'  => 'session#create',  as: :login_do
    get  'logout' => 'session#destroy', as: :logout

    # Static pages
    get 'blog'    => redirect('http://studs13.tumblr.com/'), as: :blog
    get '2012'    => 'main#earlier', as: :earlier
    get 'contact' => 'main#contact', as: :contact

    get '/'       => 'main#index', as: :index
  end

  root to: 'main#index'

  match '*not_found', to: 'application#not_found'
end
