module PathUtilities
  module Form
    module TrackingChanges
      extend ActiveSupport::Concern

      def changes?(field)
        form_field_value = send(field)
        model_field_value = instance_model_for(field).send(field)
        model_field_value != form_field_value
      end
    end
  end
end