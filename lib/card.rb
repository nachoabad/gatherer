require_relative 'fetcher.rb'

class Card < OpenStruct

  def self.all
    @@all ||= Fetcher.new(self).call
  end
end