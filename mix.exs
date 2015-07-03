defmodule Pdf2htmlex.Mixfile do
  use Mix.Project

  def project do
    [app: :pdf2htmlex,
     version: "0.0.1",
     elixir: "~> 1.0",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  def application do
    [applications: [:logger]]
  end

  defp deps do
    [{:secure_random, "~> 0.1"}]
  end
end
