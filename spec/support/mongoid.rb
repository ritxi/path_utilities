class MongoidTestUser
  include Mongoid::Document

  field :login
  field :name
end

class CustomForm
  include PathUtilities::Form

  setup_model_name :mongoid_test_user

  properties [:login, :name], :mongoid_test_user

  validates_uniqueness_of :login
  validates :login, :name, presence: true
end
