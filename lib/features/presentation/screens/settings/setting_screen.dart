import 'package:flutter/material.dart';
import 'package:todo_project/core/shared_widgets/custom_text.dart';
import 'package:todo_project/core/theme/app_colors.dart';

class SettingsPage extends StatelessWidget {
  // ✅ StatelessWidget مش محتاجة state
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgDark,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: IconButton(
            onPressed: () => Navigator.of(context).maybePop(),
            icon: const Icon(Icons.arrow_back, color: AppColors.textLight),
          ),
        ),
        title: const CustomText(text: 'Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          children: [
            const SizedBox(height: 20),
            _buildSettingsItem(
              context,
              icon: Icons.person_outline,
              label: 'Profile',
              onTap: () {},
            ),
            _buildDivider(),
            _buildSettingsItem(
              context,
              icon: Icons.chat_bubble_outline,
              label: 'Conversations',
              onTap: () {},
            ),
            _buildDivider(),
            _buildSettingsItem(
              context,
              icon: Icons.settings_outlined,
              label: 'Projects',
              onTap: () {},
            ),
            _buildDivider(),
            _buildSettingsItem(
              context,
              icon: null,
              label: 'Terms and Policies',
              onTap: () {},
            ),
            const Spacer(),
            _buildLogoutButton(context),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsItem(
    BuildContext context, {
    required IconData? icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 4),
        child: Row(
          children: [
            if (icon != null) ...[
              Icon(icon, color: AppColors.textLight, size: 22),
              const SizedBox(width: 16),
            ] else
              const SizedBox(width: 38),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  color: AppColors.textLight,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const Icon(
              Icons.chevron_right,
              color: AppColors.textMuted,
              size: 22,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() =>
      const Divider(color: AppColors.bgCardLight, thickness: 0.5, height: 1);

  Widget _buildLogoutButton(BuildContext context) {
    return GestureDetector(
      onTap: () => _confirmLogout(context),
      child: Container(
        width: 220,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: AppColors.bgCard,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.accentRed.withOpacity(0.15),
              ),
              child: const Icon(
                Icons.logout,
                color: AppColors.accentRed,
                size: 17,
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              'Logout',
              style: TextStyle(
                color: AppColors.textLight,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _confirmLogout(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: AppColors.bgCard,
        title: const Text(
          'Logout',
          style: TextStyle(color: AppColors.textWhite),
        ),
        content: const Text(
          'Are you sure you want to logout?',
          style: TextStyle(color: AppColors.textLight),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(
              'Cancel',
              style: TextStyle(color: AppColors.textMuted),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(
              'Logout',
              style: TextStyle(color: AppColors.accentRed),
            ),
          ),
        ],
      ),
    );
  }
}
