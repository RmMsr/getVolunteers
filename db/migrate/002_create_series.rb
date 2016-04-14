migration 2, :create_series do
  up do
    create_table :series do
      column :id, Integer, serial: true
      column :name, DataMapper::Property::String, length: 255
      column :slug, DataMapper::Property::Slug
    end
  end

  down do
    drop_table :series
  end
end
