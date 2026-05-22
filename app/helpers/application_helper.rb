module ApplicationHelper
  def safe_external_url(url)
    uri = URI.parse(url.to_s)
    uri.scheme.in?(%w[http https]) ? url : nil
  rescue URI::InvalidURIError
    nil
  end
end
