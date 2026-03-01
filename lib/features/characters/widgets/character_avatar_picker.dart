import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

class CharacterAvatarPicker extends StatelessWidget {
  final VoidCallback onTap;
  final String? imageUrl;

  const CharacterAvatarPicker({super.key, required this.onTap, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          // Main Avatar Circle
          Container(
            height: 120,
            width: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withValues(alpha: 0.05),
              border: Border.all(
                color: AppColors.royalPurple.withValues(alpha: 0.5),
                width: 2,
              ),
              image: imageUrl != null
                  ? DecorationImage(
                      image: NetworkImage(imageUrl!),
                      fit: BoxFit.cover,
                    )
                  : null,
            ),
            child: imageUrl == null
                ? const Icon(
                    Icons.person_outline,
                    size: 60,
                    color: Colors.white54,
                  )
                : null,
          ),
          // Edit Icon
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.royalPurple,
              border: Border.all(color: AppColors.midnightBlue, width: 2),
            ),
            child: const Icon(Icons.edit, size: 16, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
