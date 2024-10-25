import 'package:flutter/material.dart';

import '../../../../../core/constants/colors.dart';
import '../constants/sizes.dart';

class AppListTile extends StatelessWidget {
  const AppListTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.date,
    this.onTap,
  });

  final String title;
  final String subtitle;
  final String date;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(
        vertical: AppSizes.sm,
        horizontal: AppSizes.md,
      ),
      title: _buildTitle(context),
      subtitle: _buildSubtitle(context),
      trailing: _buildTrailingDate(context),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSizes.sm),
      child: Text(
        title,
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: AppColors.black,
              fontWeight: FontWeight.w400,
            ),
      ),
    );
  }

  Widget _buildSubtitle(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.shopping_bag_outlined,
          color: AppColors.black,
          size: AppSizes.iconSm,
        ),
        AppSizes.horizontalSpace(AppSizes.sm),
        Text(
          subtitle,
          style: Theme.of(context).textTheme.labelLarge!.copyWith(
                color: AppColors.black,
                fontWeight: FontWeight.w400,
              ),
        ),
      ],
    );
  }

  Widget _buildTrailingDate(BuildContext context) {
    return Text(
      date,
      style: Theme.of(context).textTheme.labelLarge!.copyWith(
            color: AppColors.black,
            fontWeight: FontWeight.w400,
          ),
    );
  }
}
