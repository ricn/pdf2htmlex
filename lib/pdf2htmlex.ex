defmodule Pdf2htmlex do
  def open(pdf) when is_binary(pdf), do: [pdf]
  def save_to(opts, dir) when is_list(opts), do: ["--dest-dir", dir] ++ opts
  def convert!(opts) when is_list(opts), do: exec_cmd opts

  def zoom(opts, zoom_ratio) when is_list(opts) do
    zoom_as_str = Float.to_string(zoom_ratio, [decimals: 1, compact: true])
    ["--zoom", zoom_as_str] ++ opts
  end

  def first_page(opts, first_p) when is_list(opts) do
    first_p_as_str = Integer.to_string(first_p)
    ["--first-page", first_p_as_str] ++ opts
  end

  def last_page(opts, last_p) when is_list(opts) do
    last_p_as_str = Integer.to_string(last_p)
    ["--last-page", last_p_as_str] ++ opts
  end

  def fit_width(opts, width) when is_list(opts) do
    width_as_str = Integer.to_string(width)
    ["--fit-width", width_as_str] ++ opts
  end

  def fit_height(opts, height) when is_list(opts) do
    height_as_str = Integer.to_string(height)
    ["--fit-height", height_as_str] ++ opts
  end

  defp exec_cmd(opts) do
    cmd = System.find_executable("pdf2htmlex")
    System.cmd(cmd, opts, stderr_to_stdout: true)
  end
end
