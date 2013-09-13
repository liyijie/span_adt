module SpanAdt
  class FileProc

    def initialize(filename)
      @filename = filename
      @basename = File.basename(filename).sub(".proc", "")
    end

    def proc
      params = {}
      params["Command"] = "FTPUpload"
      params["Filename"] = @basename
      params["TestVersion"] = "outum8.0"
      params["FileStartTime"] = Time.now.strftime "%Y-%m-%d %H:%M:%S"

      msg = Service.create_request params
      Service.instance.send_msg msg, self
    end

    def on_msg msg
      
      upload_file msg

      complete_msg

      modify_filename

    end

    private

    def upload_file msg
      ip = msg.params["UploadServer"]
      port = msg.params["UploadPort"].to_i || 21
      user = msg.params["UserName"]
      password = msg.params["Password"]
      remote_dir = msg.params["UploadDir"]

      ftp = Net::FTP.new()
      begin
        Timeout.timeout(3) { ftp.connect(ip, port) }#默认端口是21  
        ftp.passive = true
        ftp.login(user, password)
        ftp.chdir remote_dir
        Service.instance.send_event "ftp", "0x4100"
      rescue Exception => e
        Service.instance.send_event "ftp", "0x4101"
        return
      end

      begin
        Service.instance.send_event "ftp", "0x4105"
        ftp.putbinaryfile @filename, @basename  
        Service.instance.send_event "ftp", "0x4106"
      rescue Exception => e
        Service.instance.send_event "ftp", "0x4101"
      end
      ftp.close
    end

    def complete_msg
      params = {}
      params["Command"] = "FTPUploadEOF"
      params["FileName"] = @basename
      params["TestVersion"] = "outum8.0"
      params["FileEndTime"] = Time.now.strftime "%Y-%m-%d %H:%M:%S"
      params["FileSize"] = File.size?(@filename).to_i

      msg = Service.create_request params
      Service.instance.send_msg msg
    end

    def modify_filename
      File.rename @filename, @filename.sub(".proc", ".backup")
    end
  end
end