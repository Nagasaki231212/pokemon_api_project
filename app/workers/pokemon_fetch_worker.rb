class PokemonFetchWorker
  include Sidekiq::Worker

  def perform(job_id, numero)
    sleep 10

    enlace_pokeapi = "https://pokeapi.co/api/v2/pokemon/#{numero}/"
    respuesta = Net::HTTP.get(URI(enlace_pokeapi))

    sleep 10

    trabajo = PokemonJob.find_by(job_id: job_id)

    if respuesta.present?
      datos_pokemon = JSON.parse(respuesta)

      trabajo.update(
        status: 'completado',
        result: {
          id: datos_pokemon["id"],
          name: datos_pokemon["name"],
          detalles: datos_pokemon
        }
      )
    else
      trabajo.update(status: 'fallido', result: { error: "No se encontró el Pokémon" })
    end
  end
end
