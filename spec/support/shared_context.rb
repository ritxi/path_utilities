shared_context 'form shared stuff' do
  let(:model) { MongoidTestUser.new }
  let(:foo_model) { FooClass.new }
  let(:form_params) { { mongoid_test_user: model, foo_class: foo_model } }
  let(:form) { CustomForm.new(form_params) }
  let(:data_params) { { login: 'ricard', name: 'Ricard' } }
end
