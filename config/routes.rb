Rails.application.routes.draw do
  root 'home#handler'

  namespace :admin do
    devise_for :users, path: '', controllers: {
      sessions: 'admin/auth/sessions',
      passwords: 'admin/auth/passwords'
    }

    root to: redirect('/')

    resources :users
    resources :faqs
  end

  devise_for :users
end
