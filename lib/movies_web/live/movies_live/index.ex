defmodule MoviesWeb.MoviesLive.Index do
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

  def get_searched_videos(search, page \\ 1) do
    IO.inspect("https://api.themoviedb.org/3/search/movie?query=#{search}&page=#{page}")
    request("https://api.themoviedb.org/3/search/movie?query=#{search}&page=#{page}")
  end

  def mount(params, _session, socket) do
    search = Map.get(params, "search")

    results =
      case search do
        nil ->
          get_top_rated_videos()

        _ ->
          get_searched_videos(search)
      end

    socket =
      assign(socket, %{
        results: results |> Map.get("results"),
        page: results |> Map.get("page"),
        total_pages:
          if search do
            results |> Map.get("total_pages")
          else
            5
          end,
        search: search |> decode_uri(),
        error: nil
      })

    {:ok, socket}
  rescue
    _ -> {:ok, assign(socket, %{error: "Network error occurred. Please try again."})}
  end

  def handle_event("load_more", _payload, socket) do
    %{results: current_results, search: current_search, page: current_page} = socket.assigns
    next_page = current_page + 1

    results =
      case current_search do
        nil -> get_top_rated_videos(next_page)
        _ -> get_searched_videos(current_search |> URI.encode(), next_page)
      end
      |> Map.get("results")

    socket =
      socket
      |> assign(:results, current_results ++ results)
      |> assign(:page, next_page)

    {:noreply, socket}
  end
end
