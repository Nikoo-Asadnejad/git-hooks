#!/bin/bash

#Install the commit-msg hook
cp commit-msg.sh ../../.git/hooks/commit-msg
chmod +x ../../.git/hooks/commit-msg

echo "Git hooks installed."