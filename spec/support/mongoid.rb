class MongoidTestUser
  include Mongoid::Document

  field :login
  field :name
end

class CustomForm
  include PathUtilities::Form

  properties [:login, :name], :mongoid_test_user

  validates_uniqueness_of :login
end