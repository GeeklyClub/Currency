Rails.application.routes.draw do
  root 'welcome#index'
  get '/exchange', to: 'welcome#exchange'
  get '/currency_iso_code', to: 'welcome#currency_iso_code', format: :json
end
