# frozen_string_literal: true

# Based on Base62 module by sinefunc
# => https://github.com/sinefunc/base62
module Youyouaidi
  class Converter
    class << self
      def encode(uuid)
        base_encode uuid.to_i
      end

      def decode(encoded_uuid)
        encoded_uuid = encoded_uuid.to_s
        unless encoded_uuid.length == ENCODED_LENGTH
          raise Youyouaidi::InvalidUUIDError,
                "`#{encoded_uuid}' needs to have exactly #{ENCODED_LENGTH} characters (has #{encoded_uuid.length})"
        end

        begin
          Youyouaidi::UUID.new convert_bignum_to_uuid_string base_decode encoded_uuid
        rescue Youyouaidi::InvalidUUIDError => e
          raise Youyouaidi::InvalidUUIDError, "`#{encoded_uuid}' could not be decoded to a valid UUID (#{e.message})"
        end
      end

      private

      BASE           = ('0'..'9').to_a + ('a'..'z').to_a + ('A'..'Z').to_a
      ENCODED_LENGTH = 22 # Needs to be greater than `(Math.log 2**128, BASE.length).floor + 1`

      def base_encode(numeric)
        raise Youyouaidi::InvalidUUIDError, "`#{numeric}' needs to be a Numeric" unless numeric.is_a? Numeric

        return '0' if numeric.zero?

        s = String.new

        while numeric.positive?
          s << BASE[numeric.modulo(BASE.size)]
          numeric /= BASE.size
        end
        s << BASE[0] while s.length < ENCODED_LENGTH
        s.reverse
      end

      def base_decode(encoded_numeric)
        s = encoded_numeric.to_s.reverse.chars

        total = 0
        s.each_with_index do |char, index|
          if ord = BASE.index(char)
            total += ord * (BASE.size**index)
          else
            raise Youyouaidi::InvalidUUIDError, "`#{encoded_numeric}' has `#{char}' which is not a valid character"
          end
        end
        total
      end

      def convert_bignum_to_uuid_string(decoded_uuid_bignum)
        decoded_uuid = decoded_uuid_bignum.to_i.to_s(16).rjust(32, '0')
        "#{decoded_uuid[0,
                        8]}-#{decoded_uuid[8, 4]}-#{decoded_uuid[12, 4]}-#{decoded_uuid[16, 4]}-#{decoded_uuid[20, 12]}"
      end
    end
  end
end
