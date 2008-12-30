# ./script/runner ./lib/jobs/build_items.rb <id>

require 'pathname'
require RAILS_ROOT + '/lib/pathname_ext.rb'

root_item = Item.find(ARGV[0])
root_path = Pathname.new(root_item.local.path)
unpacked_path = root_path.dirname + "unpacked"

unpacked_path.find do |p|
  next if p.to_s == unpacked_path.to_s
  
  relative_path = p.relative_path_from(unpacked_path.realpath)
  parent_of_relative_path = relative_path.parent.to_s
  parent_of_relative_path = nil if parent_of_relative_path == "."
  
  parent = Item.find_by_identifier_and_relative_path(root_item.identifier, parent_of_relative_path)
  
  child = Item.new(
    :title => root_item.title,
    :description => root_item.description,
    :relative_path => relative_path.to_s,
    :identifier => root_item.identifier,
    :local_file_hash => p.digest.to_s,
    :local_file_size => p.size,
    :local_content_type => p.extname,
    :root_id => root_item.id,
    :creator => root_item.creator ) 
  
  child.save(false)  
  child.move_to_child_of parent
end