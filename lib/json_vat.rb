require 'net/http'
require 'uri'
require 'json'
require 'json_vat/country'
require 'json_vat/file_cache_backend'

module JSONVAT

  class << self

    def host
      @host ||= 'https://raw.githubusercontent.com/ibericode/vat-rates/master/vat-rates.json'
    end

    attr_writer :rates
    attr_writer :cache
    attr_writer :host

    def cache
      @cache ||= download
    end

    def rates
      @rates ||= JSON.parse(self.cache)['items'].map {
        |key, country| [key, JSONVAT::Country.new(country)]
      }.to_h
    end

    def download
      Net::HTTP.get_response(URI.parse(self.host)).body.force_encoding("utf-8")
    end

    def country(country)
      code = country.to_s.upcase

      # Fix ISO-3166-1-alpha2 exceptions
      if code == 'UK' then code = 'GB' end
      if code == 'EL' then code = 'GR' end

      self.rates[code]
    end

    def [](country)
      country(country)
    end
  end

end
