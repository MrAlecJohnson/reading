Rails.application.routes.draw do
  root to: 'home#index'

  get 'home/index'
  get 'books/index'
  get 'books/import' => 'books#import'
  get 'books/empty' => 'books#empty'
  
  resources :books do
    collection {post :import}
  end

  resources :books do
    post :empty
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
