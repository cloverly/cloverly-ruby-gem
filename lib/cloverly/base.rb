module Cloverly::Base

  def initialize(cloverly_instance)
    @cloverly_instance = cloverly_instance
  end

  def self.included(base)
    base.extend ClassMethods
    base.class_eval do
    end
  end

  module ClassMethods
    def parse(clovery_instance, json_response)
      instance = self.new(clovery_instance)

      json_response.each do |key, value|
        instance.define_singleton_method(key, -> { value })
      end

      instance
    rescue
      debugger
      raise $!
    end
  end

end
