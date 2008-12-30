# ./script/runner ./lib/jobs/local_unpack.rb <id>
#
# This script is used by the Evidence Locker application to unpack an archived
# file into a directory called 'unpacked'. It is executed as a background job. 

require 'pathname'

UNZIP = '/usr/bin/unzip'

root_item = Item.find(ARGV[0])
root_path = Pathname.new(root_item.local.path)

if root_path.exist? && root_path.extname == '.zip'
  system("#{UNZIP} #{root_path} -d #{root_path.dirname}/unpacked")
end 
