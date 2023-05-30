defmodule MoviesWeb.MoviesLive.Index do
  import Jason
  use MoviesWeb, :live_view

  def getTopRatedVideos(page) do
    token = Application.get_env(:movies, MoviesWeb.Endpoint)[:token]
    url = "https://api.themoviedb.org/3/movie/top_rated?language=en-US&page=#{page}"

    try do
      request = %HTTPoison.Request{
        method: :get,
        url: url,
        options: [],
        headers: [
          Authorization: "Bearer #{token}"
        ],
        params: [limit: 100],
        body: ""
      }

      {:ok, %HTTPoison.Response{status_code: 200, body: body}} = HTTPoison.request(request)
      body
    rescue
      _e -> []
    end
  end

  def mount(_params, _session, socket) do
    results =
      Enum.map(1..5, fn page ->
        top_rated = getTopRatedVideos(page)
        json_object = decode!(top_rated)
        Map.get(json_object, "results")
      end)

    socket = assign(socket, %{results: List.flatten(results), circumference: 88.49555921538757})
    {:ok, socket}
  end
end
