Sequel.migration do
  up do
    alter_table(:subjects) do
      add_unique_constraint [:code]
    end
  end

  down do
    alter_table(:subjects) do
      drop_constraint [:code]
    end
  end
end
