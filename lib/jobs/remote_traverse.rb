# ./script/runner ./lib/jobs/remote_traverse.rb <id>

require 'pathname'
require RAILS_ROOT + '/lib/pathname_ext.rb'

MOUNT = '/sbin/mount.cifs'
UMOUNT = '/sbin/umount.cifs'

class RemoteFilesystem
  def initialize(path, username = 'guest', password = '')
    @path = path
    @mount = ''
    @username = username
    @password = password
  end
  
  def mount(mount_point)
    @mount = mount_point
    
    Dir.mkdir(@mount)
    system("#{MOUNT} //#{remote_server}#{remote_dirname} #{@mount} -o ro, #{credentials}")
    Pathname.new(@mount)
  end
  
  def umount(rmdir = true)
    system("#{UMOUNT} #{@mount}")
    Dir.rmdir(@mount) if rmdir == true
  end
  
  private
  
    def credentials
      if @username == 'guest'
        return @username
      else
        return "user=#{@username}, password=#{@password}"
      end
    end

    def parse_unc
      unc = @path.split(/^[\\\/]{2}([a-zA-Z0-9\-_]+)(.+)/)
      return { :server => unc[1], :dirname => unc[2] }
    end

    def remote_server
      parse_unc[:server]
    end

    def remote_dirname
      parse_unc[:dirname]
    end
end

root_item = Item.find(ARGV[0])
rfs = RemoteFilesystem.new(root_item.remote_path)

mounted_path = rfs.mount("/tmp/#{root_item.identifier}")
mounted_path.find do |p|
  next if p.to_s == mounted_path.to_s
  
  relative_path = p.relative_path_from(mounted_path.realpath)
  parent_of_relative_path = relative_path.parent.to_s
  parent_of_relative_path = nil if parent_of_relative_path == "."
  
  parent = Item.find_by_identifier_and_relative_path(root_item.identifier, parent_of_relative_path)
  
  child = Remote.new(
    :title => root_item.title,
    :description => root_item.description,
    :relative_path => relative_path.to_s,
    :identifier => root_item.identifier,
    :remote_file_size => p.size,
    :remote_content_type => p.extname,
    :remote_file_hash => p.digest.to_s,
    :root_id => root_item.id,
    :creator => root_item.creator )
  
  child.save(false)  
  child.move_to_child_of parent
end

rfs.umount