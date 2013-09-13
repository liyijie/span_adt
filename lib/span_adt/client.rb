# encoding: utf-8

module SpanAdt
  class Client

    def response msg
      puts "response #{msg.to_s}"
      Service.instance.process_msg msg
    end

    def request msg
      puts "request #{msg.to_s}"
      @tcp.write msg.to_s
    end

    def connect
      server_ip = Loader.instance.server_ip
      server_port = Loader.instance.server_port
      Timeout.timeout (3) { @tcp = TCPSocket.new server_ip, server_port}
      Thread.new do
        begin
          receive
        rescue Exception => e
          puts e
          puts e.backtrace
        end
      end
    end

    def disconnect
      @tcp.close if @tcp
    end

    private

    def receive
      buffer = ""
      while line = @tcp.gets # Read lines from socket
        buffer << line
        if buffer.include? "\r\n\r\n"
          msg_params = {}
          buffer.split("\r\n").each do |item|
            if item =~ /=/
              items = item.split("=")
              msg_params[items[0]] = items[1]
            end
          end
          msg = Service.create_response msg_params
          buffer = ""
          response msg
        end
      end
    end

  end
end