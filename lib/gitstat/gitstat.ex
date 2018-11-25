defmodule Gitstat do
  @file_types %{
    ".rb" => "ruby",
    ".rake" => "ruby",
    ".ru" => "ruby",
    ".rdoc" => "ruby",
    ".gemspect" => "ruby",
    ".js" => "javascript",
    ".javascript" => "javascript",
    ".jsx" => "javascript",
    ".coffee" => "javascript",
    ".css" => "css",
    ".styles" => "css",
    ".html" => "html",
    ".slim" => "html",
    ".haml" => "html",
    ".eex" => "html",
    ".ex" => "elixir",
    ".exs" => "elixir"
  }

  def file_type(extension) do
    Map.get(@file_types, extension)
  end
end
