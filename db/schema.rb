# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20081001222332) do

  create_table "bj_config", :id => false, :force => true do |t|
    t.integer "bj_config_id", :null => false
    t.text    "hostname"
    t.text    "key"
    t.text    "value"
    t.text    "cast"
  end

  add_index "bj_config", ["hostname", "key"], :name => "index_bj_config_on_hostname_and_key", :unique => true

  create_table "bj_job", :id => false, :force => true do |t|
    t.integer  "bj_job_id",      :null => false
    t.text     "command"
    t.text     "state"
    t.integer  "priority"
    t.text     "tag"
    t.integer  "is_restartable"
    t.text     "submitter"
    t.text     "runner"
    t.integer  "pid"
    t.datetime "submitted_at"
    t.datetime "started_at"
    t.datetime "finished_at"
    t.text     "env"
    t.text     "stdin"
    t.text     "stdout"
    t.text     "stderr"
    t.integer  "exit_status"
  end

  create_table "bj_job_archive", :id => false, :force => true do |t|
    t.integer  "bj_job_archive_id", :null => false
    t.text     "command"
    t.text     "state"
    t.integer  "priority"
    t.text     "tag"
    t.integer  "is_restartable"
    t.text     "submitter"
    t.text     "runner"
    t.integer  "pid"
    t.datetime "submitted_at"
    t.datetime "started_at"
    t.datetime "finished_at"
    t.datetime "archived_at"
    t.text     "env"
    t.text     "stdin"
    t.text     "stdout"
    t.text     "stderr"
    t.integer  "exit_status"
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "parent_id"
    t.integer  "root_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categorizations", :force => true do |t|
    t.integer  "category_id"
    t.integer  "item_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ereferences", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "bookmark"
    t.integer  "item_id"
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "items", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.text     "origin"
    t.date     "originated_at"
    t.string   "type"
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "local_file_name"
    t.string   "local_content_type"
    t.integer  "local_file_size"
    t.boolean  "local_unpack",        :default => false
    t.string   "local_file_hash"
    t.integer  "sequence"
    t.string   "identifier"
    t.integer  "parent_id"
    t.integer  "root_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.string   "relative_path"
    t.string   "remote_path"
    t.string   "remote_username"
    t.string   "remote_password"
    t.boolean  "remote_authenticate", :default => false
    t.integer  "remote_file_size"
    t.string   "remote_content_type"
    t.string   "remote_file_hash"
  end

  create_table "transformations", :force => true do |t|
    t.string   "data_file_name"
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "item_id"
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "login",                     :limit => 40
    t.string   "name",                      :limit => 100, :default => ""
    t.string   "email",                     :limit => 100
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token",            :limit => 40
    t.datetime "remember_token_expires_at"
  end

  add_index "users", ["login"], :name => "index_users_on_login", :unique => true

end
