namespace :elocker do
  desc "Migrate the Evidence Locker database to version 2.0"
  task :migrate_to_2_dot_0 => :environment do
    ActiveRecord::Migrator.migrate("db/", 20081001222331)
    Rake::Task["db:schema:dump"].invoke if ActiveRecord::Base.schema_format == :ruby
  end
end