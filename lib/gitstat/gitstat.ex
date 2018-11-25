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
    ".md" => "text",
    ".txt" => "text",
    ".sql" => "sql",
    ".yaml" => "yaml",
    ".yml" => "yaml",
    ".json" => "json"
  }

  def file_types, do: @file_types
end
