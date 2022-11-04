defmodule Program do
  def run(input, instructions_counter \\ 0)

  def run(input, instructions_counter) do
    if Enum.at(input, instructions_counter) == 99 do
      input
    else
      save_index = Enum.at(input, instructions_counter + 3)
      result = Program.run_instruction(input, instructions_counter)
      new_input = Stream.with_index(input)
        |> Enum.map(
          fn { value, index } ->
            cond do
              index == save_index -> result
              true -> value
            end
          end
        )
      Program.run(new_input, instructions_counter + 4)
    end
  end

  def run_instruction(input, instructions_counter) do
    index_of_first_value = Enum.at(input, instructions_counter + 1)
    index_of_second_value = Enum.at(input, instructions_counter + 2)

    cond do
      Enum.at(input, instructions_counter) == 1 ->
        Enum.at(input, index_of_first_value) + Enum.at(input, index_of_second_value)
      true ->
        Enum.at(input, index_of_first_value) * Enum.at(input, index_of_second_value)
    end
  end
end

{:ok, content} = File.read("input.txt")
data = Enum.map(String.split(content, ","), fn n -> String.to_integer(n) end)
IO.inspect(Program.run(data))
