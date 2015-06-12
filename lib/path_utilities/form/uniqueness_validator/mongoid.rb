require 'mongoid/validatable/uniqueness'

module PathUtilities
  module Form
    module UniquenessValidator
      class Mongoid < ::Mongoid::Validatable::UniquenessValidator
        def initialize(options)
          @klass = options[:model] if options[:model]
          super
        end

        def validate_each(record, attribute, value)
          # UniquenessValidator can't be used outside of Mongoid::Document instances, here
          # we return the exact same error, unless the 'model' option is given.
          #
          if !options[:model] && !record.class.ancestors.include?(Mongoid::Document)
            fail ArgumentError, "Unknown validator: 'UniquenessValidator'"

          # If we're inside an ActiveRecord class, and `model` isn't set, use the
          # default behaviour of the validator.
          #
          elsif !options[:model]
            super

          # Custom validator options. The validator can be called in any class, as
          # long as it includes `ActiveModel::Validations`. You can tell the validator
          # which Mongoid::Document based class to check against, using the `model`
          # option. Also, if you are using a different attribute name, you can set the
          # correct one for the ActiveRecord class using the `attribute` option.
          #
          else
            record_org, attribute_org = record, attribute

            attribute = options[:attribute].to_sym if options[:attribute]
            record = options[:model].new(attribute => value)
            is_new_record = record_org.instance_model_for(attribute).new_record?

            if is_new_record || record_org.changes?(attribute)
              super

              if record.errors.any?

                record_org.errors.add(attribute_org, :taken,
                  options.except(:case_sensitive, :scope).merge(value: value))
              end
            end
          end
        end
      end
    end
  end
end