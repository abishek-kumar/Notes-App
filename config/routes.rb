NotesApp::Application.routes.draw do

  match '*all', controller: 'application', action: 'cors_preflight', via: [:options]
  resources :notes, only:[] do
    member do
      put '', action: :update
      delete '', action: :delete
      put 'addLabel', action: :add_label
      put 'removeLabel', action: :remove_label
    end
    collection do
      post '', action: :create
      get '', action: :list
    end
  end

  resources :labels, only:[] do
    member do
      put '', action: :edit
      delete '', action: :delete
    end
    collection do
      post '', action: :create
      get '', action: :list
    end
  end

  post '/signin', to: "user#sign_in"
  post '/signup', to: "user#sign_up"
  post '/signout', to: "user#sign_out"
end
