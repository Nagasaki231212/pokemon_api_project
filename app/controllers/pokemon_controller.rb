class PokemonController < ApplicationController
  def vista
    numero = params[:numero] 
    pokeapi_link= "https://pokeapi.co/api/v2/pokemon/#{numero}/"

    response = Net::HTTP.get(URI(pokeapi_link))

    if response.present?
      datos_pokemon = JSON.parse(response)
      render json: {
        nombre: datos_pokemon["name"], 
        datos: datos_pokemon
      }
    else
      render json: { error: "no se encontro el pokemon" }, status: :not_found
    end
  end
end

