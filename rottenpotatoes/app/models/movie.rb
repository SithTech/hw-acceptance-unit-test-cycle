class Movie < ActiveRecord::Base
  def self.all_ratings
    %w(G PG PG-13 NC-17 R)
  end
  
  def self.find_by_director(id)
    #Query the database for movies with the given director
    return self.where(director: self.find(id).director)
  end
end
