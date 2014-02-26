class Scrapers::RoamingHunger
  def self.scrape

    # iterate list of scraped truck urls
    scrape_truck_list.each do |truck_url|

      # build necessary dates
      today = Date.today.strftime('%Y-%m-%d')
      tomorrow = Date.tomorrow.strftime('%Y-%m-%d')
      
      # build date/time ranges
      breakfast = "/start:#{today}+05:00:01/end:#{today}+10:59:59"
      lunch = "/start:#{today}+11:00:01/end:#{today}+15:59:59"
      dinner = "/start:#{today}+16:00:01/end:#{today}+20:59:59"
      late_night = "/start:#{today}+21:00:01/end:#{tomorrow}+03:59:59"

      # iterate through the 4 constructed ranges
      [breakfast, lunch, dinner, late_night].each do |time_range|

        # construct url
        url = "http://roaminghunger.com/restaurants/getRestaurantTrucksTimeFrame#{truck_url}#{time_range}"

        # testing url
        # url = "http://roaminghunger.com/restaurants/getRestaurantTrucksTimeFrame/penny-packers#{time_range}"

        # parse XML response
        doc = Nokogiri::XML(open(url))
        doc.xpath('//trucklocation').each do |l|
          name = l.xpath('truck/name').text
          location = l.xpath('location').text
          start_time = l.xpath('start').text
          end_time = l.xpath('end').text
          lat = l.xpath('lat').text
          lng = l.xpath('lng').text

          # skip if no data available
          break if name.blank?

          # create or update trucks and truck_posts

        end
      end

    end

  end

  # extract full list of truck url's on the Boston page; the same url's are used to
  # hit the schedule/location API
  def self.scrape_truck_list
    doc = Nokogiri::HTML(open("http://roaminghunger.com/bos"))
    doc.css('ul.squarelist div.thumbnailbox a').map { |e| e['href'] }
  end
end
