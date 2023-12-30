#!/bin/sh

# TODO: Change to the command for hot reloading
aqua -c /app/aqua.yaml i
go run /app/main.go
