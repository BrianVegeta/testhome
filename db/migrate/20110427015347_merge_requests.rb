class JoinRequest < ActiveRecord::Base
end
class OrganizationJointGroupJoinRequest < JoinRequest #聯賣申請
end
class GuildJoinRequest < JoinRequest #公會申請
  serialize :body, Hash
  default_value_for :body,{}
end

class OrganizationJointRequest < ActiveRecord::Base ; end
class OrganizationRequest < ActiveRecord::Base ; end

class OrganizationJointGroup < ActiveRecord::Base ; end
class OrganizationMember < ActiveRecord::Base ; end

class MergeRequests < ActiveRecord::Migration
  def self.up
    create_table "join_requests", :options => 'engine=MyISAM default charset=utf8', :force => true do |t|
      t.string   "type" , :null => false #為多型來支援不同的申請書，body部分可能為haah{公會申請}，因此提出成多型，且本身無實作
      
      t.string   "target_type" , :null => false #申請對象
      t.integer  "target_id" , :null => false #申請對象 #可能為 Headerquarter / OrganizationJointGroup / Guild ...進行觸發
      
      t.integer  "from_user_id" #相容性修正，之前的授權可能無使用者
      t.integer  "from_org_id" #來自組織
      
      t.integer  "to_user_id" #對象人
      t.integer  "to_org_id" #對象組織
      
      t.string   "maked_type" #產生結果
      t.integer  "maked_id" #產生結果 #可能為 Headerquarter / OrganizationJointGroup / Guild ...進行觸發

      t.integer  "status" , :null => false , :limit => 1 , :default => 0 #狀態
      
      t.string   "title" #標題
      t.text     "body" #內文
      
      t.datetime "created_at" , :null => false
      t.datetime "updated_at" , :null => false
    end

    #轉移OJR
    OrganizationJointRequest.all.each do |ojr|
      ojgjr = OrganizationJointGroupJoinRequest.new(
        :title => ojr.title , :body => ojr.body , :created_at => ojr.created_at , :updated_at => ojr.updated_at ,
        :status => ojr.checked ? 0 : 1 , :to_user_id => ojr.user_id , :to_org_id => ojr.organization_id ,
        :target_type => "OrganizationJointGroup" , :target_id => ojr.organization_joint_group_id
      )
      if ojr.checked
        ojgjr.from_org_id = OrganizationJointGroup.find(ojr.organization_joint_group_id).owner_id
      end
      unless ojgjr.to_user_id
        ojgjr.to_user_id = OrganizationMember.first(:conditions => ["organization_id = ? AND level >= 3" , ojr.organization_id]).user_id
      end
      ojgjr.save
    end
    #轉移OR
    
    #  KIND = [["新申請" , 0],["使用者取消",1],["已拒絕" , 2],["已接受" , 3]] => to
    #  STATUS = [["待審核" , 0],["已核可" , 1],["已拒絕" , 2],["已刪除" , 3]]
    
    OrganizationRequest.all.each do |orq|
      gjr = GuildJoinRequest.new(
        :created_at => orq.created_at , :updated_at => orq.updated_at ,
        :target_id => orq.organization_id , #審核為Guild
        :target_type => "Organization" ,
        :to_org_id => orq.organization_id ,
        :from_user_id => orq.user_id , #申請人為User
        :title => orq.name
      )
      case orq.kind
      when 1
        gjr.status = 3
      when 3
        gjr.status = 1
      else
        gjr.status = orq.kind
      end
      gjr.body = {
        :join_name => orq.join_name,
        :master_name => orq.master_name,
        :representative_name => orq.representative_name,
        :capital => orq.capital,
        :serial_number => orq.serial_number,
        :id_number => orq.id_number,
        :phone => orq.phone,
        :fax => orq.fax,
        :main_area => orq.main_area,
        :sub_area => orq.sub_area,
        :address => orq.address,
        :margin_at => orq.pay_at,
        :established_at => orq.established_at,
        :join_at => orq.join_at,
      }
      if orq.maked_org_id #已經有產生Organization
        gjr.maked_type = "Organization"
        gjr.maked_id = orq.maked_org_id
      end
      gjr.save
    end
    
    drop_table "organization_joint_requests"
    drop_table "organization_requests"
  end

  def self.down
    make_error #不可逆
  end
end
