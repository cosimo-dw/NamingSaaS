class Character < ActiveRecord::Base
  default_scope -> { order('code ASC') }
  validates_presence_of :zongbihua

  def unichr
    return [code].pack('U*')
  end

  def self.all_structures()
    collection = [%w(独体结构 独)]
    collection << %w(⿰左右结构 ⿰)
    collection << %w(⿱上下结构 ⿱)
    collection << %w(⿲左中右结构 ⿲)
    collection << %w(⿳上中下结构 ⿳)
    collection << %w(⿴全包围结构 ⿴)
    collection << %w(⿵上包围结构 ⿵)
    collection << %w(⿶下包围结构 ⿶)
    collection << %w(⿷左包围结构 ⿷)
    collection << %w(⿸左上包围结构 ⿸)
    collection << %w(⿹右上包围结构 ⿹)
    collection << %w(⿺左下包围结构 ⿺)
    collection << %w(⿻嵌套结构 ⿻)

    #(12272..12283).each do |code|
    #  collection << [code].pack('U*')
    #end
    collection
  end

end
