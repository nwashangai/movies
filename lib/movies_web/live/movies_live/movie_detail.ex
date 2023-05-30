defmodule MoviesWeb.MoviesLive.Detail do
  import Jason
  use MoviesWeb, :live_view

  def get_movie_details(movie_id) do
    make_request("https://api.themoviedb.org/3/movie/#{movie_id}?language=en-US")
  end

  def get_movie_credits(movie_id) do
    make_request("https://api.themoviedb.org/3/movie/#{movie_id}/credits?language=en-US")
  end

  def get_movie_reviews(movie_id) do
    make_request("https://api.themoviedb.org/3/movie/#{movie_id}/reviews?language=en-US")
  end

  def make_request(url) do
    token = Application.get_env(:movies, MoviesWeb.Endpoint)[:token]

    try do
      request = %HTTPoison.Request{
        method: :get,
        url: url,
        options: [],
        headers: [
          Authorization: "Bearer #{token}"
        ],
        params: [],
        body: ""
      }

      {:ok, %HTTPoison.Response{status_code: 200, body: body}} = HTTPoison.request(request)
      body
    rescue
      _e -> {:error, "Network error"}
    end
  end

  def mount(params, _session, socket) do
    movie_id = Map.get(params, "movie_id")
    movie_res = get_movie_details(movie_id)
    movie_object = decode!(movie_res)
    credits_res = get_movie_credits(movie_id)
    credits_object = decode!(credits_res)
    review_res = get_movie_reviews(movie_id)
    review_object = decode!(review_res)

    socket =
      assign(socket, %{
        movie: movie_object,
        actors: Map.get(credits_object, "cast"),
        reviews: Map.get(review_object, "results")
      })

    {:ok, socket}
  end
end
