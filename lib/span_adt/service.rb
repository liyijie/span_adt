# encoding: utf-8

module SpanAdt
  class Service
    include Singleton

    LOG_TYPE = "*.lte"

    attr_accessor :session
    
    def start
      @client = Client.new
      @callback_map = {}

      # Connect
      @client.connect
      # login
      LoginProc.new.proc

      Dir.chdir Loader.instance.scan_folder
      begin
        loop do
          sleep 5
          scan_logs if @session
        end
      ensure
        puts "logout..."
        LogoutProc.new.proc
        @client.disconnect
      end
    end

    def self.create_request params={}
      type = :request
      self.create_msg type, params
    end

    def self.create_response params={}
      type = :response
      self.create_msg type, params
    end

    def self.create_notype params={}
      type = :notype
      self.create_msg type, params
    end

    def send_event event_mod, event_id
      params = {}
      params["Command"] = "Event"
      params["Ecode"] = event_id
      params["Emodule"] = event_mod
      params["Sec"] = Time.now.to_i
      params["Usec"] = 0
      msg = Service.create_notype params
      send_msg msg
    end

    def send_msg msg, callback = nil
      @callback_map[msg.sn] = callback if callback
      @client.request msg if @client.respond_to? :request
    end

    def process_msg msg
      begin
        callback = @callback_map.delete msg.sn
        callback.on_msg msg if callback && callback.respond_to?(:on_msg)
      rescue Exception => e
        puts "process msg error ..."
      end
    end

    private  

    def scan_logs
      files = Dir.glob LOG_TYPE
      files.each do |f|
        filename = File.expand_path f
        File.rename filename, "#{filename}.proc"
        FileProc.new("#{filename}.proc").proc
      end
    end

    def self.create_msg type, params
      command = params.delete("Command") || params.delete(:command)
      session = params.delete("Session") || params.delete(:session) || instance.session
      msg = Msg.new(command, type, session)
      msg.params = params.clone
      msg
    end
  end
end