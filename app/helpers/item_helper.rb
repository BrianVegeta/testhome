module ItemHelper

  PLAIN_RATE_TO_SQUARE_METER = 3.305
  SQUARE_METER_RATE_TO_PLAIN = 0.3025

  def translate_item_type_action(resource)
    Item::TYPE_ACTIONS[resource.type_action_name.to_sym]
  end

  def translate_item_type_name(resource)
    string = ''
    string << Item::TYPE_NAMES[resource.type_first_name.to_sym]
    unless resource.type_last_name.nil?
      string << '-'
      string << Item::TYPE_NAMES[resource.type_last_name.to_sym]
    end
    return string
  end

  def get_address(resource)
    address = ''
    address << Area::MAIN_AREA[resource.main_area]
    address << Area::SUB_AREA[resource.main_area][resource.sub_area]
    address << "#{resource.addr_street}"
    address << "#{resource.addr_alley}巷" if resource.addr_alley.present?
    address << "#{resource.addr_lane}弄" if resource.addr_lane.present?
    address << "#{resource.addr_no}號" unless resource.addr_no_is_hidden

    return address
  end

  def get_floor(resource)
    floor = ''

    if resource.current_floor == '+1'
      floor << "頂樓加蓋"      
    elsif resource.current_floor.include? '-'
      floor << "#{resource.current_floor.gsub('-', 'B')}"  
    else
      floor << "#{resource.current_floor}F"  
    end

    floor << " / #{resource.total_floor}F" if resource.total_floor.present?

    return floor
      
  end

  def get_deposit(resource)
    type = Item::RentHome::DEPOSIT_TYPES.invert[resource.deposit_type.to_sym]
    if resource.deposit_type.to_sym != :other
      return type
    else
      return number_to_currency(resource.deposit, unit: '')
    end
  end

  def get_pattern(resource)
    pattern = ''
    if resource.pattern_room.to_i > 0
      pattern << resource.pattern_room.to_i.to_s << '房'
      pattern << resource.pattern_living.to_i.to_s << '廳'
      pattern << resource.pattern_bath.to_i.to_s << '衛'
      pattern << resource.pattern_balcony.to_i.to_s << '陽台'
    else
      pattern << '樓中樓，' if resource.pattern_entresol_has
      pattern << resource.pattern_balcony.to_i.to_s << '陽台'
    end

    return pattern
  end

  def has_pattern?(resource)
    return resource.pattern_room > 0 || resource.pattern_entresol_has.present?
  end

  def has_parking_column?(resource)
    return resource.has_parking.present?
  end

  def get_rent_period(resource)
    type = resource.rent_period_type.to_sym
    period = ''

    if type != :other
      period << Item::RentHome::RENT_PERIOD_TYPES.invert[type.to_s]
    else
      period << resource.rent_period_number
      period << Item::RentHome::RENT_PERIOD_UNITS.invert[resource.rent_period_unit]
    end
  end

  # 參考單價
  def get_reference_house_price_ten_thousand_by_plain(resource)

    plain = self.get_house_plain(resource)
    
    return resource.house_price_ten_thousand / plain
  end

  def get_house_plain(resource)
    if resource.house_area_unit.to_sym == :plain
      plain = resource.house_total_area_amount
    else
      plain = trans_square_meter_to_plain(resource.house_total_area_amount)
    end
    return plain
  end

  def get_plain_from_area_amount(value, type)
    return value if type.to_sym == :plain
    return trans_square_meter_to_plain(value)
  end

  def trans_square_meter_to_plain(square_meter)
    plain = square_meter.to_f * ItemHelper::SQUARE_METER_RATE_TO_PLAIN
    return plain.round(4)
  end

end