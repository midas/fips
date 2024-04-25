defmodule Fips.GoogleHttp do

  use Tesla

  plug Tesla.Middleware.BaseUrl, "http://www.google.com"

  def root do
    get("/")
  end

end
