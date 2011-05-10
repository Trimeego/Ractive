class Event < ActiveRecord::Base
  has_many :votes

  def vote_histogram
    query = "select rating, count(*) as vote_count from votes where event_id = #{self.id} group by rating"
    
    
    
    histogram = [
      {'color'=> '\'#C3443C\'','data' => [[1,0]]},
      {'color'=> '\'#C35D3C\'','data' => [[2,0]]},
      {'color'=> '\'#C3773C\'','data' => [[3,0]]},
      {'color'=> '\'#C3913C\'','data' => [[4,0]]},
      {'color'=> '\'#C3AA3C\'','data' => [[5,0]]},
      {'color'=> '\'#B8B93C\'','data' => [[6,0]]},
      {'color'=> '\'#A1BC3C\'','data' => [[7,0]]},
      {'color'=> '\'#88BE3C\'','data' => [[8,0]]},
      {'color'=> '\'#70C03C\'','data' => [[9,0]]},
      {'color'=> '\'#5AC23C\'','data' => [[10,0]]}
    ]
    
    Event.connection.select_all(query).each do |row|
      if row['rating'] >0 && row['rating'] < 11
        histogram[row['rating']-1]['data'][0] = [row['rating'], 0 + row['vote_count']]
      end
    end
    
    
    
    return histogram
  end
  
  def session_time
    st = self.start_time_utc.strftime("%A %b %d %I:%M%p") 
    ed = self.end_time_utc.strftime("%I:%M%p")
    "#{st} - #{ed}"
  end
end
