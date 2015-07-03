defmodule Pdf2htmlex do
  def convert(input_file, output_dir) do
    exec_cmd(input_file, output_dir)
  end
  
  defp exec_cmd(input_file, output_dir) do
    opts = [input_file, "--dest-dir", output_dir]
    cmd = System.find_executable("pdf2htmlex")
    System.cmd(cmd, opts, stderr_to_stdout: true)
  end
end
