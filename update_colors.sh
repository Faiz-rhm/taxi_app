#!/bin/bash

# Files to update (excluding already updated ones and app_colors.dart itself)
files=(
  "lib/src/featured/booking/bookings_screen.dart"
  "lib/src/featured/wallet/wallet_screen.dart"
  "lib/src/featured/wallet/add_money_screen.dart"
  "lib/src/featured/message/message_screen.dart"
  "lib/src/featured/profile/profile_screen.dart"
  "lib/src/featured/profile/complete_profile_screen.dart"
  "lib/src/featured/profile/your_profile_screen.dart"
  "lib/src/featured/profile/add_address_screen.dart"
  "lib/src/featured/profile/manage_address_screen.dart"
)

for file in "${files[@]}"; do
  if [ -f "$file" ]; then
    echo "Updating $file"
    
    # Add AppColors import if it doesn't exist
    if ! grep -q "import.*app_colors.dart" "$file"; then
      # Find the line after the last import and insert the AppColors import
      sed -i "/^import /a import '../../helper/constants/app_colors.dart';" "$file" 2>/dev/null || true
    fi
    
    # Replace common hardcoded colors
    sed -i 's/Color(0xFF242424)/AppColors.primaryText/g' "$file" 2>/dev/null || true
    sed -i 's/Color(0xFFF2994A)/AppColors.primary/g' "$file" 2>/dev/null || true
    sed -i 's/Color(0xFF9E9E9E)/AppColors.hintText/g' "$file" 2>/dev/null || true
    sed -i 's/Color(0xFFE0E0E0)/AppColors.borderLight/g' "$file" 2>/dev/null || true
    sed -i 's/Colors\.white/AppColors.surface/g' "$file" 2>/dev/null || true
    sed -i 's/Colors\.black/AppColors.primaryText/g' "$file" 2>/dev/null || true
    sed -i 's/Color(0xFFE53935)/AppColors.error/g' "$file" 2>/dev/null || true
    sed -i 's/Color(0xFF4CAF50)/AppColors.success/g' "$file" 2>/dev/null || true
  fi
done

echo "Color updates completed"
