defmodule Pdf2htmlexTest do
  use ExUnit.Case

  @simple_pdf Path.join(__DIR__, "fixtures/simple.pdf")

  test ".convert with defaults" do
    tmp_dir = rnd_tmp_dir
    Pdf2htmlex.open(@simple_pdf)
    |> Pdf2htmlex.save_to(tmp_dir)
    |> Pdf2htmlex.convert

    assert File.exists?(tmp_dir <> "simple.html")
  end

  test ".convert with zoom" do
    tmp_dir = rnd_tmp_dir
    Pdf2htmlex.open(@simple_pdf)
    |> Pdf2htmlex.zoom(2.0)
    |> Pdf2htmlex.save_to(tmp_dir)
    |> Pdf2htmlex.convert

    assert File.exists?(tmp_dir <> "simple.html")
  end

  test ".open" do
    assert [@simple_pdf] == Pdf2htmlex.open(@simple_pdf)
  end

  test ".zoom" do
    assert ["--zoom", "2.0"] == Pdf2htmlex.zoom([], 2.0)
  end

  test ".save_to" do
    assert ["--dest-dir", "/tmp"] == Pdf2htmlex.save_to([], "/tmp")
  end

  defp rnd_tmp_dir do
    dir = System.tmp_dir! <> "/" <> SecureRandom.uuid <> "/"
    File.mkdir! dir
    dir
  end
end
