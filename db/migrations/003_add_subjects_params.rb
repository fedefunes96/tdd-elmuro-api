Sequel.migration do
  up do
    add_column :subjects, :teacher, String
    add_column :subjects, :projector, TrueClass
    add_column :subjects, :laboratory, TrueClass
  end

  down do
    drop_column :subjects, :teacher
    drop_column :subjects, :projector
    drop_column :subjects, :laboratory
  end
end
