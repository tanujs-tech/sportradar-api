# frozen_string_literal: true

module Sportradar
  module Api
    class Data
      # Attributes that have a value
      def attributes
        all_attributes.reject { |x| send(x).nil? }
      end

      def all_attributes
        instance_variables.map { |attribute| attribute.to_s.delete('@').to_sym }
      end

      def parse_into_array(selector:, klass:)
        if selector.is_a?(Array)
          selector.map { |x| klass.new x }
        elsif selector.is_a?(Hash)
          [klass.new(selector)]
        end
      end

      def parse_into_array_with_options(selector:, klass:, **opts)
        if selector.is_a?(Array)
          selector.map { |x| klass.new(x, **opts) }
        elsif selector.is_a?(Hash)
          [klass.new(selector, **opts)]
        else
          []
        end
      end

      def structure_links(links_arr)
        links_arr.map { |hash| [hash['rel'], hash['href'].gsub('.xml', '')] }.to_h
      end

      # @param existing [Hash{String=>Data}] Existing data hash, ID => entity
      # @param data [Hash, Array] new data to update with
      def update_data(existing, data)
        case data
        when Array
          data.each { |hash| existing[hash['id']].update(hash) }
        when Hash
          existing[data['id']].update(data)
        end
        existing
      end

      # @param existing [Hash{String=>Data}] Existing data hash, ID => entity
      # @param data [Hash, Array] new data to update with
      def create_data(existing = {}, data, klass: nil, **opts)
        existing ||= {} # handles nil case, typically during object instantiation
        case data
        when [], {}
          existing
        when Array
          data.each do |hash|
            current = existing[hash['id']]
            if current
              current.update(hash, **opts)
            else
              current = klass.new(hash, **opts)
              existing[current.id] = current
            end
            existing[current.id]
          end
        when Hash
          existing[data['id']] = klass.new(data, **opts)
        end
        existing
      end

      def parse_out_hashes(data_element)
        if data_element && data_element.is_a?(Array)
          data_element.find { |elem| elem.is_a?(Hash) }
        else
          data_element
        end
      end
    end
  end
end
