class Event < ActiveRecord::Base
  has_many :votes

  def vote_histogram
    query = "select rating, count(*) as vote_count from votes where event_id = #{self.id} group by rating"
    
    histogram = [0,0,0,0,0,0,0,0,0,0]
    
    Event.connection.select_all(query).each do |row|
      histogram[row['rating']] = row['vote_count']
    end
    
    return histogram
  end
  
end
