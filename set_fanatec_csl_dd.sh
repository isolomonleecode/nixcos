#!/usr/bin/env bash

TUNING_PATH="/sys/module/hid_fanatec/drivers/hid:fanatec/0003:0EB7:0020.0025/ftec_tuning/0003:0EB7:0020.0025"

if [[ ! -d "$TUNING_PATH" ]]; then
  echo "Tuning path not found: $TUNING_PATH"
  exit 1
fi

echo "Setting Fanatec CSL DD parameters at $TUNING_PATH..."

sudo tee "$TUNING_PATH/SEN" <<< 900
sudo tee "$TUNING_PATH/FF"  <<< 55      # Increased force feedback
sudo tee "$TUNING_PATH/NDP" <<< 65      # Increased damper
sudo tee "$TUNING_PATH/NFR" <<< 10      # Added friction
sudo tee "$TUNING_PATH/NIN" <<< 0      # Added inertia
sudo tee "$TUNING_PATH/INT" <<< 5       # Increased interpolation
sudo tee "$TUNING_PATH/FEI" <<< 80
sudo tee "$TUNING_PATH/FOR" <<< 100
sudo tee "$TUNING_PATH/SPR" <<< 0
sudo tee "$TUNING_PATH/DPR" <<< 0
sudo tee "$TUNING_PATH/BLI" <<< 0

echo
echo "Current Fanatec CSL DD settings:"
for param in SEN FF NDP NFR NIN INT FEI FOR SPR DPR BLI; do
  printf "%-4s: " "$param"
  cat "$TUNING_PATH/$param"
done