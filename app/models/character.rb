class Character < ActiveRecord::Base
  default_scope -> { order('code ASC') }
end
