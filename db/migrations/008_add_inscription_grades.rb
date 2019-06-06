Sequel.migration do
  up do
    add_column :inscriptions, :grades, String
  end

  down do
    drop_column :inscriptions, :grades
  end
end
