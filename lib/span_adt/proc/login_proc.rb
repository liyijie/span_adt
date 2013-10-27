# encode: utf-8

module SpanAdt
  class LoginProc
    
    def proc

      login_params = {}
      login_params["Command"] = "Login"
      login_params["User"] = Loader.instance.box_id
      login_params["Pass"] = @password || get_password(Loader.instance.box_id)
      login_params["Sver"] = "outum8.0"
      login_params["Cver"] = 1

      msg = Service.create_request login_params
      Service.instance.send_msg msg, self
    end

    def on_msg msg
      Service.instance.session = msg.session

      result = msg.params["Result"]
      if result == "AC"
        Thread.new do
          loop do
            HeartbeatProc.new.proc
            sleep 60
          end
        end
      else
        @password = msg.params["NewPWD"]
        sleep 10
        self.proc
      end
    end

    private

    def get_password box_id
      reverse_id = 0xFFFFFFFF - box_id.to_i(16)
      password = sprintf("%8x", reverse_id)
    end
  end
  
end