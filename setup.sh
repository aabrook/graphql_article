#!/bin/bash

initdb
pg_ctl start
cd event_tracker && mix do deps.get, ecto.create, ecto.migrate
