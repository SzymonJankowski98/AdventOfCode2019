{:ok, content} = File.read("input.txt")
splitted_content = String.split(content, ~r{(\r\n|\r|\n)})
result = Enum.map(splitted_content, fn n -> Float.floor(String.to_integer(n) / 3) - 2 end) |> Enum.sum

IO.puts(inspect(result))
