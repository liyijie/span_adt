# encoding: utf-8

module SpanAdt
  class Msg
    # type: [:request, :response]
    attr_accessor :command, :type, :session, :params

    def initialize(command, type, session = nil)
      @command, @type, @session = command, type, session
      @params = {}
    end

    def sn
      if @command == "FTPUpload"
        sn = "#{@command}_#{@params["Filename"]}"
      else
        sn = @command
      end
      sn
    end

    def to_s
      msg_str = ""
      if @type == :request
        msg_str << "[Request]\r\n"
      elsif @type == :response
        msg_str << "[Response]\r\n"
      end
      msg_str << "Command=#{@command}\r\n"
      msg_str << "Session=#{@session}\r\n" if @session
      @params.each do |key, value|
        msg_str << "#{key}=#{value}\r\n"
      end
      msg_str << "\r\n"
      len = msg_str.bytesize
      msg_str = "#{BinData::Uint16be.new(len).to_binary_s}#{msg_str}"

      msg_str
    end

  end
end