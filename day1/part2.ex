defmodule Calculator do
  def call(number) do
    result = Float.floor(number / 3) - 2

    if result > 0 do
      result + Calculator.call(result)
    else
      0
    end
  end
end

{:ok, content} = File.read("input.txt")
splitted_content = String.split(content, ~r{(\r\n|\r|\n)})
result = Enum.map(splitted_content, fn n -> Calculator.call(String.to_integer(n)) end) |> Enum.sum

IO.puts(inspect(result))
