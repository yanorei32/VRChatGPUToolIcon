#!/bin/bash

set -ex;

ICON_SIZES=(16 24 32 48 256)

for svg in *.svg; do
	svg_name="${svg%.*}"
	for size in "${ICON_SIZES[@]}"; do
		png_path="${svg_name}_${size}.png"

		inkscape --export-type=png \
			-w "$size" -h "$size" "$svg" -o "$png_path"
	done

	pngs=$(
		for size in "${ICON_SIZES[@]}"; do
			echo "${svg_name}_${size}.png "
		done
	)

	# shellcheck disable=SC2086
	convert $pngs "${svg_name}.ico"

	# shellcheck disable=SC2086
	rm $pngs
done
