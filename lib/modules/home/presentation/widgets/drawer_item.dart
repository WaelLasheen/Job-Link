import 'package:flutter/material.dart';
import 'package:job_link/modules/home/data/model/drawer_item_model.dart';

class DrawerItem extends StatelessWidget {
  final DrawerItemModel item;
  const DrawerItem({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: item.onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          children: [
            Icon(
              item.icon,
              color: item.color,
            ),
            const SizedBox(width: 16),
            Text(
              item.title,
              style: TextStyle(
                color: item.color,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
