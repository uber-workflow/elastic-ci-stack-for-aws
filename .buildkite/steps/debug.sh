#!/bin/bash

# build the secrets binary
docker run -i --rm \
  -v "$PWD/build:/build:rw" \
  -v "$PWD/plugins/secrets/s3secrets-helper:/s3secrets-helper:ro" \
  -w '/s3secrets-helper' \
  -e 'GOOS=linux' \
  -e 'GOARCH=amd64' \
  golang:1.15 go build -o "/build/s3secrets-helper-linux-amd64"

# download packer
wget https://releases.hashicorp.com/packer/1.7.0/packer_1.7.0_linux_amd64.zip -O temp.zip
mkdir bin
unzip -d bin temp.zip
rm temp.zip
chmod +x bin/packer
cd packer/linux || exit
sleep 1000000

# TODO: SSH into machine, and run a debug packer build:
# ../../bin/packer build -debug -timestamp-ui -var 'region=us-west-1' -var 'arch=x86_64' -var 'goarch=amd64' -var 'instance_type=c5.xlarge' buildkite-ami.json | tee ../../packer-linux-amd64.output
