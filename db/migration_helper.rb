module MigrationHelper
  def foreign_key(from_table, from_column, to_table)
    constraint_name = "fk_#{from_table}_#{to_table}"

    execute "alter table #{from_table} add constraint #{constraint_name} foreign key (#{from_column}) references #{to_table}(id)"
  end
end

module ActiveRecord
  module ConnectionAdapters # :nodoc:
    module SchemaStatements

      def add_column_options!(sql, options) #:nodoc:
        sql << " DEFAULT #{quote(options[:default], options[:column])}" if options_include_default?(options)
        # must explicitly check for :null to allow change_column to work on migrations
        if options[:null] == false
          sql << " NOT NULL"
        end
        if options[:after]
          sql << " AFTER #{options[:after]}"
        end
      end

    end
  end
end
