defmodule Pdf2htmlexTest do
  use ExUnit.Case
  import Pdf2htmlex
  @simple_pdf Path.join(__DIR__, "fixtures/simple.pdf")
  @multi_page_pdf Path.join(__DIR__, "fixtures/multi_page.pdf")

  test "simplest conversion possible" do
    tmp_dir = rnd_tmp_dir
    open(@simple_pdf) |> save_to(tmp_dir) |> convert!
    assert File.exists?(tmp_dir <> "simple.html")
  end

  test "convert with zoom" do
    tmp_dir = rnd_tmp_dir
    open(@simple_pdf) |> zoom(2.0) |> save_to(tmp_dir) |> convert!
    assert File.exists?(tmp_dir <> "simple.html")
  end

  test "convert with first page and last page set" do
    tmp_dir = rnd_tmp_dir
    open(@multi_page_pdf) |> first_page(2) |> last_page(4) |> save_to(tmp_dir) |> convert!
    assert File.exists?(tmp_dir <> "multi_page.html")
  end

  test "convert with fit width and fit height" do
    tmp_dir = rnd_tmp_dir
    open(@simple_pdf) |> fit_width(640) |> fit_height(480) |> save_to(tmp_dir) |> convert!
    assert File.exists?(tmp_dir <> "simple.html")
  end

  test ".open", do: assert [@simple_pdf] == open(@simple_pdf)
  test ".save_to", do: assert ["--dest-dir", "/tmp"] == save_to([], "/tmp")
  test ".zoom", do: assert ["--zoom", "2.0"] == zoom([], 2.0)
  test ".first_page", do: assert ["--first-page", "2"] == first_page([], 2)
  test ".last_page", do: assert ["--last-page", "5"] == last_page([], 5)
  test ".fit_width", do: assert ["--fit-width", "1024"] == fit_width([], 1024)
  test ".fit_height", do: assert ["--fit-height", "768"] == fit_height([], 768)

  defp rnd_tmp_dir do
    dir = System.tmp_dir! <> "/" <> SecureRandom.uuid <> "/"
    File.mkdir! dir
    dir
  end
end
