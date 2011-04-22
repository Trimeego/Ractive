class Event < ActiveRecord::Base
  has_many :votes

  def vote_histogram
    query = "select rating, count(*) as vote_count from votes where event_id = #{self.id}"
    
    Event.connection.select_all(query).inject([]) do |votegram, row|
     votegram << [
                    row['rating'],
                    row['vote_count']
                  ]
    end
  end
  
end
