require 'spec_helper'
require support_file_path('shared_context')

describe PathUtilities::Form do
  require support_file_path('mongoid')


  include_context 'form shared stuff'

  describe '.model_for' do
    subject { CustomForm.model_for(:login) }

    it { is_expected.to eq(MongoidTestUser) }
  end

  describe '.new' do
    describe 'requires all models to be mapped' do
      context 'nothing mapped' do
        let(:form_params) { {} }
        subject { form }

        it do
          expect { subject }.to(
            raise_error(RuntimeError,
                        'MongoidTestUser not mapped on initialization'))
        end
      end

      context 'all mapped' do
        subject { form }

        it { expect { subject }.not_to raise_error }
      end
    end
  end

  describe '#sync' do
    before do
      form.validate(data_params)
      form.sync
    end

    subject { model }
    its(:login) { is_expected.to eq('ricard') }
    its(:name) { is_expected.to eq('Ricard') }
  end

  describe '#save' do
    let(:model) { MongoidTestUser.new }
    let(:form) { CustomForm.new(mongoid_test_user: model) }
  end
end