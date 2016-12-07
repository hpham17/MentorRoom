class Event < ApplicationRecord
  def format
    self.strftime("%Y%m%dT%H%M")
  end
end
