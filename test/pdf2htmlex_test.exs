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

  test "convert with all options" do
    tmp_dir = rnd_tmp_dir
    open(@with_images)
    |> zoom(2.0)
    |> first_page(1)
    |> last_page(2)
    |> hdpi(44)
    |> vdpi(44)
    |> fit_width(640)
    |> fit_height(480)
    |> externalize_css
    |> externalize_font
    |> externalize_image
    |> externalize_javascript
    |> externalize_outline
    |> split_pages
    |> use_mediabox
    |> convert_to!(tmp_dir)

    files = ["with_images.html", "with_images.css", "pdf2htmlEX.min.js",
             "bg1.png", "f1.woff", "with_images.outline", "with_images1.page", "with_images2.page"]
    Enum.each(files, fn(f) -> assert File.exists?(tmp_dir <> f) end)
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
