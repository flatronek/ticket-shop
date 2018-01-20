Rails.application.routes.draw do
  devise_for :users
  resources :events do
    resources :tickets, only: [:new, :create]
  end
  resources :tickets, only: [:index, :show, :edit, :update, :destroy]

  post "tickets/:id/return" => 'tickets#return', as: 'ticket_return'

  get "account/recharge" => "account#recharge_form"
  post "account/recharge" => "account#recharge", as: 'recharge'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root :to  => 'events#index'
end
