#!/bin/bash
set -e

# Remove a potentially pre-existing server.pid for Rails.
rm -f /rootly-1/tmp/pids/server.pid

# Migrate the database before running:
rake db:migrate
rake db:seed

# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"