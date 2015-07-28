class BaseParser
  
  def self.get_description(page)
    raise NotImplementedError
  end
  
  def self.get_price(page)
    raise NotImplementedError
  end
end