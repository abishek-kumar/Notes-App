NotesApp::Application.routes.draw do

  resources :notes, only:[] do
    member do
      post 'create', action: :create
      put 'save', action: :save
      delete 'delete', action: :delete
      put 'addLabel', action: :add_label
      put 'removeLabel', action: :remove_label
    end
    collection do
      get 'list', action: :list
    end
  end

  resources :label, only:[] do
    member do
      post 'create', action: :create
      put 'edit', action: :edit
      delete 'delete', action: :delete
    end
  end

  post '/signin', to: "user#sign_in"
  post '/signup', to: "user#sign_up"
  post '/signout', to: "user#sign_out"
  get '/login_page', to: "user#login_page"

end