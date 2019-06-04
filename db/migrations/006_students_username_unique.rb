Sequel.migration do
  up do
    alter_table(:students) do
      add_unique_constraint [:username]
    end
  end

  down do
    alter_table(:students) do
      drop_constraint [:username]
    end
  end
end
