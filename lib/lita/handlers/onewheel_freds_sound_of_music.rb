require 'rest-client'
require 'nokogiri'

module Lita
  module Handlers
    class OnewheelFredsSoundOfMusic < Handler
      route(/^freds\s+(.*)/i, :freds_search, command: true, help: 'freds whatevs')

      def freds_search(response)
        doc = RestClient.get 'http://www.fredsoundofmusic.com/specials/pre-owned-components.html'
        noko_doc = Nokogiri::HTML doc
        tables = noko_doc.css('#rt-main table')

        records = []

        tables[1].css('tr').each do |tr|
          next if tr.css('td').first.text.strip == 'ID'

          record = {}
          done = false
          tr.css('td').each_with_index do |td, index|
            td_text = td.text.gsub(' ', '')
            case index
              when 0
                record[:id] = td_text.strip
              when 1
                record[:brand] = td_text.strip.capitalize
              when 2
                if td_text.strip.match(/[0-9]/)
                  record[:model] = td_text.strip
                else
                  record[:model] = td_text.strip.capitalize
                end
              when 3
                record[:description] = td_text.strip.capitalize
              when 4
                record[:was_new] = td_text.strip
              when 5
                record[:price] = td_text.strip
            end
          end
          break if record[:brand].empty? and record[:model].empty?
          records.push record
        end
        format_output(response, records)
      end

      def format_output(response, records)
        records.each do |rec|
          response.reply "#{rec[:brand]} #{rec[:model]} was $#{rec[:was_new]}, now $#{rec[:price]}"
        end
      end

      Lita.register_handler(self)
    end
  end
end
