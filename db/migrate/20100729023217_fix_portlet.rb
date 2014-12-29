class Portlet < ActiveRecord::Base
end
class FixPortlet < ActiveRecord::Migration
  def self.up
    change_column :portlets , :configure , :string , :limit => 2000 , :null => false , :default => "--- []\n\n"
    add_column :portlets , :conf_int , :integer , :null => true , :default => nil
    add_column :portlets , :custom_html , :text , :limit => 3000
    #移除GoogleAD type
    #from [["標籤雲" , 0],["物件列表" , 1],["物件種類" ,2] , ["物件軌跡" , 3] , ["搜尋" , 4] , ["社群討論" , 5] , ["廣告欄位" , 6] , ["GoogleAD" , 7]]
    #to [["標籤雲" , 0],["物件列表" , 1],["物件種類" ,2] , ["物件軌跡" , 3] , ["搜尋" , 4] , ["社群討論" , 5] , ["廣告欄位" , 6] , ["HTML" , 7]]
    Portlet.all(:conditions => "kind = 7").each do |google_ad|
      if google_ad.showon == 1
        google_ad.update_attribute("custom_html" , <<EOF
<script type="text/javascript"><!--
google_ad_client = "pub-6846360606829689";
google_ad_slot = "6720536455";
google_ad_width = 468;
google_ad_height = 60;
//-->
</script>
<script type="text/javascript"
src="http://pagead2.googlesyndication.com/pagead/show_ads.js">
</script>
EOF
        )
      else
        google_ad.update_attribute("custom_html" , <<EOF
<script type="text/javascript"><!--
google_ad_client = "pub-6846360606829689";
google_ad_slot = "9833283432";
google_ad_width = 160;
google_ad_height = 600;
//-->
</script>
<script type="text/javascript"
src="http://pagead2.googlesyndication.com/pagead/show_ads.js">
</script>
EOF
       )
      end
    end
  #選擇：portlet_display的module(於module) / org / kind / showon(欄)然後去joing portlet，然後才join module
  #portlet_disyplay必須連動於portlet，所以portlet要做after_save去修改pd的相關欄位(showon / org / module_set / )
    remove_column :portlets , :showon_kind
    add_column :portlet_displays , :organization_id , :integer
    add_column :portlet_displays , :showon , :integer , :limit => 1
  end

  def self.down
    change_column :portlets , :configure , :text , :default => nil
    remove_column :portlets , :conf_int
    remove_column :portlets , :custom_html
    add_column :portlets , :showon_kind , :integer ,  :limit => 1, :default => nil
    remove_column :portlet_displays , :organization_id
    remove_column :portlet_displays , :showon
  end
end