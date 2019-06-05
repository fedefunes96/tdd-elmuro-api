Sequel.migration do
  up do
    create_table(:inscriptions) do
      String :username
      String :subject_code
      primary_key %i[username subject_code], name: :inscription_id
    end
  end

  down do
    drop_table(:inscriptions)
  end
end
