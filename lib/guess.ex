defmodule Guess do
  @moduledoc """
  Documentation for Guess.
  """

  def main(_args) do
    new_game()
  end

  def new_game do
    random_number = :rand.uniform(10)
    IO.puts("Guess my number [1-10]")

    run_with(random_number)
  end

  def run_with(random_number) do
    res =
      case ask() do
        :exit ->
          :exit

        number ->
          check_guess(random_number, number)
      end

    prompt(res)

    case res do
      :match -> new_game()
      :exit -> :exit
      _ -> run_with(random_number)
    end
  end

  def check_guess(random_number, _number = random_number), do: :match

  def check_guess(random_number, number) do
    if number < random_number do
      :lower
    else
      :greater
    end
  end

  def prompt(res) do
    case res do
      :lower -> "Your number is lower"
      :greater -> "Your number is greater"
      :match -> "Your number match!"
      :exit -> "Bye!"
    end
    |> IO.puts()
  end

  @spec ask :: :error | :exit | integer
  def ask() do
    str = IO.gets("> ") |> String.trim()

    case str do
      "exit" -> :exit
      x -> String.to_integer(x)
    end
  end
end
