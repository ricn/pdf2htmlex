defmodule Pdf2htmlexTest do
  use ExUnit.Case
  import Pdf2htmlex
  @simple_pdf Path.join(__DIR__, "fixtures/simple.pdf")

  test ".convert" do
    tmp_dir = rnd_tmp_dir
    open(@simple_pdf) |> save_to(tmp_dir) |> convert
    assert File.exists?(tmp_dir <> "simple.html")
  end

  test ".convert with zoom" do
    tmp_dir = rnd_tmp_dir
    open(@simple_pdf) |> zoom(2.0) |> save_to(tmp_dir) |> convert
    assert File.exists?(tmp_dir <> "simple.html")
  end

  test ".open" do
    assert [@simple_pdf] == open(@simple_pdf)
  end

  test ".zoom" do
    assert ["--zoom", "2.0"] == zoom([], 2.0)
  end

  test ".save_to" do
    assert ["--dest-dir", "/tmp"] == save_to([], "/tmp")
  end

  defp rnd_tmp_dir do
    dir = System.tmp_dir! <> "/" <> SecureRandom.uuid <> "/"
    File.mkdir! dir
    dir
  end
end
