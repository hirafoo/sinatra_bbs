require 'config/boot'
require 'db/migration_helper'

namespace :db do
  desc "Migrate the database through scripts in db/migrate. Target specific version with VERSION=x"

  task :migrate do
    ActiveRecord::Migrator.migrate("db/migrate/", ENV["VERSION"] ? ENV["VERSION"].to_i : nil)
  end

  task :rollback do
    ActiveRecord::Migrator.rollback("db/migrate/")
  end
end

