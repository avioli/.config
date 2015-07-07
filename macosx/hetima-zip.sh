#!/usr/bin/env bash

mkdir ~/Library/QuickLook/

curl -L http://hetima.com/hetimazipql/HetimaZip.qlgenerator1.0.1.zip > /tmp/HetimaZip.zip && \
	unzip -o /tmp/HetimaZip.zip -d /tmp/ && \
	mv /tmp/HetimaZip.qlgenerator*/HetimaZip.qlgenerator ~/Library/QuickLook/ && \
	qlmanage -r && \
	rm -rf /tmp/HetimaZip* || \
	echo "An error occurred."
