Rails.application.routes.draw do
  devise_for :users
  scope "/admin" do
    resources :users
  end
  root 'main#home'
  get '/grids/grid_generator', to: 'grids#grid_generator'
  get '/grids/download', to: 'grids#generate_grid'
  resources :professionals do
    resources :appointments do
      collection do
        delete 'cancel-all', action: 'cancel_all'
        get 'filter-index', action: 'filter_index'
      end
      member do
        get 'reschedule', action: 'reschedule'
      end
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
