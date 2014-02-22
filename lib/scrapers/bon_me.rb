class Scrapers::BonMe
  def self.scrape

    %w(monday tuesday wednesday thursday friday saturday sunday).each do |day|
      doc = Nokogiri::HTML(open("http://www.bonmetruck.com/day/#{day}"))

      puts "#{day.titleize} Schedule"
      puts '---'

      # 3 trucks, 3 colors
      %w(blue yellow orange).each do |color|
        block = doc.css("div.#{color}.location")

        block.css('._copy_editable').each_with_index do |loc, i|

          # ignore third "specials" block
          break if i > 1

          times = loc.css('h2').text
          location1 = loc.css('h1').text
          location2 = loc.css('h3 a').text

          puts "#{times} :: #{location1}, #{location2}" if times.present?
        end
        puts ''
      end
    end
  end
end
