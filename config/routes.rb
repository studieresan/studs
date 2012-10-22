Studs::Application.routes.draw do
  resources :resumes

  # Authentication
  get  'login'  => 'session#new',     as: :login
  post 'login'  => 'session#create',  as: :login_do
  get  'logout' => 'session#destroy', as: :logout

  # Static pages
  get 'contact' => 'main#contact', as: :contact

  get '/' => 'main#index', as: :index
  root to: 'main#index'
end
