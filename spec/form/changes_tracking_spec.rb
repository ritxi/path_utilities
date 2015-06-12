require 'spec_helper'
require support_file_path('shared_context')

describe PathUtilities::Form::TrackingChanges do
  require support_file_path('mongoid')

  include_context 'form shared stuff'

  describe '#changes?' do
    subject { form }

    context 'form without changes' do
      it { expect(subject.changes?(:login)).to be_falsey }
    end

    context 'form with changes' do
      before { subject.validate(login: 'hello') }

      it { expect(subject.changes?(:login)).to be_truthy }
    end
  end
end
