class Character < ActiveRecord::Base
  default_scope -> { order('code ASC') }

  def unichr()
    return [code].pack('U*')
  end

  def self.all_structures()
    collection = ['独']
    (12272..12283).each do |code|
      collection << [code].pack('U*')
    end
    collection
  end

end
