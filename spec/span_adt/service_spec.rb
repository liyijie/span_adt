require "spec_helper"

module SpanAdt

  describe Service do
    it "should correct list the lte file" do
      file_dir = "log"
      # Dir.chdir file_dir
      files = Dir.glob("#{file_dir}/*.lte")
      files.each do |f|
        puts File.expand_path f
      end
    end
  end
end