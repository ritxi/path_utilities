shared_context 'form shared stuff' do
  let(:model) { MongoidTestUser.new }
  let(:form_params) { { mongoid_test_user: model } }
  let(:form) { CustomForm.new(form_params) }
  let(:data_params) { { login: 'ricard', name: 'Ricard' } }
end