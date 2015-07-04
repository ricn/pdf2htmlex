Pdf2htmlex
==========
Elixir library to convert PDF documents to HTML without losing text or format.

[![Build Status](https://travis-ci.org/ricn/pdf2htmlex.png?branch=master)](https://travis-ci.org/ricn/pdf2htmlex)

## Requirements

The command line tool [pdf2htmlex](http://coolwanglu.github.io/pdf2htmlEX/) must be installed on your system and the binary must be on your PATH.

## Installation

Add this to your `mix.exs` file, then run `mix do deps.get, deps.compile`:

```elixir
  {:pdf2htmlex, "~> 0.1"}
```

## Examples
```elixir
  import Pdf2htmlex
  # Simplest conversion possible.
  open("/Users/ricn/pdfs/sample.pdf") |> convert_to!("/Users/ricn/html")

  # Set zoom ratio to 150 % and set horizontal and vertical dpi to 96 for images.
  open("/Users/ricn/pdfs/sample.pdf")
  |> zoom(1.5)
  |> hdpi(96)
  |> vdpi(96)
  |> convert_to!("/Users/ricn/html")

  # Set the maximum width to 640 pixels and maximum height to 480 pixels
  open("/Users/ricn/pdfs/sample.pdf")
  |> fit_width(640)
  |> fit_height(480)
  |> convert_to!("/Users/ricn/html")

  # Converts only page 1 to 10
  open("/Users/ricn/pdfs/sample.pdf")
  |> first_page(1)
  |> last_page(10)
  |> convert_to!("/Users/ricn/html")

  # For more options see the documentation
```

## Credits

The following people have contributed ideas, documentation, or code to Pdf2htmlex:

* Richard Nyström

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
