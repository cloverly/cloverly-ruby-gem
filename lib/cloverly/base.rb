module Cloverly::Base

  def initialize(cloverly_instance)
    @cloverly_instance = cloverly_instance
  end

  def attributes=(json)
    json.each do |key, value|
      self.define_singleton_method(key, -> { value })
    end
  end

  def to_json
    @json
  end

  def json=(json)
    @json = json
  end

  def self.included(base)
    base.extend ClassMethods
    base.class_eval do
    end
  end

  module ClassMethods
    def parse(cloverly_instance, json_response)
      if json_response.is_a?(Array)
        json_response.map do |item_json|
          self.parse(cloverly_instance, item_json)
        end
      else
        instance = self.new(cloverly_instance)

        instance.json = json_response
        instance.attributes = json_response

        instance
      end
    end
  end

end
