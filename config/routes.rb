Rails.application.routes.draw do
  get '/api/pokemon/:numero', to: 'pokemon#vista'
end
