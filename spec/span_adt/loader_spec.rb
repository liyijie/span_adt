require "spec_helper"

module SpanAdt
  describe Loader do
    it "should load the config.xml sucess" do
      loader = Loader.instance
      loader.box_id.should_not be_empty
      loader.server_ip.should_not be_empty
      loader.server_port.should > 0
    end
  end

  
end