defmodule MoviesWeb.MoviesLive.Index do
  import Jason
  import Http
  use MoviesWeb, :live_view

  def decode_uri(url) do
    if url do
      URI.decode(url)
    else
      nil
    end
  end

  def get_top_rated_videos(page \\ 1) do
    request("https://api.themoviedb.org/3/movie/top_rated?language=en-US&page=#{page}")
  end

  def get_searched_videos(search) do
    request("https://api.themoviedb.org/3/search/movie?query=#{search}")
  end

  def mount(params, _session, socket) do
    search = Map.get(params, "search")

    results =
      case search do
        nil -> get_top_rated_videos() |> decode!() |> Map.get("results")
        _ -> get_searched_videos(search) |> decode!() |> Map.get("results")
      end

    socket =
      assign(socket, %{
        results: List.flatten(results),
        search: search |> decode_uri()
      })

    {:ok, socket}
  end
end
