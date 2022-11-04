data =
  File.stream!("input.txt")
  |> Stream.map(
    &(String.split(&1, ",")
      |> String.to_integer)
  )
  |> Stream.run
IO.inspect(data)
