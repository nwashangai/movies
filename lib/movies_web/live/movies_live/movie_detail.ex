defmodule MoviesWeb.MoviesLive.Detail do
  import Jason
  import Http
  use MoviesWeb, :live_view

  def get_movie_details(movie_id) do
    request("https://api.themoviedb.org/3/movie/#{movie_id}?language=en-US")
  end

  def get_movie_credits(movie_id) do
    request("https://api.themoviedb.org/3/movie/#{movie_id}/credits?language=en-US")
  end

  def get_movie_reviews(movie_id) do
    request("https://api.themoviedb.org/3/movie/#{movie_id}/reviews?language=en-US")
  end

  def mount(%{"movie_id" => movie_id}, _session, socket) do
    movie = decode!(get_movie_details(movie_id))
    credits = decode!(get_movie_credits(movie_id))
    reviews = decode!(get_movie_reviews(movie_id))

    socket =
      assign(socket, %{
        movie: movie,
        actors: Map.get(credits, "cast"),
        reviews: Map.get(reviews, "results")
      })

    {:ok, socket}
  end
end
