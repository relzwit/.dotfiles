{ config, pkgs, ... }:

{
  system.activationScripts.cleanupGenerations.text = ''
    #!/usr/bin/env bash

    # Get the list of system generations older than 14 days
    old_generations=$(nix-env --list-generations --profile /nix/var/nix/profiles/system --no-name --no-location --date \
      | awk -v date="$(date -d '14 days ago' +%s)" '$1 < date {print $2}')

    # Count how many generations we’re going to delete
    count=$(echo "$old_generations" | wc -l)

    # If there’s nothing to delete, just exit
    if [ "$count" -eq 0 ]; then
      echo "🗑️ No old generations to delete."
      exit 0
    fi

    # Calculate total size of these generations
    space_freed=$(echo "$old_generations" | while read -r gen; do
      path="/nix/var/nix/profiles/system-$gen-link"
      if [ -L "$path" ]; then
        du -sm "$(readlink -f "$path")" 2>/dev/null | awk '{s+=$1} END {print s}'
      fi
    done | awk '{s+=$1} END {print s}')

    # Delete old generations
    nix-env --delete-generations 14d

    # Print the final message
    echo "🗑️ Deleted $count generations. ${space_freed:-0} MB freed up."
  '';
}

