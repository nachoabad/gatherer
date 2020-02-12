require 'net/http'
require 'json'
require 'active_support/inflector'

class Fetcher
  URL = 'https://api.magicthegathering.io/v1/'

  def initialize(klass, threads: 5)
    @klass = klass
    @threads_size = threads
  end

  def call
    items = []
    threads = []

    @threads_size.times do |i|
      page = i + 1
      threads << Thread.new do
        loop do
          data = fetched_data(page: page)
          data.any? ? data.each { |item| items << @klass.new(item) } : break
          page += @threads_size
        end
      end
    end

    threads.each { |thr| thr.join }
    items
  end

  private

  def fetched_data(params)
    response = get_response(params)
    json = JSON.parse(response.body)
    json[api_resource]
  end

  def get_response(params)
    uri = api_uri(params)
    response = Net::HTTP.get_response(uri)
    raise StandardError, 'Response Unavailable' if unavailable_response?(response)
    response
  end

  def api_uri(params)
    uri = URI(URL + api_resource)
    uri.query = URI.encode_www_form(params)
    uri
  end

  def api_resource
    @klass.to_s.underscore.pluralize # Hi Demeter!
  end

  def unavailable_response?(response)
    response_code = response.code
    (500..599).cover?(response_code.to_i)
  end
end