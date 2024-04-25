defmodule Fips.GoogleHttps do

  use Tesla

  plug Tesla.Middleware.BaseUrl, "https://www.google.com"

  def root do
    get("/")
  end

end
