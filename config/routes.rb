Rails.application.routes.draw do
  root 'home#handler'

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
    resources :institutional
    resources :faqs

    get 'dashboard'  => 'dashboard#index'
  end

  devise_for :users
end
