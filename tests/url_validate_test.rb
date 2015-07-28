require "minitest/autorun"
require "uri"

require_relative '../url_utils'

describe "when validating right url" do
  it "returns success" do 
    right_url = "https://ozon.ru/itemdetails?test=query&param[]=123&param[]=334"
    validate_url(right_url).must_equal true
  end
end

describe "when validating wrong url" do
  it "returns failure when no protocol" do 
    wrong_url = "ozon.ru/itemdetails?test=query&param[]=123&param[]=334"
    validate_url(wrong_url).must_equal false
  end
end