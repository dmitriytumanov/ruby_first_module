# <Train> class.
# This class is used to control the train.

class Train
  attr_accessor :number, :speed, :wagons, :route, :current_station_index, :type

  def initialize(number, type, wagons)
    @number = number
    @type = type
    @wagons = wagons
    @speed = 0
  end

  def speed_up
    self.speed += 10
    puts "Train picked up speed. Current speed = #{self.speed}"
  end

  def stop
    self.speed = 0
    puts "Train stopped. Current speed = #{self.speed}"
  end

  def wagons_change(action)
    if self.speed != 0
      puts "Stop train!!! Train is going at a speed #{self.speed} kph."
    elsif action == "attach"
      self.wagons += 1
      puts "You attach wagon. In this train there are #{self.wagons} wagons."
    elsif action == "unhook" && self.wagons > 0
      self.wagons -= 1
      puts "You unhook wagon. In this train there are #{self.wagons} wagons."
    end
  end

  def take_route(route)
    self.route = route
    self.current_station_index = 0
    self.route.stations_in_rout.first.take_train(self)
    puts "Route of this train is from #{self.route.start_station.name} to #{self.route.end_station.name}"
  end

  def change_station(direction)
    if direction == "next"
      current_station.send_train(self)
      self.current_station_index += 1
      current_station.take_train(self)
    elsif direction == "previous"
      current_station.send_train(self)
      self.current_station_index -= 1
      current_station.take_train(self)
    end
  end

  def which_station(direction)
    if direction == "current"
      station = self.route.stations_in_rout[current_station_index]
      puts "#{direction.capitalize!} station is #{station.name}"
      return station
    elsif direction == "next"
      station = self.route.stations_in_rout[current_station_index + 1]
      puts "#{direction.capitalize!} station is #{station.name}"
      return station
    elsif direction == "previous"
      station = self.route.stations_in_rout[current_station_index - 1]
      puts "#{direction.capitalize!} station is #{station.name}"
      return station
    end
  end

  def current_station
    self.route.stations_in_rout[current_station_index]
  end
end