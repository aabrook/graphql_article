defmodule EventTracker.Test.Factory do
  alias EventTracker.{Event, Participant}

  def create(Participant) do
    %Participant{
      name: "Jo Bloggerson"
    }
  end

  def create(Event) do
    %Event{
      name: "Run for a dream",
      activity_type: ["running", "riding"]
    }
  end

  @doc """
  Creates an instance of the given Ecto Schema module type with the supplied attributes.
  ## Examples
      user = create(EventTracker.Participant, name: "Penny P. Hacker")
  """
  @spec create(module, Enum.t()) :: struct
  def create(schema, attributes) do
    schema
    |> create()
    |> struct(attributes)
  end

  @doc """
  Inserts a new instance of the given Ecto schema module into the Repo
  ## Examples
      user = insert(EventTracker.Participant, name: "Penny P. Hacker")
  """
  @spec insert(module, Enum.t()) :: struct
  def insert(schema, attributes \\ []) do
    EventTracker.Repo.insert!(create(schema, attributes))
  end
end
