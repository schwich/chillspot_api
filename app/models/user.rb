class User < ActiveRecord::Base
  has_one :relationship, dependent: :destroy
  has_one :event, :through => :relationship

end
