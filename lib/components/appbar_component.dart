import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';

class AppbarComponent extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const AppbarComponent({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(
      context,
      listen: false,
    );

    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.primary,
      foregroundColor: Theme.of(context).colorScheme.onPrimary,
      title: Text(title),
      actions: [
        IconButton(
          icon: Icon(Icons.palette_outlined),
          onPressed: () {
            themeProvider.toggleTheme();
          },
        ),
        SizedBox(width: 16),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
