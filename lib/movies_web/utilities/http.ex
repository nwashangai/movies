defmodule Http do
  def request(url) do
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
end
