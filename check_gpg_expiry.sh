#!/bin/sh

#check if a gpg key will expire soon
GPG='/usr/bin/gpg'
SECRET_KEYS=$($GPG --with-colons --fixed-list-mode --list-secret-keys | grep '^sec' | cut -d':' -f 5)
NEXT_WEEK=$(echo "$(date +%s) + 604800" | bc)

for KEY in $SECRET_KEYS; do
  for SUBKEY in $($GPG --with-colons --fixed-list-mode --list-keys $KEY | grep -e '^pub' -e '^sub');  do
    EXPIRY_DATE=$(echo $SUBKEY | cut -d':' -f 7)
    if [ -n "$EXPIRY_DATE" ]; then
      if [ "$EXPIRY_DATE" -gt "$(date +%s)" ] && [ "$EXPIRY_DATE" -le "$NEXT_WEEK" ]; then
        TO_EXPIRE_SOON="$TO_EXPIRE_SOON $(echo $SUBKEY | cut -d':' -f 5)"
      fi
    fi
  done
done

if [ -n "$TO_EXPIRE_SOON" ]; then
  echo "GPG keys that will expire soon: $TO_EXPIRE_SOON"
  exit 1
fi
