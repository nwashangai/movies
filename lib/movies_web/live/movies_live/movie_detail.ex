defmodule MoviesWeb.MoviesLive.Detail do
  import Http
  use MoviesWeb, :live_view

  def get_movie_details(type, movie_id) do
    request("https://api.themoviedb.org/3/#{type}/#{movie_id}?language=en-US")
  end

  def get_movie_credits(type, movie_id) do
    request("https://api.themoviedb.org/3/#{type}/#{movie_id}/credits?language=en-US")
  end

  def get_movie_reviews(type, movie_id) do
    request("https://api.themoviedb.org/3/#{type}/#{movie_id}/reviews?language=en-US")
  end

  def mount(%{"movie_id" => movie_id, "type" => type}, _session, socket) do
    movie = get_movie_details(type, movie_id)
    credits = get_movie_credits(type, movie_id) |> Map.get("cast")
    reviews = get_movie_reviews(type, movie_id) |> Map.get("results")

    socket =
      assign(socket, %{
        movie: movie,
        actors: credits,
        reviews: reviews,
        type: type,
        error: nil
      })

    {:ok, socket}
  rescue
    error ->
      IO.inspect(error)
      {:ok, assign(socket, %{error: "Network error occurred. Please try again."})}
  end
end
