#!/bin/bash
args=("$@")
sudo docker compose exec app mage "${args[@]}"
mage chown
