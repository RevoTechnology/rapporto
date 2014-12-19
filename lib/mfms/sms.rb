# encoding: UTF-8
require 'net/http'
require 'openssl'
require 'uri'
require 'russian'

module Rapporto
  class SMS

    attr_accessor :phone, :subject, :message

    def initialize(phone, subject, message, translit = @@translit)
      @phone = phone
      @subject = subject
      @message = message
      @translit = translit

      validate!
    end

    def self.settings=(settings={})
      @@server = settings[:server]
      @@port = settings[:port]
      @@translit = !settings[:translit].nil? ? settings[:translit] : false # use translit or not
      validate_settings!
    end

    def send
      self.class.establish_connection.start do |http|
        request = Net::HTTP::Get.new(send_url)
        response = http.request(request)
        body = response.body.split(';')
        return body[0] unless body[0] == 'ok'
        @status = 'sent'
        @id = body[2]
      end
    end

    private

      def self.establish_connection
        Net::HTTP.new(@@server, @@port)
      end

      def validate!
        raise ArgumentError, "Phone should be assigned to #{self.class}." if @phone.nil?
        raise ArgumentError, "Phone number should contain only numbers. Minimum length is 10. #{@phone.inspect} is given." unless @phone =~ /^[0-9]{10,}$/
        raise ArgumentError, "Subject should be assigned to #{self.class}." if @subject.nil?
        raise ArgumentError, "Message should be assigned to #{self.class}." if @message.nil?
      end

      def self.validate_settings!
        raise ArgumentError, "Server should be defined for #{self}." if @@server.nil?
        raise ArgumentError, "Port should be defined for #{self}." if @@port.nil?
        raise ArgumentError, "Port should contain only numbers. #{@@port.inspect} is given." unless @@port.instance_of?(Fixnum)
      end

      def send_url
        message = @translit ? Russian.translit(@message) : @message
        "/revoup?msisdn=#{@phone}&sn=#{@subject}&message=#{URI.encode(message)}&send_time=#{Time.now.strftime("%Y%d%m%H%M%S")}"
      end
  end
end
