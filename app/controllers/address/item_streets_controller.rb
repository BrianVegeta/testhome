class Address::ItemStreetsController < ApplicationController
  

  # GET /address/item_streets
  # GET /address/item_streets.json
  def index
    respond_to do |format|
      format.json {
        return if Area::MAIN_AREA[params[:ma].to_i].nil?
        return if Area::SUB_AREA[params[:ma].to_i][params[:sa].to_i].nil?
        streets = ItemStreet.where(main_area: params[:ma], sub_area: params[:sa])
        response = streets.map.with_index  do |street, index| 
          { 
            id: index,
            text: "#{street.name}" 
          }
        end

        render json: response
      }
    end
    
  end

end
