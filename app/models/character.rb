class Character < ActiveRecord::Base
  default_scope -> { order('code ASC') }

  def unichr()
    return [code].pack('U*')
  end

  def self.search(search, page)
    if search
      conditions = {}
      conditions.merge!(:zongbihua => search[:zongbihua]) unless search[:zongbihua].blank?
      conditions.merge!(:structure => search[:structure]) unless search[:structure].blank?
      where(conditions).paginate(:page => page)
    else
      paginate(:page => page)
    end
  end



end
