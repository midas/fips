defmodule Fips do

  def http do
    HTTPoison.start
    HTTPoison.get!("http://neverssl.com")
  end

  def https do
    HTTPoison.start
    HTTPoison.get!("https://postman-echo.com/get")
  end

  def https_google do
    Fips.Google.root()
  end

end
