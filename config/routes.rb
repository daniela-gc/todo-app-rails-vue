Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :task_items, except: [:new, :edit]
    end
  end

  root to: 'application#index'
  get '*path', to: 'application#index', format: false
end
