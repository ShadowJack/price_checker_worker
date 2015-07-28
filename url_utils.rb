def validate_url(url)
  uri = URI.parse(url)
  uri.kind_of?(URI::HTTP) || uri.kind_of?(URI::HTTPS)
rescue URI::InvalidURIError
  false
end
