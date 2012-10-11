Studs::Application.routes.draw do
  resources :cvs

  get '/contact' => 'main#contact', as: :contact

  get '/' => 'main#index', as: :start
  root to: 'main#index'
end
