# encode: utf-8

module SpanAdt
  class HeartbeatProc
    def proc
      params = {}
      params["Command"] = "Status"
      params["Temp"] = 30
      params["Powermode"] = "I"
      params["Spaceleft"] = "N"
      params["Filesleft"] = 0

      msg = Service.create_request params
      Service.instance.send_msg msg
    end
  end
end