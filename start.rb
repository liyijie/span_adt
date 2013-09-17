# encoding: utf-8

require File.dirname(__FILE__) + "/lib/span_adt"

if SpanAdt::Loader.instance.test != "test"
  SpanAdt::Service.instance.start
end
