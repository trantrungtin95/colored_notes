Rails.application.routes.draw do
  get 'admin/index'
  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/destroy'
  resources :users do
    resources :notes do 
      get :new_line_item, on: :member
      post :add_line_item, on: :member
      get :edit_line_item, on: :member
      patch :update_line_item, on: :member
      get :destroy_line_item, on: :member
      get :pin, on: :member
      get :unpin, on: :member
      get :archive, on: :member
      get :unarchive, on: :member
      get :reminder, on: :member
      get :set_reminder, on: :member
      get :archive_index, on: :collection
      get :color, on: :member
      get :set_index, on: :collection
      get :reminder_notes, on: :collection
      get :add_tag, on: :member
      get :create_tag, on: :member
      get :destroy_tag, on: :member
      get :select_tag, on: :collection
      get :search, on: :collection
    end 
    # get :destroy_note, on: :collection
  end
  get 'admin' => 'admin#index'
  controller :sessions do
    get 'login' => :new
    post 'login' => :create
    get 'logout' => :destroy
  end

  root :to => 'admin#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
