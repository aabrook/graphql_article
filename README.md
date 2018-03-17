# Setup a barebones Phoenix 1.3 API

```bash
mix phx.new event_tracker --no-html --no-brunch
```

When prompted `Fetch and install dependencies? [Yn]` enter `Y`
Follow prompts for initial ecto and to check the server is running

> I had to update my local postgres details

# Generate the schemas
* `mix phx.gen.schema Event events registration_open:utc_datetime registration_close:utc_datetime fundraise_starts:utc_datetime fundraise_ends:utc_datetime participation_starts:utc_datetime participation_ends:utc_datetime name:string activity_type:array:string --binary_id`
* `mix phx.gen.schema Participant participants name:string event_id:references:events --binary_id`
* `mix phx.gen.schema Activity activities type:string completed_at:utc_datetime distance:integer participant_id:references:participants --binary_id`
* Follow steps https://blog.fourk.io/uuids-as-primary-keys-in-phoenix-with-ecto-and-elixir-1dd79e1ecc2e to setup uuids
* `mix ecto.migrate`


