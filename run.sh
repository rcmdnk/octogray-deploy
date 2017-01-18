#!/bin/bash

export RUBYOPT=-EUTF-8

mkdir -p "$HOME/.ssh"
echo "$GITHUB_DEPLOY_KEY_PRIVATE" > "$HOME/.ssh/id_rsa"
chmod 400 "$HOME/.ssh/id_rsa"

bundle install

sed -i"" "s/^tmp_dir.*/tmp_dir = \".\/\"/" Rakefile
sed -i"" "s/^destination:.*/destination: .\/public/" _config.yml
rake integrate
rake generate["no_minify"] --trace
#rake minify_html
