Rails.application.routes.draw do
  root 'welcome#index', defaults: { format: :json }
end
