{"filter":false,"title":"reset.rb","tooltip":"/app/models/reset.rb","undoManager":{"mark":100,"position":100,"stack":[[{"group":"doc","deltas":[{"start":{"row":71,"column":0},"end":{"row":77,"column":5},"action":"remove","lines":["  def load_mob_name","    if self.area.mobiles.exists?(:id => self.val_2)","      return Mobile.find(self.val_2).sdesc","    else","      return 'UNKNOWN'","    end","  end"]}]}],[{"group":"doc","deltas":[{"start":{"row":71,"column":0},"end":{"row":72,"column":0},"action":"remove","lines":["",""]}]}],[{"group":"doc","deltas":[{"start":{"row":71,"column":0},"end":{"row":72,"column":0},"action":"remove","lines":["",""]}]}],[{"group":"doc","deltas":[{"start":{"row":32,"column":52},"end":{"row":32,"column":70},"action":"remove","lines":["self.load_mob_vnum"]},{"start":{"row":32,"column":52},"end":{"row":32,"column":84},"action":"insert","lines":["mobile_info(self.val_2, 'sdesc')"]}]}],[{"group":"doc","deltas":[{"start":{"row":32,"column":77},"end":{"row":32,"column":82},"action":"remove","lines":["sdesc"]},{"start":{"row":32,"column":77},"end":{"row":32,"column":78},"action":"insert","lines":["f"]}]}],[{"group":"doc","deltas":[{"start":{"row":32,"column":78},"end":{"row":32,"column":79},"action":"insert","lines":["o"]}]}],[{"group":"doc","deltas":[{"start":{"row":32,"column":79},"end":{"row":32,"column":80},"action":"insert","lines":["r"]}]}],[{"group":"doc","deltas":[{"start":{"row":32,"column":77},"end":{"row":32,"column":80},"action":"remove","lines":["for"]},{"start":{"row":32,"column":77},"end":{"row":32,"column":88},"action":"insert","lines":["formal_vnum"]}]}],[{"group":"doc","deltas":[{"start":{"row":71,"column":0},"end":{"row":77,"column":5},"action":"remove","lines":["  def load_mob_vnum","    if self.area.mobiles.exists?(:id => self.val_2)","      return Mobile.find(self.val_2).formal_vnum.to_s","    else","      return 'UNKNOWN'","    end","  end"]}]}],[{"group":"doc","deltas":[{"start":{"row":71,"column":0},"end":{"row":72,"column":2},"action":"remove","lines":["","  "]}]}],[{"group":"doc","deltas":[{"start":{"row":71,"column":0},"end":{"row":72,"column":0},"action":"remove","lines":["",""]}]}],[{"group":"doc","deltas":[{"start":{"row":70,"column":0},"end":{"row":77,"column":5},"action":"remove","lines":["  ","  def load_mob_can_wear?","    if self.area.mobiles.exists?(:id => self.val_2)","      return !Mobile.find(self.val_2).no_wear_eq?","    else","      return false","    end","  end"]}]}],[{"group":"doc","deltas":[{"start":{"row":70,"column":0},"end":{"row":71,"column":2},"action":"remove","lines":["","  "]}]}],[{"group":"doc","deltas":[{"start":{"row":21,"column":72},"end":{"row":21,"column":95},"action":"insert","lines":["room_info(id, property)"]}]}],[{"group":"doc","deltas":[{"start":{"row":21,"column":82},"end":{"row":21,"column":95},"action":"remove","lines":["id, property)"]}]}],[{"group":"doc","deltas":[{"start":{"row":21,"column":87},"end":{"row":21,"column":88},"action":"insert","lines":["v"]}]}],[{"group":"doc","deltas":[{"start":{"row":21,"column":88},"end":{"row":21,"column":89},"action":"insert","lines":["a"]}]}],[{"group":"doc","deltas":[{"start":{"row":21,"column":89},"end":{"row":21,"column":90},"action":"insert","lines":["l"]}]}],[{"group":"doc","deltas":[{"start":{"row":21,"column":87},"end":{"row":21,"column":90},"action":"remove","lines":["val"]},{"start":{"row":21,"column":87},"end":{"row":21,"column":92},"action":"insert","lines":["val_4"]}]}],[{"group":"doc","deltas":[{"start":{"row":21,"column":92},"end":{"row":21,"column":93},"action":"insert","lines":[","]}]}],[{"group":"doc","deltas":[{"start":{"row":21,"column":93},"end":{"row":21,"column":94},"action":"insert","lines":[" "]}]}],[{"group":"doc","deltas":[{"start":{"row":21,"column":94},"end":{"row":21,"column":95},"action":"insert","lines":["'"]}]}],[{"group":"doc","deltas":[{"start":{"row":21,"column":95},"end":{"row":21,"column":96},"action":"insert","lines":["n"]}]}],[{"group":"doc","deltas":[{"start":{"row":21,"column":96},"end":{"row":21,"column":97},"action":"insert","lines":["a"]}]}],[{"group":"doc","deltas":[{"start":{"row":21,"column":97},"end":{"row":21,"column":98},"action":"insert","lines":["m"]}]}],[{"group":"doc","deltas":[{"start":{"row":21,"column":98},"end":{"row":21,"column":99},"action":"insert","lines":["e"]}]}],[{"group":"doc","deltas":[{"start":{"row":21,"column":99},"end":{"row":21,"column":100},"action":"insert","lines":["'"]}]}],[{"group":"doc","deltas":[{"start":{"row":21,"column":100},"end":{"row":21,"column":101},"action":"insert","lines":[")"]}]}],[{"group":"doc","deltas":[{"start":{"row":21,"column":101},"end":{"row":21,"column":102},"action":"remove","lines":["l"]}]}],[{"group":"doc","deltas":[{"start":{"row":21,"column":101},"end":{"row":21,"column":102},"action":"remove","lines":["o"]}]}],[{"group":"doc","deltas":[{"start":{"row":21,"column":101},"end":{"row":21,"column":102},"action":"remove","lines":["a"]}]}],[{"group":"doc","deltas":[{"start":{"row":21,"column":101},"end":{"row":21,"column":102},"action":"remove","lines":["d"]}]}],[{"group":"doc","deltas":[{"start":{"row":21,"column":101},"end":{"row":21,"column":102},"action":"remove","lines":["_"]}]}],[{"group":"doc","deltas":[{"start":{"row":21,"column":101},"end":{"row":21,"column":102},"action":"remove","lines":["r"]}]}],[{"group":"doc","deltas":[{"start":{"row":21,"column":101},"end":{"row":21,"column":102},"action":"remove","lines":["o"]}]}],[{"group":"doc","deltas":[{"start":{"row":21,"column":101},"end":{"row":21,"column":102},"action":"remove","lines":["o"]}]}],[{"group":"doc","deltas":[{"start":{"row":21,"column":101},"end":{"row":21,"column":102},"action":"remove","lines":["m"]}]}],[{"group":"doc","deltas":[{"start":{"row":21,"column":101},"end":{"row":21,"column":102},"action":"remove","lines":["_"]}]}],[{"group":"doc","deltas":[{"start":{"row":21,"column":101},"end":{"row":21,"column":102},"action":"remove","lines":["n"]}]}],[{"group":"doc","deltas":[{"start":{"row":21,"column":101},"end":{"row":21,"column":102},"action":"remove","lines":["a"]}]}],[{"group":"doc","deltas":[{"start":{"row":21,"column":101},"end":{"row":21,"column":102},"action":"remove","lines":["m"]}]}],[{"group":"doc","deltas":[{"start":{"row":21,"column":101},"end":{"row":21,"column":102},"action":"remove","lines":["e"]}]}],[{"group":"doc","deltas":[{"start":{"row":22,"column":69},"end":{"row":22,"column":88},"action":"remove","lines":["self.load_room_name"]},{"start":{"row":22,"column":69},"end":{"row":22,"column":98},"action":"insert","lines":["room_info(self.val_4, 'name')"]}]}],[{"group":"doc","deltas":[{"start":{"row":70,"column":0},"end":{"row":77,"column":5},"action":"remove","lines":["","  def load_room_name","    if self.area.rooms.exists?(:id => self.val_4)","      return Room.find(self.val_4).name","    else","      return 'UNKNOWN'","    end","  end"]}]}],[{"group":"doc","deltas":[{"start":{"row":70,"column":0},"end":{"row":71,"column":2},"action":"remove","lines":["","  "]}]}],[{"group":"doc","deltas":[{"start":{"row":33,"column":56},"end":{"row":33,"column":75},"action":"remove","lines":["self.load_room_vnum"]},{"start":{"row":33,"column":56},"end":{"row":33,"column":94},"action":"insert","lines":["mobile_info(self.val_2, 'formal_vnum')"]}]}],[{"group":"doc","deltas":[{"start":{"row":33,"column":56},"end":{"row":33,"column":62},"action":"remove","lines":["mobile"]},{"start":{"row":33,"column":56},"end":{"row":33,"column":57},"action":"insert","lines":["r"]}]}],[{"group":"doc","deltas":[{"start":{"row":33,"column":57},"end":{"row":33,"column":58},"action":"insert","lines":["o"]}]}],[{"group":"doc","deltas":[{"start":{"row":33,"column":58},"end":{"row":33,"column":59},"action":"insert","lines":["o"]}]}],[{"group":"doc","deltas":[{"start":{"row":33,"column":59},"end":{"row":33,"column":60},"action":"insert","lines":["m"]}]}],[{"group":"doc","deltas":[{"start":{"row":33,"column":75},"end":{"row":33,"column":76},"action":"remove","lines":["2"]},{"start":{"row":33,"column":75},"end":{"row":33,"column":76},"action":"insert","lines":["4"]}]}],[{"group":"doc","deltas":[{"start":{"row":37,"column":56},"end":{"row":37,"column":75},"action":"remove","lines":["self.load_room_vnum"]},{"start":{"row":37,"column":56},"end":{"row":37,"column":92},"action":"insert","lines":["room_info(self.val_4, 'formal_vnum')"]}]}],[{"group":"doc","deltas":[{"start":{"row":71,"column":0},"end":{"row":77,"column":5},"action":"remove","lines":["  def load_room_vnum","    if self.area.rooms.exists?(:id => self.val_4)","      return Room.find(self.val_4).formal_vnum.to_s","    else","      return 'UNKNOWN'","    end","  end"]}]}],[{"group":"doc","deltas":[{"start":{"row":71,"column":0},"end":{"row":72,"column":2},"action":"remove","lines":["","  "]}]}],[{"group":"doc","deltas":[{"start":{"row":71,"column":0},"end":{"row":72,"column":0},"action":"remove","lines":["",""]}]}],[{"group":"doc","deltas":[{"start":{"row":23,"column":67},"end":{"row":23,"column":68},"action":"insert","lines":["r"]}]}],[{"group":"doc","deltas":[{"start":{"row":23,"column":68},"end":{"row":23,"column":69},"action":"insert","lines":["o"]}]}],[{"group":"doc","deltas":[{"start":{"row":23,"column":69},"end":{"row":23,"column":70},"action":"insert","lines":["o"]}]}],[{"group":"doc","deltas":[{"start":{"row":23,"column":70},"end":{"row":23,"column":71},"action":"insert","lines":["m"]}]}],[{"group":"doc","deltas":[{"start":{"row":23,"column":71},"end":{"row":23,"column":72},"action":"insert","lines":["_"]}]}],[{"group":"doc","deltas":[{"start":{"row":23,"column":67},"end":{"row":23,"column":72},"action":"remove","lines":["room_"]},{"start":{"row":23,"column":67},"end":{"row":23,"column":78},"action":"insert","lines":["room_info()"]}]}],[{"group":"doc","deltas":[{"start":{"row":23,"column":77},"end":{"row":23,"column":79},"action":"insert","lines":["()"]}]}],[{"group":"doc","deltas":[{"start":{"row":23,"column":78},"end":{"row":23,"column":79},"action":"remove","lines":[")"]}]}],[{"group":"doc","deltas":[{"start":{"row":23,"column":78},"end":{"row":23,"column":79},"action":"remove","lines":[")"]}]}],[{"group":"doc","deltas":[{"start":{"row":23,"column":77},"end":{"row":23,"column":78},"action":"remove","lines":["("]}]}],[{"group":"doc","deltas":[{"start":{"row":23,"column":82},"end":{"row":23,"column":83},"action":"insert","lines":["v"]}]}],[{"group":"doc","deltas":[{"start":{"row":23,"column":83},"end":{"row":23,"column":84},"action":"insert","lines":["a"]}]}],[{"group":"doc","deltas":[{"start":{"row":23,"column":84},"end":{"row":23,"column":85},"action":"insert","lines":["l"]}]}],[{"group":"doc","deltas":[{"start":{"row":23,"column":82},"end":{"row":23,"column":85},"action":"remove","lines":["val"]},{"start":{"row":23,"column":82},"end":{"row":23,"column":87},"action":"insert","lines":["val_2"]}]}],[{"group":"doc","deltas":[{"start":{"row":23,"column":87},"end":{"row":23,"column":88},"action":"insert","lines":[","]}]}],[{"group":"doc","deltas":[{"start":{"row":23,"column":88},"end":{"row":23,"column":89},"action":"insert","lines":[" "]}]}],[{"group":"doc","deltas":[{"start":{"row":23,"column":89},"end":{"row":23,"column":90},"action":"insert","lines":["'"]}]}],[{"group":"doc","deltas":[{"start":{"row":23,"column":90},"end":{"row":23,"column":91},"action":"insert","lines":["n"]}]}],[{"group":"doc","deltas":[{"start":{"row":23,"column":91},"end":{"row":23,"column":92},"action":"insert","lines":["a"]}]}],[{"group":"doc","deltas":[{"start":{"row":23,"column":92},"end":{"row":23,"column":93},"action":"insert","lines":["m"]}]}],[{"group":"doc","deltas":[{"start":{"row":23,"column":93},"end":{"row":23,"column":94},"action":"insert","lines":["e"]}]}],[{"group":"doc","deltas":[{"start":{"row":23,"column":94},"end":{"row":23,"column":95},"action":"insert","lines":["'"]}]}],[{"group":"doc","deltas":[{"start":{"row":23,"column":95},"end":{"row":23,"column":96},"action":"insert","lines":[")"]}]}],[{"group":"doc","deltas":[{"start":{"row":23,"column":96},"end":{"row":23,"column":97},"action":"remove","lines":["r"]}]}],[{"group":"doc","deltas":[{"start":{"row":23,"column":96},"end":{"row":23,"column":97},"action":"remove","lines":["e"]}]}],[{"group":"doc","deltas":[{"start":{"row":23,"column":96},"end":{"row":23,"column":97},"action":"remove","lines":["s"]}]}],[{"group":"doc","deltas":[{"start":{"row":23,"column":96},"end":{"row":23,"column":97},"action":"remove","lines":["e"]}]}],[{"group":"doc","deltas":[{"start":{"row":23,"column":96},"end":{"row":23,"column":97},"action":"remove","lines":["t"]}]}],[{"group":"doc","deltas":[{"start":{"row":23,"column":96},"end":{"row":23,"column":97},"action":"remove","lines":["_"]}]}],[{"group":"doc","deltas":[{"start":{"row":23,"column":96},"end":{"row":23,"column":97},"action":"remove","lines":["r"]}]}],[{"group":"doc","deltas":[{"start":{"row":23,"column":96},"end":{"row":23,"column":97},"action":"remove","lines":["o"]}]}],[{"group":"doc","deltas":[{"start":{"row":23,"column":96},"end":{"row":23,"column":97},"action":"remove","lines":["o"]}]}],[{"group":"doc","deltas":[{"start":{"row":23,"column":96},"end":{"row":23,"column":97},"action":"remove","lines":["m"]}]}],[{"group":"doc","deltas":[{"start":{"row":23,"column":96},"end":{"row":23,"column":97},"action":"remove","lines":["_"]}]}],[{"group":"doc","deltas":[{"start":{"row":23,"column":96},"end":{"row":23,"column":97},"action":"remove","lines":["n"]}]}],[{"group":"doc","deltas":[{"start":{"row":23,"column":96},"end":{"row":23,"column":97},"action":"remove","lines":["a"]}]}],[{"group":"doc","deltas":[{"start":{"row":23,"column":96},"end":{"row":23,"column":97},"action":"remove","lines":["m"]}]}],[{"group":"doc","deltas":[{"start":{"row":23,"column":96},"end":{"row":23,"column":97},"action":"remove","lines":["e"]}]}],[{"group":"doc","deltas":[{"start":{"row":24,"column":77},"end":{"row":24,"column":97},"action":"remove","lines":["self.reset_room_name"]},{"start":{"row":24,"column":77},"end":{"row":24,"column":106},"action":"insert","lines":["room_info(self.val_2, 'name')"]}]}],[{"group":"doc","deltas":[{"start":{"row":70,"column":0},"end":{"row":77,"column":5},"action":"remove","lines":["","  def reset_room_name","    if self.area.rooms.exists?(:id => self.val_2)","      return Room.find(self.val_2).name","    else","      return 'UNKNOWN'","    end","  end"]}]}],[{"group":"doc","deltas":[{"start":{"row":70,"column":0},"end":{"row":71,"column":2},"action":"remove","lines":["","  "]}]}],[{"group":"doc","deltas":[{"start":{"row":70,"column":0},"end":{"row":77,"column":5},"action":"remove","lines":["","  def reset_room_vnum","    if self.area.rooms.exists?(:id => self.val_2)","      return Room.find(self.val_2).formal_vnum.to_s","    else","      return 'UNKNOWN'","    end","  end"]}]}],[{"group":"doc","deltas":[{"start":{"row":70,"column":0},"end":{"row":71,"column":2},"action":"remove","lines":["","  "]}]}],[{"group":"doc","deltas":[{"start":{"row":40,"column":52},"end":{"row":40,"column":72},"action":"remove","lines":["self.reset_room_vnum"]},{"start":{"row":40,"column":52},"end":{"row":40,"column":88},"action":"insert","lines":["room_info(self.val_4, 'formal_vnum')"]}]}],[{"group":"doc","deltas":[{"start":{"row":40,"column":71},"end":{"row":40,"column":72},"action":"remove","lines":["4"]},{"start":{"row":40,"column":71},"end":{"row":40,"column":72},"action":"insert","lines":["2"]}]}],[{"group":"doc","deltas":[{"start":{"row":44,"column":52},"end":{"row":44,"column":72},"action":"remove","lines":["self.reset_room_vnum"]},{"start":{"row":44,"column":52},"end":{"row":44,"column":88},"action":"insert","lines":["room_info(self.val_2, 'formal_vnum')"]}]}]]},"ace":{"folds":[],"scrolltop":797.5,"scrollleft":0,"selection":{"start":{"row":67,"column":0},"end":{"row":69,"column":5},"isBackwards":true},"options":{"guessTabSize":true,"useWrapMode":false,"wrapToView":true},"firstLineState":0},"timestamp":1424745840453,"hash":"740135177c8d3480ea4e49ab63ac36804d23026f"}