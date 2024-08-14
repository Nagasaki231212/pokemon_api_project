class PokemonController < ApplicationController
  def vista
    numero = params[:numero]
    pokeapi_link = "https://pokeapi.co/api/v2/pokemon/#{numero}/"

    response = Net::HTTP.get(URI(pokeapi_link))

    if response.present?
      datos_pokemon = JSON.parse(response)
      render json: {
        nombre: datos_pokemon["name"],
        datos: datos_pokemon
      }
    else
      render json: { error: "no se encontró el Pokémon" }, status: :not_found
    end
  end

  def async_pokemon
    numero = params[:numero]

    id_trabajo = SecureRandom.uuid
    
    PokemonJob.create(job_id: id_trabajo, status: 'pendiente')

    PokemonFetchWorker.perform_async(id_trabajo, numero)

    render json: { id_trabajo: id_trabajo }
  end

  def estado_trabajo
    id_trabajo = params[:id]

    # Buscar el trabajo en la base de datos
    trabajo = PokemonJob.find_by(job_id: id_trabajo)

    if trabajo.present?
      render json: {
        estado: trabajo.status,
        resultado: {
          id: trabajo.result['id'],
          name: trabajo.result['name']
        }.merge(trabajo.result['detalles'])
      }
    else
      render json: { error: "Trabajo no encontrado" }, status: :not_found
    end
  end
end






   