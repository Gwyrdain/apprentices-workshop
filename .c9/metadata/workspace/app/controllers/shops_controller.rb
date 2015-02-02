{"filter":false,"title":"shops_controller.rb","tooltip":"/app/controllers/shops_controller.rb","undoManager":{"mark":25,"position":25,"stack":[[{"group":"doc","deltas":[{"start":{"row":1,"column":0},"end":{"row":42,"column":0},"action":"remove","lines":["  before_action :set_shop, only: [:show, :edit, :update, :destroy]","","  respond_to :html","","  def index","    @shops = Shop.all","    respond_with(@shops)","  end","","  def show","    respond_with(@shop)","  end","","  def new","    @shop = Shop.new","    respond_with(@shop)","  end","","  def edit","  end","","  def create","    @shop = Shop.new(shop_params)","    @shop.save","    respond_with(@shop)","  end","","  def update","    @shop.update(shop_params)","    respond_with(@shop)","  end","","  def destroy","    @shop.destroy","    respond_with(@shop)","  end","","  private","    def set_shop","      @shop = Shop.find(params[:id])","    end",""]},{"start":{"row":1,"column":0},"end":{"row":62,"column":4},"action":"insert","lines":["  before_action :set_special, only: [:show, :edit, :update, :destroy]","  before_action :set_mobile, only: [:index, :show, :new, :edit, :create, :update, :destroy]","  before_action :set_area, only: [:index, :show, :new, :edit, :create, :update, :destroy]","","  respond_to :html","","  def index","    @specials = @mobile.specials","  end","","  def show","","  end","","  def new","    @special = @mobile.specials.build","","  end","","  def edit","","  end","","  def create","    @special = @mobile.specials.create(special_params)","    if @special.save","      redirect_to area_mobile_path(@area, @mobile), notice: 'Special Function was sucessfully created.'","    else","      render action: 'new'","    end","  end","","  def update","    if @special.update(special_params)","      redirect_to area_mobile_path(@area, @mobile), notice: 'Special Function was sucessfully updated.'","    else","      render action: 'edit'","    end ","  end","","  def destroy","    @special.destroy","    if @special.save","      redirect_to area_mobile_path(@area, @mobile), notice: 'Special Function was sucessfully deleted.'","    else","      redirect_to area_mobile_path(@area, @mobile), notice: 'Something went wrong.'","    end","  end","","  private","    def set_special","      @special = Special.find(params[:id])","    end","    ","    def set_mobile","      @mobile = Mobile.find(params[:mobile_id])","    end","    ","    def set_area","      @area = Area.find(@mobile.area.id)","    end","    "]}]}],[{"group":"doc","deltas":[{"start":{"row":1,"column":21},"end":{"row":1,"column":28},"action":"remove","lines":["special"]},{"start":{"row":1,"column":21},"end":{"row":1,"column":25},"action":"insert","lines":["shop"]}]}],[{"group":"doc","deltas":[{"start":{"row":8,"column":5},"end":{"row":8,"column":12},"action":"remove","lines":["special"]},{"start":{"row":8,"column":5},"end":{"row":8,"column":9},"action":"insert","lines":["shop"]}]}],[{"group":"doc","deltas":[{"start":{"row":8,"column":21},"end":{"row":8,"column":28},"action":"remove","lines":["special"]},{"start":{"row":8,"column":21},"end":{"row":8,"column":25},"action":"insert","lines":["shop"]}]}],[{"group":"doc","deltas":[{"start":{"row":16,"column":5},"end":{"row":16,"column":12},"action":"remove","lines":["special"]},{"start":{"row":16,"column":5},"end":{"row":16,"column":9},"action":"insert","lines":["shop"]}]}],[{"group":"doc","deltas":[{"start":{"row":16,"column":20},"end":{"row":16,"column":27},"action":"remove","lines":["special"]},{"start":{"row":16,"column":20},"end":{"row":16,"column":24},"action":"insert","lines":["shop"]}]}],[{"group":"doc","deltas":[{"start":{"row":25,"column":5},"end":{"row":25,"column":12},"action":"remove","lines":["special"]},{"start":{"row":25,"column":5},"end":{"row":25,"column":9},"action":"insert","lines":["shop"]}]}],[{"group":"doc","deltas":[{"start":{"row":25,"column":20},"end":{"row":25,"column":27},"action":"remove","lines":["special"]},{"start":{"row":25,"column":20},"end":{"row":25,"column":24},"action":"insert","lines":["shop"]}]}],[{"group":"doc","deltas":[{"start":{"row":25,"column":33},"end":{"row":25,"column":40},"action":"remove","lines":["special"]},{"start":{"row":25,"column":33},"end":{"row":25,"column":37},"action":"insert","lines":["shop"]}]}],[{"group":"doc","deltas":[{"start":{"row":26,"column":8},"end":{"row":26,"column":15},"action":"remove","lines":["special"]},{"start":{"row":26,"column":8},"end":{"row":26,"column":12},"action":"insert","lines":["shop"]}]}],[{"group":"doc","deltas":[{"start":{"row":34,"column":8},"end":{"row":34,"column":15},"action":"remove","lines":["special"]},{"start":{"row":34,"column":8},"end":{"row":34,"column":12},"action":"insert","lines":["shop"]}]}],[{"group":"doc","deltas":[{"start":{"row":34,"column":20},"end":{"row":34,"column":27},"action":"remove","lines":["special"]},{"start":{"row":34,"column":20},"end":{"row":34,"column":24},"action":"insert","lines":["shop"]}]}],[{"group":"doc","deltas":[{"start":{"row":42,"column":5},"end":{"row":42,"column":12},"action":"remove","lines":["special"]},{"start":{"row":42,"column":5},"end":{"row":42,"column":9},"action":"insert","lines":["shop"]}]}],[{"group":"doc","deltas":[{"start":{"row":43,"column":8},"end":{"row":43,"column":15},"action":"remove","lines":["special"]},{"start":{"row":43,"column":8},"end":{"row":43,"column":12},"action":"insert","lines":["shop"]}]}],[{"group":"doc","deltas":[{"start":{"row":51,"column":12},"end":{"row":51,"column":19},"action":"remove","lines":["special"]},{"start":{"row":51,"column":12},"end":{"row":51,"column":16},"action":"insert","lines":["shop"]}]}],[{"group":"doc","deltas":[{"start":{"row":52,"column":7},"end":{"row":52,"column":14},"action":"remove","lines":["special"]},{"start":{"row":52,"column":7},"end":{"row":52,"column":11},"action":"insert","lines":["shop"]}]}],[{"group":"doc","deltas":[{"start":{"row":27,"column":61},"end":{"row":27,"column":68},"action":"remove","lines":["Special"]},{"start":{"row":27,"column":61},"end":{"row":27,"column":65},"action":"insert","lines":["Shop"]}]}],[{"group":"doc","deltas":[{"start":{"row":35,"column":61},"end":{"row":35,"column":68},"action":"remove","lines":["Special"]},{"start":{"row":35,"column":61},"end":{"row":35,"column":65},"action":"insert","lines":["Shop"]}]}],[{"group":"doc","deltas":[{"start":{"row":44,"column":61},"end":{"row":44,"column":68},"action":"remove","lines":["Special"]},{"start":{"row":44,"column":61},"end":{"row":44,"column":65},"action":"insert","lines":["Shop"]}]}],[{"group":"doc","deltas":[{"start":{"row":52,"column":14},"end":{"row":52,"column":21},"action":"remove","lines":["Special"]},{"start":{"row":52,"column":14},"end":{"row":52,"column":18},"action":"insert","lines":["Shop"]}]}],[{"group":"doc","deltas":[{"start":{"row":44,"column":66},"end":{"row":44,"column":74},"action":"remove","lines":["Function"]}]}],[{"group":"doc","deltas":[{"start":{"row":44,"column":65},"end":{"row":44,"column":66},"action":"remove","lines":[" "]}]}],[{"group":"doc","deltas":[{"start":{"row":35,"column":66},"end":{"row":35,"column":74},"action":"remove","lines":["Function"]}]}],[{"group":"doc","deltas":[{"start":{"row":35,"column":65},"end":{"row":35,"column":66},"action":"remove","lines":[" "]}]}],[{"group":"doc","deltas":[{"start":{"row":27,"column":66},"end":{"row":27,"column":74},"action":"remove","lines":["Function"]}]}],[{"group":"doc","deltas":[{"start":{"row":27,"column":65},"end":{"row":27,"column":66},"action":"remove","lines":[" "]}]}]]},"ace":{"folds":[],"scrolltop":360,"scrollleft":0,"selection":{"start":{"row":27,"column":65},"end":{"row":27,"column":65},"isBackwards":false},"options":{"guessTabSize":true,"useWrapMode":false,"wrapToView":true},"firstLineState":{"row":21,"state":"start","mode":"ace/mode/ruby"}},"timestamp":1422856162766,"hash":"fb06e6eafb999472df820fd1cf8c68d13f6974bb"}