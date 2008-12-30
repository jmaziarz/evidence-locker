# ./script/runner ./lib/jobs/remote_mirror.rb <id>

HTTRACK = '/opt/local/bin/httrack'

root_item = Remote.find(ARGV[0])

system("#{HTTRACK} #{root_item.remote_path} -r2 -O #{DATA_PATH}/#{root_item.identifier}/mirror/")
