Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  post 'signup', to: "users#signup"
  post 'login', to: "users#login"
  get 'me', to: "users#me"
  get 'categories', to:"categories#list"
  # get 'booking_times', to: "booking#booking_times"
  # get 'current_booked_time', to: "booking#current_booked_time"
  # put 'book', to: "booking#book"
  # put 'cancel', to: "booking#cancel"
end
