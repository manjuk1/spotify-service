require 'net/http'

class BaseApiService 

  attr_reader :end_point, :error

  def initialize(url)
    @end_point = url
  end

  def request
    build_resource
    JSON.parse(make_request)
  rescue RestClient::Exception => http_err
    @error = http_err.response
  end

  private

  def build_resource
    @_resource = RestClient::Resource.new(end_point)
  end

  def make_request
    @_resource.get
  end

end