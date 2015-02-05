class Shop < ActiveRecord::Base
  belongs_to :mobile
  
  validates :mobile_id, uniqueness:  { scope: :mobile,
                                       message: "Only one shop allowed per mobile." }
  validates :buy_type_1, numericality: { only_integer: true, greater_than: 0 }
  validates :buy_type_2, numericality: { only_integer: true, greater_than: 0 }
  validates :buy_type_3, numericality: { only_integer: true, greater_than: 0 }
  validates :buy_type_4, numericality: { only_integer: true, greater_than: 0 }
  validates :buy_type_5, numericality: { only_integer: true, greater_than: 0 }
  validates :open_hour, numericality: { only_integer: true, greater_than: 0 }
  validates :close_hour, numericality: { only_integer: true, greater_than: 0 }
  validates :race, numericality: { only_integer: true, greater_than: -2 }
  
  before_create :default_values
  def default_values
    self.buy_type_1 ||= 0
    self.buy_type_2 ||= 0
    self.buy_type_3 ||= 0
    self.buy_type_4 ||= 0
    self.buy_type_5 ||= 0
    self.open_hour ||= 0
    self.close_hour ||= 0
    self.race ||= -1
  end

end

def hour_from_num(i)
  $hour = nil
  $hour = '12AM' if i == 0
  $hour = '1AM' if i == 1
  $hour = '2AM' if i == 2
  $hour = '3AM' if i == 3
  $hour = '4AM' if i == 4
  $hour = '5AM' if i == 5
  $hour = '6AM' if i == 6
  $hour = '7AM' if i == 7
  $hour = '8AM' if i == 8
  $hour = '9AM' if i == 9
  $hour = '10AM' if i == 10
  $hour = '11AM' if i == 11
  $hour = '12PM' if i == 12
  $hour = '1PM' if i == 13
  $hour = '2PM' if i == 14
  $hour = '3PM' if i == 15
  $hour = '4PM' if i == 16
  $hour = '5PM' if i == 17
  $hour = '6PM' if i == 18
  $hour = '7PM' if i == 19
  $hour = '8PM' if i == 20
  $hour = '9PM' if i == 21
  $hour = '10PM' if i == 22
  $hour = '11PM' if i == 23
  return $hour
end

def race_from_num(i)
  $race = nil
  $race = 'no one' if i == -1
  $race = 'humans' if i == 0
  $race = 'dwarves' if i == 1
  $race = 'elves' if i == 2
  $race = 'gnomes' if i == 3
  $race = 'halfelves' if i == 4
  $race = 'halflings' if i == 5
  $race = 'aarakocra' if i == 6
  $race = 'giants' if i == 7
  $race = 'minotaurs' if i == 8
  $race = 'ogres' if i == 9
  return $race
end