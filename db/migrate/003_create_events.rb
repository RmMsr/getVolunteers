migration 3, :create_events do
  up do
    create_table :events do
      column :id, Integer, :serial => true
      column :start, DataMapper::Property::DateTime
      column :finish, DataMapper::Property::DateTime
      column :event, DataMapper::Property::String, length: 255
      column :volunteers_goal, DataMapper::Property::Integer
      column :volunteers_current, DataMapper::Property::Integer
    end
  end

  down do
    drop_table :events
  end
end
