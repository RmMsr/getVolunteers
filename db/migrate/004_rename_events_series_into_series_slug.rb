migration 4, :rename_events_series_into_series_slug do
  extend MigrationHelperSqlite

  up do
    columns = [
        [:id, :id, Integer, serial: true],
        [:start, :start, DataMapper::Property::DateTime],
        [:finish, :finish, DataMapper::Property::DateTime],
        [:series, :series_slug, DataMapper::Property::Slug],
        [:volunteers_goal, :volunteers_goal, DataMapper::Property::Integer],
        [:volunteers_current, :volunteers_current, DataMapper::Property::Integer]
    ]

    rename_columns 'events', columns
  end

  down do
    columns = [
        [:id, :id, Integer, serial: true],
        [:start, :start, DataMapper::Property::DateTime],
        [:finish, :finish, DataMapper::Property::DateTime],
        [:series_slug, :series, DataMapper::Property::Slug],
        [:volunteers_goal, :volunteers_goal, DataMapper::Property::Integer],
        [:volunteers_current, :volunteers_current, DataMapper::Property::Integer]
    ]

    rename_columns 'events', columns
  end
end
