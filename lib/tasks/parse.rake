namespace :parse do 
  
  task :street => :environment do 
    puts 'start parse street...'

    uri = URI('http://www.post.gov.tw/post/internet/Postal/streetNameData.jsp')

    process_info = {
      created_count: 0,
      existed_count: 0
    }

    Area::MAIN_AREA.each_with_index do |main_area, main_area_id|
      
      Area::SUB_AREA[main_area_id].each_with_index do |sub_area, sub_area_id|

        # puts "under #{main_area}--#{sub_area}:"

        res = Net::HTTP.post_form(uri, city: main_area, cityarea: sub_area)
        doc = Nokogiri::XML res.body
        streets = doc.xpath("//array0")

        puts "under #{main_area}--#{sub_area}: #{streets.length}"

        streets.each do |street|
          @street_condition = {
            main_area: main_area_id,
            sub_area: sub_area_id,
            name: street.content
          }

          @created = false
          @street = ItemStreet.where(@street_condition).first_or_create do |street|
            @created = true
          end
          unless @created
            puts "#{@street_condition[:name]} existed" unless @created
            process_info[:existed_count] += 1
          end
          
          if @created
            puts "#{@street_condition[:name]} created" if @created
            process_info[:created_count] += 1
          end

        end            
      end
    end

    puts "#{process_info[:created_count]} created, #{process_info[:existed_count]} existed"
    
    
  end

  task :test => :environment do 
    puts 'start parse test...'
    uri = URI('http://www.post.gov.tw/post/internet/Postal/streetNameData.jsp')
    res = Net::HTTP.post_form(uri, city: '桃園市', cityarea: '中壢區')
    puts res.body
  end
end