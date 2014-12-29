class Domain < ActiveRecord::Base ; end
class DomainAddBuilder < ActiveRecord::Migration
  def self.up
    Punycode
    
    add_column :domains , :ori_name , :string , :null => false
    
    #build ori_name
    
    Domain.all.each do |domain|
      case domain.kind
      when 0 #免費改1 , 自有改2
        temp = domain.name.match(/(.*).ishome.com.tw\z/)
        if temp
          domain.ori_name = Punycode.decode_url(temp[1])
          domain.kind = 1
        else
          domain.ori_name = Punycode.decode_url(domain.name)
          domain.kind = 2
        end
        domain.save
      when 1 #改0
        domain.kind = 0
        domain.ori_name = domain.name
        domain.save
      else
        puts "domain_convert_error : id => #{domain.id} , name => #{domain.name} , ori_kind #{domain.kind}"
        make error
      end
    end
  end

  def self.down
    remove_column :domains , :ori_name
    
    Domain.all.each do |domain|
      case domain.kind
      when 0 #改1
        domain.kind = 1
        domain.save
      when 1..2 #改0
        domain.kind = 0
        domain.save
      else
        puts "domain_convert_error : id => #{domain.id} , name => #{domain.name} , ori_kind #{domain.kind}"
        make error
      end
    end
  end
end
