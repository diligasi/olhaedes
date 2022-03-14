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
    resources :faqs
  end

  devise_for :users
end
