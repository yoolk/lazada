module Lazada
  module API
    class Response
      attr_reader :response

      def initialize(response)
        @response = response
      end

      def request_id
        response['SuccessResponse']['Head']['RequestId']
      end

      def success?
        response['SuccessResponse'].present?
      end

      def error?
        response['ErrorResponse'].present?
      end

      def warning?
        response['SuccessResponse']['Body']['Warnings'].present?
      end

      def warning_messages
        hash = {}
        response['SuccessResponse']['Body']['Warnings'].each do |warning|
          hash[warning['Field'].dup] = warning['Message']
        end

        hash
      end

      def error_messages
        hash = {}
        response['ErrorResponse']['Body']['Errors'].each do |error|
          hash[error['Field'].dup] = error['Message']
        end

        hash
      end
    end
  end
end
