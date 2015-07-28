class OzonParser < BaseParser
  def self.get_description(page)
    page.search('.bContentColumn').css('h1[itemprop="name"]').children.first.content
  end
  
  def self.get_price(page)
    page.search('.bSaleBlock').css('span[itemprop="price"]').children.first.content
  end
end