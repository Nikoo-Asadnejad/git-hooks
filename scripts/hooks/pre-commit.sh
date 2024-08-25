#!/bin/bash

AUTHORIZED_USERS="n.asadnejad@partocrs.com,it@partocrs.com,it3@partocrs.com"

IFS=',' read -r -a AUTHORIZED_USERS_ARRAY <<< "$AUTHORIZED_USERS"

CURRENT_USER=$(git config user.email)

PROTECTED_FILES="appsettings.json appsettings.demo.json"

is_authorized_user() {
    for user in "${AUTHORIZED_USERS_ARRAY[@]}"; do
        if [ "$CURRENT_USER" == "$user" ]; then
            return 0
        fi
    done
    return 1
}

if ! is_authorized_user; then
    for file in $PROTECTED_FILES; do
        if git diff --cached --name-only | grep -q "$file"; then
            echo "Error: You are not authorized to modify $file."
            exit 1
        fi
    done
fi

exit 0
