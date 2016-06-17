migration 5, :add_volunteers_to_events do
  up do
    modify_table :events do
      add_column :volunteer_ids, DataMapper::Property::Text
    end
  end

  down do
    modify_table :events do
      drop_column :volunteer_ids
    end
  end
end
