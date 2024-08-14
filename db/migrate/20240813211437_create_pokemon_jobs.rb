class CreatePokemonJobs < ActiveRecord::Migration[6.1]
  def change
    create_table :pokemon_jobs do |t|
      t.string :job_id
      t.string :status
      t.json :result

      t.timestamps
    end
  end
end
