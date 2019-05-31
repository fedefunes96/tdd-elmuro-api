Sequel.migration do
  up do
    create_table(:subjects) do
      primary_key :id
      String :name
      String :code
    end
  end

  down do
    drop_table(:subjects)
  end
end
