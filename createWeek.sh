#!/usr/bin/env bash

week="$1"

if [ -z "$week" ]; then
	echo "Usage: ./createWeek.sh <weekN:int>"
	exit 1
fi
SCRIPT_DIR=$(dirname -- "${BASH_SOURCE[0]}")
weekN="week$week"

cp -r "$SCRIPT_DIR/template" "$SCRIPT_DIR/$weekN"
mv "$SCRIPT_DIR/$weekN/src/main/java/hello" "$SCRIPT_DIR/$weekN/src/main/java/$weekN"

# update the build target name to match the directory, making bazel build <dir> easy
sed --in-place='' "s/template/$weekN/" "$SCRIPT_DIR/$weekN/BUILD"

# match the java package to the directory for clearer separation
sed --in-place='' "s/hello/$weekN/" "$SCRIPT_DIR/$weekN/BUILD"
sed --in-place='' "s/hello/$weekN/" "$SCRIPT_DIR/$weekN"/src/main/java/**/*.java