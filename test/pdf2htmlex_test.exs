defmodule Pdf2htmlexTest do
  use ExUnit.Case

  @simple_pdf Path.join(__DIR__, "fixtures/simple.pdf")

  test ".convert with defaults" do
    tmp_dir = rnd_tmp_dir
    Pdf2htmlex.convert(@simple_pdf, tmp_dir)
    assert File.exists?(tmp_dir <> "simple.html")
  end

  defp rnd_tmp_dir do
    dir = System.tmp_dir! <> "/" <> SecureRandom.uuid <> "/"
    File.mkdir! dir
    dir
  end
end
