Rails.application.routes.draw do
  devise_for :users
  root 'main#home'
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
