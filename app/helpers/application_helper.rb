module ApplicationHelper
  def self.md5(string)
    if string
      return Digest::MD5.hexdigest(string + GENERATOR_ADDITION)
    end
  end
end