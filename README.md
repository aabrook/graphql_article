# Setup a barebones Phoenix 1.3 API

```bash
mix phx.new event_tracker --no-html --no-brunch
```

When prompted `Fetch and install dependencies? [Yn]` enter `Y`
Follow prompts for initial ecto and to check the server is running

> I had to update my local postgres details

# Generate the schemas
* `mix phx.gen.schema Event events registration_open:utc_datetime registration_close:utc_datetime fundraise_starts:utc_datetime fundraise_ends:utc_datetime participation_starts:utc_datetime participation_ends:utc_datetime name:string activity_type:array:string --binary-id`
* `mix phx.gen.schema Participant participants name:string event_id:references:events --binary-id`
* `mix phx.gen.schema Activity activities type:string completed_at:utc_datetime distance:integer participant_id:references:participants --binary-id`
* `mix ecto.migrate`

# Using this repository

I have setup a default nix install to simplify development instead of managing through docker or brew on OSX. [NixOS](https://nixos.org/nix/)

Once you've started a nix-shell run for the first time use `setup.sh`

Next time you launch your nix-shell use `startup.sh` to launch the required services.

Before you leave the shell run `shutdown.sh`. Shutdown will terminate services that are started within the shell
