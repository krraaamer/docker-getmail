#!/bin/sh

echo TZ="$TZ"
echo SLEEP_TIME="$SLEEP_TIME"

while [ true ]; do

  for f in /mail/*/; do
    mkdir -p "$f"/maildir/new
    mkdir -p "$f"/maildir/cur
    mkdir -p "$f"/maildir/tmp
  done

  mkdir -p /config/data

  for f in /config/*.getmail; do
    [ -f "$f" ] || break
    getmail --verbose --getmaildir="/config/data" --rcfile="$f"
  done

  sleep "${SLEEP_TIME}s"

done
