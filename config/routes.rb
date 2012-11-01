Studs::Application.routes.draw do
  scope '/(:locale)', locale: /en|sv/ do
    resources :resumes do
      get 'mine', on: :collection
      resources :experiences, except: [:index, :show]
    end

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
