#!/bin/bash

SCRIPT_DIR="$(dirname "$(realpath "$0")")"

LIB_DIR="$SCRIPT_DIR/kicad"
IMG_DIR="$SCRIPT_DIR/img"

mkdir -p "$IMG_DIR"

echo "Libraries: $LIB_DIR"
echo "Images: $IMG_DIR"
echo ""

# Function to convert KiCad symbol libraries (.kicad_sym) to SVG
convert_symbols_to_svg() {
    local input_file="$1"
    local output_dir="$2"
    kicad-cli sym export svg -o "$output_dir" "$input_file"
}

# Function to convert KiCad footprint libraries (.pretty) to SVG
convert_footprints_to_svg() {
    local input_file="$1"
    local output_dir="$2"
    kicad-cli fp export svg -o "$output_dir" "$input_file"
}

# Iterate through all symbols
echo "===== Symbols ====="
for sym_lib in "$LIB_DIR"/*.kicad_sym; do
    if [[ -f "$sym_lib" ]]; then
        convert_symbols_to_svg "$sym_lib" "$IMG_DIR"
    fi
done

echo ""

# Iterate through all footprints
echo "===== Footprints ====="
for fp_lib in "$LIB_DIR"/*.pretty; do
    convert_footprints_to_svg "$fp_lib" "$IMG_DIR"
done

echo ""
echo "SVG export complete!"
