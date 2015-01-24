class AddStyleTable < ActiveRecord::Migration
  def change
  	create_table(:styles) do |t|
      t.string 			:name,              null: false, default: ""
      t.belongs_to 	:organization, 			index: true
      t.belongs_to 	:style_template, 		index: true
      t.text 				:html

      t.timestamps
    end
  end
end
