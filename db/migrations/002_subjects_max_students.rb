Sequel.migration do
  up do
    add_column :subjects, :max_students, Integer
  end

  down do
    drop_column :subjects, :max_students
  end
end
