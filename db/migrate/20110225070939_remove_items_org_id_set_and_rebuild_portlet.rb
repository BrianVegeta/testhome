class RemoveItemsOrgIdSetAndRebuildPortlet < ActiveRecord::Migration
  ##
  ## 凡是用過這個migrate，請執行一次以下在console
  #  Portlet.all.map{|x|x.save} ; true
  ##
  def self.up
    remove_column :items , :org_id_set
    
    ##rebuild聯賣
    ActiveRecord::Base.connection.execute('
UPDATE organization_joint_groups AS ojg
  LEFT JOIN (
    SELECT organization_joint_group_id AS ojg_id , CONCAT("lft = ",GROUP_CONCAT(org.lft SEPARATOR " OR lft = ")) AS mg_str , GROUP_CONCAT(org.lft SEPARATOR " ") AS mg_lft FROM organization_joints AS oj
      LEFT JOIN organizations AS org ON oj.organization_id = org.id  GROUP BY oj.organization_joint_group_id
  ) AS tm ON tm.ojg_id = ojg.id
SET ojg.query = tm.mg_str , ojg.relation_lft = tm.mg_lft');
    ActiveRecord::Base.connection.execute('
UPDATE organizations AS org
  LEFT JOIN (
    SELECT oj.organization_id AS id , GROUP_CONCAT(ojg.query SEPARATOR " OR ") AS mg_str , GROUP_CONCAT(ojg.relation_lft SEPARATOR " ") AS mg_lft FROM organization_joints AS oj
      LEFT JOIN organization_joint_groups AS ojg ON oj.organization_joint_group_id = ojg.id GROUP BY oj.organization_id
  ) AS tm ON org.id = tm.id
  LEFT JOIN (
    SELECT org.id AS id , GROUP_CONCAT(porg.lft SEPARATOR " ") AS ps_lft FROM organizations AS org RIGHT JOIN organizations AS porg ON org.lft BETWEEN porg.lft AND porg.rgt GROUP BY org.id
  ) AS porg_set ON org.id = porg_set.id
SET org.query = CONCAT("(lft BETWEEN " , org.lft , " AND " , org.rgt , ") OR (" , tm.mg_str ,")") , org.relation_lft = CONCAT(tm.mg_lft , " " , porg_set.ps_lft)')
    ActiveRecord::Base.connection.execute('
UPDATE organizations AS org
  LEFT JOIN (
    SELECT org.id AS id , GROUP_CONCAT(porg.lft SEPARATOR " ") AS ps_lft FROM organizations AS org
      RIGHT JOIN organizations AS porg ON org.lft BETWEEN porg.lft AND porg.rgt GROUP BY org.id
  ) AS porg_set ON org.id = porg_set.id
SET org.query = CONCAT("(lft BETWEEN " , org.lft , " AND " , org.rgt , ")") , org.relation_lft = porg_set.ps_lft  WHERE org.query IS NULL')
    ActiveRecord::Base.connection.execute('
    UPDATE items LEFT JOIN organizations AS org ON items.owner_id = org.id AND items.owner_type = "Organization" SET items.relation_lft = org.relation_lft , items.lft = org.lft')

  end
  def self.down
    add_column :items , :org_id_set , :text
  end
end
