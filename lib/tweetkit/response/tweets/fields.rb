module Tweetkit::Response::Tweets
  class Fields
    attr_accessor :fields, :media_fields, :place_fields, :poll_fields, :tweet_fields, :user_fields

    def initialize(fields)
      @fields = fields 
      build_and_normalize_fields(fields) unless fields.nil?
    end

    def build_and_normalize_fields(fields)
      fields.each_key do |field_type|
        normalized_field = build_and_normalize_field(@fields[field_type], field_type)
        instance_variable_set(:"@#{field_type}", normalized_field)
        self.class.define_method(field_type) { instance_variable_get("@#{field_type}") }
      end
    end

    def build_and_normalize_field(field, field_type)
      Field.new(field, field_type)
    end

    def method_missing(method, **args)
      return nil if VALID_FIELDS.include?(method.to_s)

      super
    end

    def respond_to_missing?(method, *args)
      VALID_FIELDS.include?(method.to_s) || super
    end

    class Field
      include Enumerable

      attr_accessor :normalized_field, :original_field

      FIELD_NORMALIZATION_KEY = {
        'users': 'id'
      }.freeze

      def initialize(field, field_type)
        @original_field = field
        @normalized_field = {}
        normalization_key = FIELD_NORMALIZATION_KEY[field_type.to_sym]
        field.each do |data|
          key = data[normalization_key]
          @normalized_field[key.to_i] = data
        end
      end

      def each(*args, &block)
        @normalized_field.each(*args, &block)
      end

      def each_data(*args, &block)
        @normalized_field.values.each(*args, &block)
      end

      def find(key)
        @normalized_field[key.to_i]
      end
    end
  end
end
