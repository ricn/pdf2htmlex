defmodule Pdf2htmlexTest do
  use ExUnit.Case
  import Pdf2htmlex

  @simple_pdf Path.join(__DIR__, "fixtures/simple.pdf")
  @multi_page_pdf Path.join(__DIR__, "fixtures/multi_page.pdf")
  @with_images Path.join(__DIR__, "fixtures/with_images.pdf")

  test "simplest conversion possible" do
    tmp_dir = rnd_tmp_dir
    open(@simple_pdf) |> convert_to!(tmp_dir)
    assert File.exists?(tmp_dir <> "simple.html")
  end

  test "convert with zoom" do
    tmp_dir = rnd_tmp_dir
    open(@simple_pdf) |> zoom(2.0) |> convert_to!(tmp_dir)
    assert File.exists?(tmp_dir <> "simple.html")
  end

  test "convert with all externalize options" do
    tmp_dir = rnd_tmp_dir
    open(@with_images)
    |> externalize_css
    |> externalize_font
    |> externalize_image
    |> externalize_javascript
    |> externalize_outline
    |> split_pages
    |> convert_to!(tmp_dir)
    assert File.exists?(tmp_dir <> "with_images.html")
    assert File.exists?(tmp_dir <> "with_images.css")
    assert File.exists?(tmp_dir <> "pdf2htmlEX.min.js")
    assert File.exists?(tmp_dir <> "bg1.png")
    assert File.exists?(tmp_dir <> "f1.woff")
    assert File.exists?(tmp_dir <> "with_images.outline")
    assert File.exists?(tmp_dir <> "with_images1.page")
    assert File.exists?(tmp_dir <> "with_images2.page")
  end

  test "convert with first page and last page set" do
    tmp_dir = rnd_tmp_dir
    open(@multi_page_pdf) |> first_page(2) |> last_page(4) |> convert_to!(tmp_dir)
    assert File.exists?(tmp_dir <> "multi_page.html")
  end

  test "convert with fit width and fit height" do
    tmp_dir = rnd_tmp_dir
    open(@simple_pdf) |> fit_width(640) |> fit_height(480) |> convert_to!(tmp_dir)
    assert File.exists?(tmp_dir <> "simple.html")
  end

  test ".open", do: assert [@simple_pdf] == open(@simple_pdf)
  test ".zoom", do: assert ["--zoom", "2.0"] == zoom([], 2.0)
  test ".first_page", do: assert ["--first-page", "2"] == first_page([], 2)
  test ".last_page", do: assert ["--last-page", "5"] == last_page([], 5)
  test ".fit_width", do: assert ["--fit-width", "1024"] == fit_width([], 1024)
  test ".fit_height", do: assert ["--fit-height", "768"] == fit_height([], 768)
  test ".use_mediabox", do: assert ["--use-cropbox", "0"] == use_mediabox([])
  test ".hdpi", do: assert ["--hdpi", "96"] == hdpi([], 96)
  test ".vdpi", do: assert ["--vdpi", "96"] == vdpi([], 96)
  test ".externalize_css", do: assert ["--embed-css", "0"] == externalize_css([])
  test ".externalize_font", do: assert ["--embed-font", "0"] == externalize_font([])
  test ".externalize_image", do: assert ["--embed-image", "0"] == externalize_image([])
  test ".externalize_javascript", do: assert ["--embed-javascript", "0"] == externalize_javascript([])
  test ".externalize_outline", do: assert ["--embed-outline", "0"] == externalize_outline([])
  test ".split_pages", do: assert ["--split-pages", "1"] == split_pages([])

  defp rnd_tmp_dir do
    dir = System.tmp_dir! <> "/" <> SecureRandom.uuid <> "/"
    File.mkdir! dir
    dir
  end
end
