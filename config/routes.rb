Rails.application.routes.draw do
  root to: 'home#index'
  
  get 'books/import' => 'books#import'
  
  resources :books do
    collection {post :import}
  end

end
