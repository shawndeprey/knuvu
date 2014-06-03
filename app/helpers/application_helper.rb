module ApplicationHelper
  def self.md5(string)
    return Digest::MD5.hexdigest("#{string}#{GENERATOR_ADDITION}") if string
  end
end