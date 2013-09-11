module SpanAdt

  class Loader
    attr_reader :box_id, :server_ip, :server_port

    CONFIG_FILE = "config/config.xml"

    def initialize
       load_xml
    end

    private

    def load_xml
      doc = Nokogiri::XML(open(CONFIG_FILE))

      doc.search("config").each do |config|
        @box_id = config.search("box_id").first.content.to_s
        @server_ip = config.search("server_ip").first.content.to_s
        @server_port = config.search("server_port").first.content.to_i
      end
    end
  end
  
end