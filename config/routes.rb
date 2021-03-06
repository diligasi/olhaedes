Rails.application.routes.draw do
  root 'home#handler'

  get 'manifest.json'     => 'home#manifest'
  get 'service-worker.js' => 'home#service_worker'

  namespace :admin do
    devise_for :users, path: '', controllers: {
      sessions: 'admin/auth/sessions',
      passwords: 'admin/auth/passwords'
    }

    root to: redirect('/')

    resources :users do
      collection do
        get   'edit_password'
        patch 'update_password'
      end
    end

    resources :departments
    resources :regions
    resources :property_types

    resources :field_forms, only: %i[index show edit update] do
      collection do
        resources :search_filters, only: %i[index], controller: 'field_forms/search_filters', as: 'field_form_search_filters'
      end
    end

    resources :larvae, only: %i[create update]

    resources :larva_species
    resources :shed_types
    resources :institutional, except: %i[show]
    resources :faqs

    get 'dashboard'  => 'dashboard#index'
    get 'csv_export' => 'dashboard#export'

    get 'filter_dashboard_by_date_range' => 'dashboard#filter_dashboard_by_date_range'
    get 'filter_regions_by_department'   => 'users#filter_regions_by_department'
  end

  scope module: 'pwa', path: 'app' do
    devise_for :users, path: '', controllers: {
      sessions: 'pwa/auth/sessions',
      passwords: 'pwa/auth/passwords'
    }

    root 'field_forms#index', as: 'app_root'

    resources :users, except: %i[index new create destroy] do
      collection do
        get   'edit_password'
        patch 'update_password'
      end
    end

    resources :field_forms, except: %i[delete]

    resources :institutional, only: %i[index]
    resources :faqs,          only: %i[index]
  end
end
