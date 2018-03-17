#!/bin/bash

initdb
pg_ctl start
cd event_tracker && mix do ecto.create, ecto.migrate
