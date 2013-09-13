# encode: utf-8

module SpanAdt
  class LogoutProc
    def proc
      # TODO
      logout_params = {}
      logout_params["Command"] = "Logout"

      msg = Service.create_notype logout_params
      Service.instance.send_msg msg
    end
  end
end