#!/bin/bash
set -euo pipefail

# Creates a build/mappings.yml file
mapping_file="build/mappings.yml"

# These were generated and uploaded in previous steps
linux_amd64_source_image_id=$(buildkite-agent meta-data get "linux_amd64_image_id")
linux_arm64_source_image_id=$(buildkite-agent meta-data get "linux_arm64_image_id")
windows_amd64_source_image_id=$(buildkite-agent meta-data get "windows_amd64_image_id")

# Create the mapping file
mkdir -p "$(dirname "$mapping_file")"
cat << EOF > "$mapping_file"
Mappings:
  AWSRegion2AMI:
    ${AWS_REGION} : { linuxamd64: $linux_amd64_source_image_id, linuxarm64: $linux_arm64_source_image_id, windows: $windows_amd64_source_image_id }
EOF
