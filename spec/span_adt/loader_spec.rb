require "spec_helper"

module SpanAdt
  describe Loader do
    it "should load the config.xml sucess" do
      loader = Loader.new
      loader.box_id.should == "asdfasdfjlj"
      loader.server_ip.should == "172.30.4.18"
      loader.server_port.should == 99
    end
  end
  
end