defmodule Fips do

  def http do
    HTTPoison.start
    HTTPoison.get!("http://neverssl.com")
  end

  def https do
    HTTPoison.start
    HTTPoison.get!("https://postman-echo.com/get")
  end

  def http_google do
    Fips.GoogleHttp.root()
  end

  def https_google do
    Fips.GoogleHttps.root()
  end

end
