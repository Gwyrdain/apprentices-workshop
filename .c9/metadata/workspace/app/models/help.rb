{"changed":true,"filter":false,"title":"help.rb","tooltip":"/app/models/help.rb","value":"class Help < ActiveRecord::Base\n  belongs_to :area\n\n    validates :min_level, numericality: { only_integer: true, greater_than_or_equal_to: 0 }\n    validates :keywords, length: { in: 4..75 }, format: { with: /\\A[ -~]+\\z/, message: \"Only US-ASCII characters are permitted.\" }\n    validates :body, length: { minimum: 4 }, format: { with: /\\A[\\x0A\\x0D -~]+\\z/, message: \"Only US-ASCII characters are permitted.\" }\n\nend\n","undoManager":{"mark":-1,"position":3,"stack":[[{"group":"doc","deltas":[{"start":{"row":5,"column":65},"end":{"row":5,"column":69},"action":"insert","lines":["\\x0A"]}]}],[{"group":"doc","deltas":[{"start":{"row":5,"column":69},"end":{"row":5,"column":73},"action":"insert","lines":["\\x0A"]}]}],[{"group":"doc","deltas":[{"start":{"row":5,"column":72},"end":{"row":5,"column":73},"action":"remove","lines":["A"]}]}],[{"group":"doc","deltas":[{"start":{"row":5,"column":72},"end":{"row":5,"column":73},"action":"insert","lines":["D"]}]}]]},"ace":{"folds":[],"scrolltop":0,"scrollleft":0,"selection":{"start":{"row":5,"column":65},"end":{"row":5,"column":73},"isBackwards":false},"options":{"guessTabSize":true,"useWrapMode":false,"wrapToView":true},"firstLineState":0},"timestamp":1425187878450}