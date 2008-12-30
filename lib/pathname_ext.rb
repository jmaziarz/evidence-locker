require 'pathname'
require 'digest/sha1'
require 'digest/sha2'

class Pathname
  # Generate a digest of a file path
  def digest(algorithm = Digest::SHA256)
    digest, chunk = algorithm.new, ''
    if self.realpath.file?
      File.open(self.realpath, 'rb') do |f|
        digest << chunk while f.read(4096, chunk)
      end
    else
      digest = ''
    end
    digest
  end
end