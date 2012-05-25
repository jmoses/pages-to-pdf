PagesToPdf::Application.routes.draw do
  match "/pages" => "pages#index"
  match "/pages/download" => "pages#show"
  match "/pages/fetch" => "pages#create", :as => :fetch_pdf

  root :to => "pages#index"
end
