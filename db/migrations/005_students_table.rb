Sequel.migration do
  up do
    create_table(:students) do
      primary_key :id
      String :name
      String :username
    end
  end

  down do
    drop_table(:students)
  end
end
