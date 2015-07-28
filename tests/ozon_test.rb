require "mechanize"
require "minitest/autorun"
require "fakeweb"

require_relative "../parsers/base_parser.rb"
require_relative "../parsers/ozon_parser.rb"


describe OzonParser do
  before do
    file = File.new(File.dirname(__FILE__) + '/page_stub.html')
    FakeWeb.register_uri(:get, 'http://test.com', body: file, content_type: 'text/html')
    agent = Mechanize.new
    @page = agent.get('http://test.com')
  end
  
  describe "when asked to extract price" do
    it "successfully extracts it" do
      OzonParser.get_price(@page).must_equal '2550'
    end
  end
  
  describe "when asked to extract description" do
    it "successfully extracts it" do
      OzonParser.get_description(@page).must_equal 'Набор посуды "Travola" с антипригарным покрытием, 16 предметов'
    end
  end
end