module ItemHelper

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

end