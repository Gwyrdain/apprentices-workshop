{"changed":true,"filter":false,"title":"area_strings_controller.rb","tooltip":"/app/controllers/area_strings_controller.rb","value":"class AreaStringsController < ApplicationController\n  before_action :set_area_string, only: [:show, :edit, :update, :destroy]\n  before_action :set_area, only: [:index, :show, :new, :edit, :create, :update, :destroy]\n\n  respond_to :html\n\n  def index\n    @area_strings = @area.area_strings\n  end\n\n  def show\n\n  end\n\n  def new\n    @area_string = @area.area_strings.build\n\n    @area_string.vnum = @area.nextarea_stringvnum\n    @area_string.message_to_pc ||= ''\n    @area_string.message_to_room ||= ''\n  end\n\n  def edit\n    \n  end\n\n  def create\n    @area_string = @area.area_strings.create(area_string_params)\n    @area_string.message_to_pc ||= ''\n    @area_string.message_to_room ||= ''\n    \n    if @area_string.save\n      redirect_to area_area_string_path(@area, @area_string), notice: 'String was sucessfully created.'\n    else\n      render action: 'new'\n    end\n  end\n\n  def update\n    if @area_string.update(area_string_params)\n      redirect_to area_area_string_path(@area, @area_string), notice: 'String was sucessfully updated.'\n    else\n      render action: 'edit'\n    end \n  end\n\n  def destroy\n    @area_string.destroy\n    if @area_string.save\n      redirect_to area_area_strings_path(@area), notice: 'String was sucessfully deleted.'\n    else\n      redirect_to area_area_strings_path(@area), notice: 'Something went wrong.'\n    end\n  end\n\n  private\n    def set_area_string\n      @area_string = AreaString.find(params[:id])\n    end\n    \n    def set_area\n        @area = Area.find(params[:area_id])\n    end\n\n    def area_string_params\n      params.require(:area_string).permit(:vnum, :message_to_pc, :message_to_room, :area_id)\n    end\nend\n","undoManager":{"mark":-2,"position":61,"stack":[[{"group":"doc","deltas":[{"start":{"row":2,"column":0},"end":{"row":3,"column":0},"action":"insert","lines":["",""]}]}],[{"group":"doc","deltas":[{"start":{"row":2,"column":0},"end":{"row":2,"column":87},"action":"insert","lines":["before_action :set_area, only: [:index, :show, :new, :edit, :create, :update, :destroy]"]}]}],[{"group":"doc","deltas":[{"start":{"row":2,"column":0},"end":{"row":2,"column":2},"action":"insert","lines":["  "]}]}],[{"group":"doc","deltas":[{"start":{"row":42,"column":7},"end":{"row":43,"column":0},"action":"insert","lines":["",""]},{"start":{"row":43,"column":0},"end":{"row":43,"column":4},"action":"insert","lines":["    "]}]}],[{"group":"doc","deltas":[{"start":{"row":43,"column":4},"end":{"row":44,"column":0},"action":"insert","lines":["",""]},{"start":{"row":44,"column":0},"end":{"row":44,"column":4},"action":"insert","lines":["    "]}]}],[{"group":"doc","deltas":[{"start":{"row":44,"column":4},"end":{"row":46,"column":7},"action":"insert","lines":["    def set_area","        @area = Area.find(params[:area_id])","    end"]}]}],[{"group":"doc","deltas":[{"start":{"row":44,"column":7},"end":{"row":44,"column":8},"action":"remove","lines":[" "]}]}],[{"group":"doc","deltas":[{"start":{"row":44,"column":6},"end":{"row":44,"column":7},"action":"remove","lines":[" "]}]}],[{"group":"doc","deltas":[{"start":{"row":44,"column":4},"end":{"row":44,"column":6},"action":"remove","lines":["  "]}]}],[{"group":"doc","deltas":[{"start":{"row":6,"column":0},"end":{"row":37,"column":5},"action":"remove","lines":["  def index","    @area_strings = AreaString.all","    respond_with(@area_strings)","  end","","  def show","    respond_with(@area_string)","  end","","  def new","    @area_string = AreaString.new","    respond_with(@area_string)","  end","","  def edit","  end","","  def create","    @area_string = AreaString.new(area_string_params)","    @area_string.save","    respond_with(@area_string)","  end","","  def update","    @area_string.update(area_string_params)","    respond_with(@area_string)","  end","","  def destroy","    @area_string.destroy","    respond_with(@area_string)","  end"]},{"start":{"row":6,"column":0},"end":{"row":61,"column":5},"action":"insert","lines":["  def index","    @objs = @area.objs","  end","","  def show","","  end","","  def new","    @obj = @area.objs.build","","    @obj.vnum = @area.nextobjvnum","    @obj.v0 = 0","    @obj.v1 = 0","    @obj.v2 = 0","    @obj.v3 = 0","    @obj.extra_flags = 0","    @obj.wear_flags = 1","    @obj.misc_flags = 0","    @obj.weight = 1","    @obj.cost = 0","  end","","  def edit","    ","  end","","  def create","    @obj = @area.objs.create(obj_params)","    @obj.misc_flags ||= 0","    @obj.extra_flags ||= 0","    @obj.wear_flags ||= 0","    ","    if @obj.save","      redirect_to area_obj_path(@area, @obj), notice: 'Object was sucessfully created.'","    else","      render action: 'new'","    end","  end","","  def update","    if @obj.update(obj_params)","      redirect_to area_obj_path(@area, @obj), notice: 'Object was sucessfully updated.'","    else","      render action: 'edit'","    end ","  end","","  def destroy","    @obj.destroy","    if @obj.save","      redirect_to area_objs_path(@area), notice: 'Object was sucessfully deleted.'","    else","      redirect_to area_objs_path(@area), notice: 'Something went wrong.'","    end","  end"]}]}],[{"group":"doc","deltas":[{"start":{"row":7,"column":5},"end":{"row":7,"column":9},"action":"remove","lines":["objs"]},{"start":{"row":7,"column":5},"end":{"row":7,"column":17},"action":"insert","lines":["area_strings"]}]}],[{"group":"doc","deltas":[{"start":{"row":7,"column":26},"end":{"row":7,"column":30},"action":"remove","lines":["objs"]},{"start":{"row":7,"column":26},"end":{"row":7,"column":38},"action":"insert","lines":["area_strings"]}]}],[{"group":"doc","deltas":[{"start":{"row":15,"column":17},"end":{"row":15,"column":21},"action":"remove","lines":["objs"]},{"start":{"row":15,"column":17},"end":{"row":15,"column":29},"action":"insert","lines":["area_strings"]}]}],[{"group":"doc","deltas":[{"start":{"row":34,"column":17},"end":{"row":34,"column":21},"action":"remove","lines":["objs"]},{"start":{"row":34,"column":17},"end":{"row":34,"column":29},"action":"insert","lines":["area_strings"]}]}],[{"group":"doc","deltas":[{"start":{"row":57,"column":23},"end":{"row":57,"column":27},"action":"remove","lines":["objs"]},{"start":{"row":57,"column":23},"end":{"row":57,"column":35},"action":"insert","lines":["area_strings"]}]}],[{"group":"doc","deltas":[{"start":{"row":59,"column":23},"end":{"row":59,"column":27},"action":"remove","lines":["objs"]},{"start":{"row":59,"column":23},"end":{"row":59,"column":35},"action":"insert","lines":["area_strings"]}]}],[{"group":"doc","deltas":[{"start":{"row":15,"column":5},"end":{"row":15,"column":8},"action":"remove","lines":["obj"]},{"start":{"row":15,"column":5},"end":{"row":15,"column":16},"action":"insert","lines":["area_string"]}]}],[{"group":"doc","deltas":[{"start":{"row":17,"column":5},"end":{"row":17,"column":8},"action":"remove","lines":["obj"]},{"start":{"row":17,"column":5},"end":{"row":17,"column":16},"action":"insert","lines":["area_string"]}]}],[{"group":"doc","deltas":[{"start":{"row":17,"column":34},"end":{"row":17,"column":37},"action":"remove","lines":["obj"]},{"start":{"row":17,"column":34},"end":{"row":17,"column":45},"action":"insert","lines":["area_string"]}]}],[{"group":"doc","deltas":[{"start":{"row":18,"column":5},"end":{"row":18,"column":8},"action":"remove","lines":["obj"]},{"start":{"row":18,"column":5},"end":{"row":18,"column":16},"action":"insert","lines":["area_string"]}]}],[{"group":"doc","deltas":[{"start":{"row":19,"column":5},"end":{"row":19,"column":8},"action":"remove","lines":["obj"]},{"start":{"row":19,"column":5},"end":{"row":19,"column":16},"action":"insert","lines":["area_string"]}]}],[{"group":"doc","deltas":[{"start":{"row":20,"column":5},"end":{"row":20,"column":8},"action":"remove","lines":["obj"]},{"start":{"row":20,"column":5},"end":{"row":20,"column":16},"action":"insert","lines":["area_string"]}]}],[{"group":"doc","deltas":[{"start":{"row":21,"column":5},"end":{"row":21,"column":8},"action":"remove","lines":["obj"]},{"start":{"row":21,"column":5},"end":{"row":21,"column":16},"action":"insert","lines":["area_string"]}]}],[{"group":"doc","deltas":[{"start":{"row":22,"column":5},"end":{"row":22,"column":8},"action":"remove","lines":["obj"]},{"start":{"row":22,"column":5},"end":{"row":22,"column":16},"action":"insert","lines":["area_string"]}]}],[{"group":"doc","deltas":[{"start":{"row":23,"column":5},"end":{"row":23,"column":8},"action":"remove","lines":["obj"]},{"start":{"row":23,"column":5},"end":{"row":23,"column":16},"action":"insert","lines":["area_string"]}]}],[{"group":"doc","deltas":[{"start":{"row":24,"column":5},"end":{"row":24,"column":8},"action":"remove","lines":["obj"]},{"start":{"row":24,"column":5},"end":{"row":24,"column":16},"action":"insert","lines":["area_string"]}]}],[{"group":"doc","deltas":[{"start":{"row":25,"column":5},"end":{"row":25,"column":8},"action":"remove","lines":["obj"]},{"start":{"row":25,"column":5},"end":{"row":25,"column":16},"action":"insert","lines":["area_string"]}]}],[{"group":"doc","deltas":[{"start":{"row":26,"column":5},"end":{"row":26,"column":8},"action":"remove","lines":["obj"]},{"start":{"row":26,"column":5},"end":{"row":26,"column":16},"action":"insert","lines":["area_string"]}]}],[{"group":"doc","deltas":[{"start":{"row":34,"column":5},"end":{"row":34,"column":8},"action":"remove","lines":["obj"]},{"start":{"row":34,"column":5},"end":{"row":34,"column":16},"action":"insert","lines":["area_string"]}]}],[{"group":"doc","deltas":[{"start":{"row":34,"column":45},"end":{"row":34,"column":48},"action":"remove","lines":["obj"]},{"start":{"row":34,"column":45},"end":{"row":34,"column":56},"action":"insert","lines":["area_string"]}]}],[{"group":"doc","deltas":[{"start":{"row":35,"column":5},"end":{"row":35,"column":8},"action":"remove","lines":["obj"]},{"start":{"row":35,"column":5},"end":{"row":35,"column":16},"action":"insert","lines":["area_string"]}]}],[{"group":"doc","deltas":[{"start":{"row":36,"column":5},"end":{"row":36,"column":8},"action":"remove","lines":["obj"]},{"start":{"row":36,"column":5},"end":{"row":36,"column":16},"action":"insert","lines":["area_string"]}]}],[{"group":"doc","deltas":[{"start":{"row":37,"column":5},"end":{"row":37,"column":8},"action":"remove","lines":["obj"]},{"start":{"row":37,"column":5},"end":{"row":37,"column":16},"action":"insert","lines":["area_string"]}]}],[{"group":"doc","deltas":[{"start":{"row":39,"column":8},"end":{"row":39,"column":11},"action":"remove","lines":["obj"]},{"start":{"row":39,"column":8},"end":{"row":39,"column":19},"action":"insert","lines":["area_string"]}]}],[{"group":"doc","deltas":[{"start":{"row":40,"column":23},"end":{"row":40,"column":26},"action":"remove","lines":["obj"]},{"start":{"row":40,"column":23},"end":{"row":40,"column":34},"action":"insert","lines":["area_string"]}]}],[{"group":"doc","deltas":[{"start":{"row":40,"column":48},"end":{"row":40,"column":51},"action":"remove","lines":["obj"]},{"start":{"row":40,"column":48},"end":{"row":40,"column":59},"action":"insert","lines":["area_string"]}]}],[{"group":"doc","deltas":[{"start":{"row":47,"column":8},"end":{"row":47,"column":11},"action":"remove","lines":["obj"]},{"start":{"row":47,"column":8},"end":{"row":47,"column":19},"action":"insert","lines":["area_string"]}]}],[{"group":"doc","deltas":[{"start":{"row":47,"column":27},"end":{"row":47,"column":30},"action":"remove","lines":["obj"]},{"start":{"row":47,"column":27},"end":{"row":47,"column":38},"action":"insert","lines":["area_string"]}]}],[{"group":"doc","deltas":[{"start":{"row":48,"column":23},"end":{"row":48,"column":26},"action":"remove","lines":["obj"]},{"start":{"row":48,"column":23},"end":{"row":48,"column":34},"action":"insert","lines":["area_string"]}]}],[{"group":"doc","deltas":[{"start":{"row":48,"column":48},"end":{"row":48,"column":51},"action":"remove","lines":["obj"]},{"start":{"row":48,"column":48},"end":{"row":48,"column":59},"action":"insert","lines":["area_string"]}]}],[{"group":"doc","deltas":[{"start":{"row":55,"column":5},"end":{"row":55,"column":8},"action":"remove","lines":["obj"]},{"start":{"row":55,"column":5},"end":{"row":55,"column":16},"action":"insert","lines":["area_string"]}]}],[{"group":"doc","deltas":[{"start":{"row":56,"column":8},"end":{"row":56,"column":11},"action":"remove","lines":["obj"]},{"start":{"row":56,"column":8},"end":{"row":56,"column":19},"action":"insert","lines":["area_string"]}]}],[{"group":"doc","deltas":[{"start":{"row":57,"column":58},"end":{"row":57,"column":64},"action":"remove","lines":["Object"]},{"start":{"row":57,"column":58},"end":{"row":57,"column":64},"action":"insert","lines":["String"]}]}],[{"group":"doc","deltas":[{"start":{"row":40,"column":71},"end":{"row":40,"column":77},"action":"remove","lines":["Object"]},{"start":{"row":40,"column":71},"end":{"row":40,"column":77},"action":"insert","lines":["String"]}]}],[{"group":"doc","deltas":[{"start":{"row":48,"column":71},"end":{"row":48,"column":77},"action":"remove","lines":["Object"]},{"start":{"row":48,"column":71},"end":{"row":48,"column":77},"action":"insert","lines":["String"]}]}],[{"group":"doc","deltas":[{"start":{"row":37,"column":17},"end":{"row":37,"column":27},"action":"remove","lines":["wear_flags"]},{"start":{"row":37,"column":17},"end":{"row":37,"column":18},"action":"insert","lines":["m"]}]}],[{"group":"doc","deltas":[{"start":{"row":37,"column":18},"end":{"row":37,"column":19},"action":"insert","lines":["e"]}]}],[{"group":"doc","deltas":[{"start":{"row":37,"column":19},"end":{"row":37,"column":20},"action":"insert","lines":["s"]}]}],[{"group":"doc","deltas":[{"start":{"row":37,"column":20},"end":{"row":37,"column":21},"action":"insert","lines":["s"]}]}],[{"group":"doc","deltas":[{"start":{"row":37,"column":17},"end":{"row":37,"column":21},"action":"remove","lines":["mess"]},{"start":{"row":37,"column":17},"end":{"row":37,"column":32},"action":"insert","lines":["message_to_room"]}]}],[{"group":"doc","deltas":[{"start":{"row":36,"column":17},"end":{"row":36,"column":28},"action":"remove","lines":["extra_flags"]},{"start":{"row":36,"column":17},"end":{"row":36,"column":18},"action":"insert","lines":["m"]}]}],[{"group":"doc","deltas":[{"start":{"row":36,"column":18},"end":{"row":36,"column":19},"action":"insert","lines":["e"]}]}],[{"group":"doc","deltas":[{"start":{"row":36,"column":19},"end":{"row":36,"column":20},"action":"insert","lines":["s"]}]}],[{"group":"doc","deltas":[{"start":{"row":36,"column":20},"end":{"row":36,"column":21},"action":"insert","lines":["s"]}]}],[{"group":"doc","deltas":[{"start":{"row":36,"column":17},"end":{"row":36,"column":21},"action":"remove","lines":["mess"]},{"start":{"row":36,"column":17},"end":{"row":36,"column":30},"action":"insert","lines":["message_to_pc"]}]}],[{"group":"doc","deltas":[{"start":{"row":35,"column":0},"end":{"row":35,"column":33},"action":"remove","lines":["    @area_string.misc_flags ||= 0"]}]}],[{"group":"doc","deltas":[{"start":{"row":35,"column":0},"end":{"row":36,"column":0},"action":"remove","lines":["",""]}]}],[{"group":"doc","deltas":[{"start":{"row":35,"column":35},"end":{"row":35,"column":36},"action":"remove","lines":["0"]}]}],[{"group":"doc","deltas":[{"start":{"row":35,"column":35},"end":{"row":35,"column":37},"action":"insert","lines":["''"]}]}],[{"group":"doc","deltas":[{"start":{"row":36,"column":37},"end":{"row":36,"column":38},"action":"remove","lines":["0"]}]}],[{"group":"doc","deltas":[{"start":{"row":36,"column":37},"end":{"row":36,"column":39},"action":"insert","lines":["''"]}]}],[{"group":"doc","deltas":[{"start":{"row":18,"column":4},"end":{"row":26,"column":25},"action":"remove","lines":["@area_string.v0 = 0","    @area_string.v1 = 0","    @area_string.v2 = 0","    @area_string.v3 = 0","    @area_string.extra_flags = 0","    @area_string.wear_flags = 1","    @area_string.misc_flags = 0","    @area_string.weight = 1","    @area_string.cost = 0"]},{"start":{"row":18,"column":4},"end":{"row":19,"column":39},"action":"insert","lines":["@area_string.message_to_pc ||= ''","    @area_string.message_to_room ||= ''"]}]}]]},"ace":{"folds":[],"scrolltop":103,"scrollleft":0,"selection":{"start":{"row":19,"column":39},"end":{"row":19,"column":39},"isBackwards":false},"options":{"guessTabSize":true,"useWrapMode":false,"wrapToView":true},"firstLineState":{"row":6,"state":"start","mode":"ace/mode/ruby"}},"timestamp":1423102129000}