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

nouns = Enum.to_list(1..99)
verbs = Enum.to_list(1..99)
Enum.each(nouns, fn noun ->
    Enum.each(verbs, fn verb ->
        new_input = Stream.with_index(data)
          |> Enum.map(
            fn { value, index } ->
              cond do
                index == 1 -> noun
                index == 2 -> verb
                true -> value
              end
            end
          )
        result = Program.run(new_input)
        if Enum.at(result, 0) == 19690720 do
          IO.puts(100 * noun + verb)
        end
      end
    )
  end
)
