class Scrapers::RoamingHunger
  def self.scrape

    # iterate list of scraped truck urls
    scrape_truck_list.each do |truck_url|

      puts ''
      puts "Parsing url: #{truck_url}"

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
        truck_locations = doc.xpath('//trucklocation')
        puts "NO DATA" if truck_locations.blank?

        truck_locations.each do |l|
          name = l.xpath('truck/name').text
          location = l.xpath('location').text
          start_time = Time.parse(l.xpath('start').text).utc
          end_time = Time.parse(l.xpath('end').text).utc
          lat = l.xpath('lat').text
          lng = l.xpath('lng').text

          # skip if no data available
          puts "NO DATA" and next if name.blank?

          puts "Parsing #{name}: #{start_time} - #{end_time}"

          # create or update brands and truck_posts
          brand = Brand.find_by_name(name)
          brand = Brand.create(name: name) if brand.blank?

          # check for existing truck post in same time slot (?)
          existing_post = brand.truck_posts.where("day_of_week = ? AND (start_time = ? OR end_time = ?) AND latitude = ? AND longitude = ?", 
                                                  Date.today.cwday, start_time, end_time, lat, lng).first

          if existing_post.present?
            # if a truck post for same slot exists, simply update it
            puts "Updating existing truck post..."
            existing_post.start_time = start_time
            existing_post.end_time = end_time
            existing_post.latitude = lat
            existing_post.longitude = lng
            existing_post.save
          else
            # otherwise, create a new one
            puts "Creating new truck post..."
            post = brand.truck_posts.create do |tp|
              tp.day_of_week = Date.today.cwday
              tp.start_time = start_time
              tp.end_time = end_time
              tp.latitude = lat
              tp.longitude = lng
            end
          end

        end
      end

    end

  end

  # extract full list of truck url's on the Boston page; the same url's are used to
  # hit the schedule/location API
  def self.scrape_truck_list
    doc = Nokogiri::HTML(open("http://roaminghunger.com/bos"))
    trucks = doc.css('ul.squarelist div.thumbnailbox a').map { |e| e['href'] }

    puts ''
    puts "Trucks to be scraped:"
    puts trucks
    puts ''

    trucks
  end
end
