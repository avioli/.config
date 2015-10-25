#!/bin/bash

###
### Label done torrents with a tag
###

TMPDIR=${TMPDIR:-/tmp/}

### Available variables:
### $TR_APP_VERSION
### $TR_TIME_LOCALTIME
### $TR_TORRENT_DIR
### $TR_TORRENT_HASH
### $TR_TORRENT_ID
### $TR_TORRENT_NAME
# Debug data
# echo "[$TR_APP_VERSION:$TR_TIME_LOCALTIME] $TR_TORRENT_ID/$TR_TORRENT_HASH $TR_TORRENT_NAME -- $TR_TORRENT_DIR" >> $TMPDIR/transmission.log

logerror () {
	# logs to /Applications/Utilities/Console.app
	syslog -s -k Facility com.apple.console Level Error Sender `basename $0` Message "$1"
}

# Check if tag is installed (in path)
if hash tag 2>/dev/null; then
	TAGEXEC=tag
elif [ -x /usr/local/bin/tag ]; then
	TAGEXEC=/usr/local/bin/tag
elif [ -x /usr/bin/tag ]; then
	TAGEXEC=/usr/bin/tag
else
	logerror "Utility not found: tag (in PATH, /usr/local/bin, or /usr/bin)"
	exit 1
fi

# Set default tag & log name
[ -z "$TR_TAG_DONE" ] && TR_TAG_DONE="TransmissionDone"

# Set rotate logs vars
# [ -z "$TR_LOG_PATH" ] && TR_LOG_PATH="$TMPDIR"
# [ -z "$TR_LOG_FILE" ] && TR_LOG_FILE="$TR_LOG_PATH/transmission.log"
# [ -z "$TR_LOG_ROT_SIZE" ] && TR_LOG_ROT_SIZE=400

# Tag the torrent file or dir
$TAGEXEC -a "$TR_TAG_DONE" "$TR_TORRENT_DIR/$TR_TORRENT_NAME" || { logerror "[$TR_APP_VERSION] $TR_TORRENT_ID/$TR_TORRENT_HASH $TR_TORRENT_NAME -- $TR_TORRENT_DIR"; exit 1; }

# Rotate logs if larger than $TR_LOG_ROT_SIZE
# LOG_SIZE=`stat -f "%z" "$TR_LOG_FILE"`
# if [ "$LOG_SIZE" -ge "$TR_LOG_ROT_SIZE" ]; then
# 	NEW_LOG_FILE=$TR_LOG_FILE.`date +%Y%m%d%H%M`
# 	cp $TR_LOG_FILE $NEW_LOG_FILE
# 	cat /dev/null > $TR_LOG_FILE
# 	hash gzip 2>/dev/null && gzip -f -9 $NEW_LOG_FILE
# fi
