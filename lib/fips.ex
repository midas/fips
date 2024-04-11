defmodule Fips do

  def http_req do
    HTTPoison.start
    HTTPoison.get!("http://neverssl.com")
  end

  def https_req do
    HTTPoison.start
    HTTPoison.get!("https://postman-echo.com/get")
  end

end
