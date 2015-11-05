require 'spec_helper'
require support_file_path('shared_context')

describe PathUtilities::Form::UniquenessValidator::Mongoid do
  require support_file_path('mongoid')

  include_context 'form shared stuff'

  describe '.validation_class_for' do
    let(:validator) { PathUtilities::Form::UniquenessValidator::Mongoid }
    subject { CustomForm.validation_class_for(:login) }

    it { is_expected.to eq(validator) }
  end

  describe 'uniqueness validations' do
    let!(:user) { MongoidTestUser.create(data_params) }
    let!(:validate_form) { form.validate(validation_params) }
    subject { form.errors }

    context 'login has already been taken' do
      let(:validation_params) { { login: 'ricard' } }
      let(:already_taken_message) do
        I18n.t('activemodel.errors.models.mongoid_test_user.attributes.login.taken')
      end

      it { is_expected.not_to be_empty }
      it { is_expected.to include(:login) }
      it { expect(subject[:login]).to include(already_taken_message) }
    end

    context 'ensure saved document not to validates itself as repeated' do
      let(:validation_params) { { name: 'HELLO' } }
      let(:model) { user }

      it { is_expected.to be_empty }
    end

    context 'login available' do
      let(:validation_params) { { login: 'rforniol' } }

      it { is_expected.not_to include(:login) }
    end
  end
end
