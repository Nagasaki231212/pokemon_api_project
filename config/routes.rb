Rails.application.routes.draw do
  get '/api/pokemon/:numero', to: 'pokemon#vista'
  get '/api/async/pokemon/:numero', to: 'pokemon#async_pokemon'
  get '/api/async/trabajo/:id', to: 'pokemon#estado_trabajo'
end
