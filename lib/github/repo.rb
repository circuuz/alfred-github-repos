# frozen_string_literal: true

require 'json'

module Github
  class Repo
    attr_reader :name, :link, :ssh_url

    def initialize(name, link, ssh_url)
      @name = name
      @link = link
      @ssh_url = ssh_url
    end

    def to_storage_string
      "#{@name},#{@link},#{@ssh_url}"
    end

    def to_alfred_hash
      {
        title: @name,
        subtitle: @link,
        arg: @link,
        text: {
          copy: @ssh_url,
          largetype: @link
        }
      }
    end

    class << self
      def from_storage_string(storage_string)
        name, link, ssh_url = storage_string.split(',')
        new(name, link, ssh_url)
      end

      def from_api_response(api_response)
        new(api_response[:name] + ( api_response[:archived] ? " [ARCHIVED]" : "" ), api_response[:html_url], api_response[:ssh_url])
      end
    end
  end
end
