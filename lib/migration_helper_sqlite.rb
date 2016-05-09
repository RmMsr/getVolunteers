module MigrationHelperSqlite
  def quote(name)
    adapter.send :quote_name, name
  end

  # Rename columns by rewriting the entire table
  # @param table_name [String]
  # @param columns_old_new_create [Array] Definition of all columns
  # Schema: [[old_col, new_col, create_param1, create_param2], ...]
  def rename_columns(table_name, columns_old_new_create)
    temporary_table_name = "#{table_name}_temp"

    DataMapper::Transaction.new(adapter).commit do
      adapter.execute(
          "ALTER TABLE #{quote table_name} "\
          "RENAME TO #{quote temporary_table_name}"
      )

      create_table table_name do
        columns_old_new_create.each do |_old, new, *options|
          column new, *options
        end
      end

      columns_old = columns_old_new_create.map { |c| quote c[0] }
      columns_new = columns_old_new_create.map { |c| quote c[1] }

      adapter.execute(
          "INSERT INTO #{quote table_name}" +
              "(#{columns_new.join(',')}) " +
              "SELECT #{columns_old.join(',')} " +
              "FROM #{quote temporary_table_name}")

      drop_table temporary_table_name
    end
  end
end
