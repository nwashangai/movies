defmodule Http do
  import Jason

  def request(url) do
    token = Application.get_env(:movies, MoviesWeb.Endpoint)[:token]

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

    response = HTTPoison.request(request)

    case response do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        decode!(body)

      {:error, %HTTPoison.Error{reason: :timeout}} ->
        {:error, :timeout}

      {:error, reason} ->
        {:error, reason}

      _ ->
        raise "Request failed with sever error"
    end
  end
end
