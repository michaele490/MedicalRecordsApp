Rails.application.routes.draw do
  root "main#index"
  get "login", to: "main#login"
  get "staff/index"
  get "staff", to: "staff#index"
  resources :appointments
  resources :patients

  # Points to custom Devise controllers
  devise_for :receptionists, controllers: {
    registrations: "receptionists/registrations",
    sessions: "receptionists/sessions"
  }

  devise_for :doctors, controllers: {
    registrations: "doctors/registrations",
    sessions: "doctors/sessions"
  }

  devise_for :admins, controllers: {
    registrations: "admins/registrations",
    sessions: "admins/sessions"
  }

  # Allows log outs
  devise_scope :admin do
    get "/admins/sign_out" => "devise/sessions#destroy"
  end

  devise_scope :receptionist do
    get "/receptionists/sign_out" => "devise/sessions#destroy"
  end

  devise_scope :doctor do
    get "/doctors/sign_out" => "devise/sessions#destroy"
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  # root "posts#index"
end
