class ViewingParty < ApplicationRecord
  has_many :user_viewing_parties
  has_many :users, through: :user_viewing_parties

  validates_presence_of :movie_id, :duration, :date, :start_time

  def movie_title
    MovieService.movie(self.movie_id)[:original_title]
  end

  def movie_poster
    poster_path = MovieService.movie(self.movie_id)[:poster_path]
    MovieService.image(poster_path)
  end
end
