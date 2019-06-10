Sequel.migration do
  up do
    add_column :subjects, :type, String
  end

  down do
    drop_column :subjects, :type
  end
end
