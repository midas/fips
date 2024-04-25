defmodule Fips.MixProject do
  use Mix.Project

  @cookie "cXZMZch5DI6VSqpum3fw7VmfWsQgkqD2MCVVQbvTfYD6dS0anArVGeucCpzWvtnv"

  def project do
    [
      app: :fips,
      version: "0.5.0",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      releases: releases()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:hackney, "~> 1.20"},
      {:httpoison, "~> 2.1"},
      {:tesla, "~> 1.9"},
    ]
  end

  defp releases do
    [
      fips: release_fips(),
    ]
  end

  defp release_fips do
    [
      applications: [
        fips: :permanent,
      ],
      cookie: @cookie,
      include_erts: true,
      include_executables_for: [:unix],
      #steps: [:assemble, :tar],
      #version: "1.0.0"
      version: {:from_app, :fips}
    ]
  end

end
