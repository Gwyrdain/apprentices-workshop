{"filter":false,"title":"areas_controller.rb","tooltip":"/app/controllers/areas_controller.rb","undoManager":{"mark":39,"position":39,"stack":[[{"group":"doc","deltas":[{"start":{"row":19,"column":0},"end":{"row":20,"column":23},"action":"remove","lines":["    else","      # render normally"]}]}],[{"group":"doc","deltas":[{"start":{"row":18,"column":62},"end":{"row":19,"column":0},"action":"remove","lines":["",""]}]}],[{"group":"doc","deltas":[{"start":{"row":19,"column":7},"end":{"row":20,"column":0},"action":"insert","lines":["",""]},{"start":{"row":20,"column":0},"end":{"row":20,"column":4},"action":"insert","lines":["    "]}]}],[{"group":"doc","deltas":[{"start":{"row":20,"column":4},"end":{"row":21,"column":0},"action":"insert","lines":["",""]},{"start":{"row":21,"column":0},"end":{"row":21,"column":4},"action":"insert","lines":["    "]}]}],[{"group":"doc","deltas":[{"start":{"row":19,"column":7},"end":{"row":20,"column":0},"action":"insert","lines":["",""]},{"start":{"row":20,"column":0},"end":{"row":20,"column":4},"action":"insert","lines":["    "]}]}],[{"group":"doc","deltas":[{"start":{"row":20,"column":4},"end":{"row":21,"column":0},"action":"insert","lines":["",""]},{"start":{"row":21,"column":0},"end":{"row":21,"column":4},"action":"insert","lines":["    "]}]}],[{"group":"doc","deltas":[{"start":{"row":21,"column":2},"end":{"row":21,"column":4},"action":"remove","lines":["  "]}]}],[{"group":"doc","deltas":[{"start":{"row":21,"column":0},"end":{"row":21,"column":2},"action":"remove","lines":["  "]}]}],[{"group":"doc","deltas":[{"start":{"row":20,"column":4},"end":{"row":21,"column":0},"action":"remove","lines":["",""]}]}],[{"group":"doc","deltas":[{"start":{"row":20,"column":2},"end":{"row":20,"column":4},"action":"remove","lines":["  "]}]}],[{"group":"doc","deltas":[{"start":{"row":20,"column":0},"end":{"row":20,"column":2},"action":"remove","lines":["  "]}]}],[{"group":"doc","deltas":[{"start":{"row":20,"column":0},"end":{"row":24,"column":7},"action":"insert","lines":["    if params[:download]","      $area_file = render_to_string(:partial => 'areas/areablock').gsub('&#39;',\"'\").gsub('&quot;','\"')","      #$area_file = ActionController::Base.helpers.html_safe($area_file)","      send_data($area_file , :filename => @area.name + \".are\")","    end"]}]}],[{"group":"doc","deltas":[{"start":{"row":20,"column":15},"end":{"row":20,"column":23},"action":"remove","lines":["download"]},{"start":{"row":20,"column":15},"end":{"row":20,"column":16},"action":"insert","lines":["p"]}]}],[{"group":"doc","deltas":[{"start":{"row":20,"column":16},"end":{"row":20,"column":17},"action":"insert","lines":["r"]}]}],[{"group":"doc","deltas":[{"start":{"row":20,"column":17},"end":{"row":20,"column":18},"action":"insert","lines":["e"]}]}],[{"group":"doc","deltas":[{"start":{"row":20,"column":18},"end":{"row":20,"column":19},"action":"insert","lines":["v"]}]}],[{"group":"doc","deltas":[{"start":{"row":20,"column":19},"end":{"row":20,"column":20},"action":"insert","lines":["i"]}]}],[{"group":"doc","deltas":[{"start":{"row":20,"column":20},"end":{"row":20,"column":21},"action":"insert","lines":["e"]}]}],[{"group":"doc","deltas":[{"start":{"row":20,"column":21},"end":{"row":20,"column":22},"action":"insert","lines":["w"]}]}],[{"group":"doc","deltas":[{"start":{"row":21,"column":26},"end":{"row":21,"column":35},"action":"remove","lines":["to_string"]}]}],[{"group":"doc","deltas":[{"start":{"row":21,"column":25},"end":{"row":21,"column":26},"action":"remove","lines":["_"]}]}],[{"group":"doc","deltas":[{"start":{"row":21,"column":6},"end":{"row":21,"column":19},"action":"remove","lines":["$area_file = "]}]}],[{"group":"doc","deltas":[{"start":{"row":22,"column":6},"end":{"row":23,"column":62},"action":"remove","lines":["#$area_file = ActionController::Base.helpers.html_safe($area_file)","      send_data($area_file , :filename => @area.name + \".are\")"]}]}],[{"group":"doc","deltas":[{"start":{"row":22,"column":6},"end":{"row":23,"column":0},"action":"remove","lines":["",""]}]}],[{"group":"doc","deltas":[{"start":{"row":22,"column":6},"end":{"row":22,"column":8},"action":"remove","lines":["  "]}]}],[{"group":"doc","deltas":[{"start":{"row":22,"column":6},"end":{"row":22,"column":8},"action":"remove","lines":["  "]}]}],[{"group":"doc","deltas":[{"start":{"row":22,"column":4},"end":{"row":22,"column":6},"action":"remove","lines":["  "]}]}],[{"group":"doc","deltas":[{"start":{"row":22,"column":2},"end":{"row":22,"column":4},"action":"remove","lines":["  "]}]}],[{"group":"doc","deltas":[{"start":{"row":22,"column":2},"end":{"row":22,"column":4},"action":"insert","lines":["  "]}]}],[{"group":"doc","deltas":[{"start":{"row":23,"column":0},"end":{"row":24,"column":4},"action":"remove","lines":["    ","    "]}]}],[{"group":"doc","deltas":[{"start":{"row":22,"column":7},"end":{"row":23,"column":0},"action":"remove","lines":["",""]}]}],[{"group":"doc","deltas":[{"start":{"row":21,"column":43},"end":{"row":21,"column":80},"action":"remove","lines":[".gsub('&#39;',\"'\").gsub('&quot;','\"')"]}]}],[{"group":"doc","deltas":[{"start":{"row":21,"column":36},"end":{"row":21,"column":41},"action":"remove","lines":["block"]},{"start":{"row":21,"column":36},"end":{"row":21,"column":37},"action":"insert","lines":["p"]}]}],[{"group":"doc","deltas":[{"start":{"row":21,"column":37},"end":{"row":21,"column":38},"action":"insert","lines":["r"]}]}],[{"group":"doc","deltas":[{"start":{"row":21,"column":38},"end":{"row":21,"column":39},"action":"insert","lines":["e"]}]}],[{"group":"doc","deltas":[{"start":{"row":21,"column":39},"end":{"row":21,"column":40},"action":"insert","lines":["v"]}]}],[{"group":"doc","deltas":[{"start":{"row":21,"column":40},"end":{"row":21,"column":41},"action":"insert","lines":["i"]}]}],[{"group":"doc","deltas":[{"start":{"row":21,"column":41},"end":{"row":21,"column":42},"action":"insert","lines":["e"]}]}],[{"group":"doc","deltas":[{"start":{"row":21,"column":42},"end":{"row":21,"column":43},"action":"insert","lines":["w"]}]}],[{"group":"doc","deltas":[{"start":{"row":21,"column":13},"end":{"row":21,"column":25},"action":"remove","lines":[":partial => "]}]}]]},"ace":{"folds":[],"scrolltop":87.5,"scrollleft":0,"selection":{"start":{"row":21,"column":13},"end":{"row":21,"column":13},"isBackwards":false},"options":{"guessTabSize":true,"useWrapMode":false,"wrapToView":true},"firstLineState":{"row":6,"state":"start","mode":"ace/mode/ruby"}},"timestamp":1423633801058,"hash":"ab46d745464eb7f9337aa11e8553ecd8a773a59d"}