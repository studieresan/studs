Studs::Application.routes.draw do
  get '/' => 'main#index', as: :start
  get '/cv-databas' => 'cvs#index', as: :cv
  get '/kontakta' => 'main#contact', as: :contact
  root to: 'main#index'
end
