module SpanAdt

  class Loader
    include Singleton

    attr_reader :box_id, :server_ip, :server_port, :scan_folder, :test

    CONFIG_FILE = "config/config.xml"

    def initialize
       load_xml
    end

    private

    def load_xml
      doc = Nokogiri::XML(open(CONFIG_FILE)).xpath('//config')

      @box_id = doc.xpath('box_id').text
      @server_ip = doc.xpath('server_ip').text
      @server_port = doc.xpath('server_port').text.to_i
      @scan_folder = doc.xpath('scan_folder').text
      @test = doc.xpath('test').text
    end
  end
  
end