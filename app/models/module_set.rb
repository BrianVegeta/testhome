class ModuleSet < ActiveRecord::Base
	KIND_LIST = [
		["分類",0],
		["多篇文章",1],
		["單篇文章",2],
		["留言板",3],
		["檔案下載",4],
		["自訂表單",5],
		["討論區",6],
		["自訂表格",7],
		["成員列表",8],
		["公告列表",9],
		["書本列表",10],
		["轉向網址",11]
	]
	LINK_LIST = [
		["module_sets/configure_cates",0],
		["blogs/index",1],
		["blogs/single",2],
		["posts/index",3],
		["uploads/index",4],
		["custom_blogs/index",5],
		["boards/index",6],
		["table_blogs/index",7],
		["member_list/index",8],
		["sitelogs/module_set",9],
		["books/index",10],
		["reroute/index",11]
	]
	PUBLIC_LINK_LIST = [["",0],["blogs/index",1],["blogs/static",2],["posts/index",3],["uploads/index",4],["custom_blogs/index",5],["boards/index",6],["table_blogs/index",7],["member_list/index",8],["sitelogs/index",9],["books/index",10],["reroute/index",11]]
	def public_path
    if self.kind == 11
      return [self.configure[:reroute_kind] == 1, self.configure[:reroute_newwin] , self.configure[:reroute]]
    else
      return "#{ModuleSet::PUBLIC_LINK_LIST[self.kind][0]}/#{self.id}"
    end
  end
end