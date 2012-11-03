Studs::Application.routes.draw do
  scope '/(:locale)', locale: /en|sv/ do
    resources :resumes do
      get 'mine', on: :collection
      get 'delete', on: :member

      resources :experiences, except: [:index, :show] do
        get 'delete', on: :member
      end
    end

    resources :users

    # Authentication
    get  'login'  => 'session#new',     as: :login
    post 'login'  => 'session#create',  as: :login_do
    get  'logout' => 'session#destroy', as: :logout

    # Static pages
    get 'contact' => 'main#contact', as: :contact

    get '/' => 'main#index', as: :index
  end

  root to: 'main#index'
end
