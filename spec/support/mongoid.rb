class MongoidTestUser
  include Mongoid::Document

  field :login
  field :name
end

class FooClass
  include Mongoid::Document

  field :foo, type: Time
end

class CustomForm
  include PathUtilities::Form

  setup_model_name :mongoid_test_user

  properties [:login, :name], :mongoid_test_user
  properties [{ foo: 'Time' }], :foo_class

  validates_uniqueness_of :login
  validates :login, :name, presence: true
end
