import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.all(16.0),
            child: const Icon(
              Icons.account_circle,
              size: 50,
            ),
          ),
          ListTile(
            title: const Text('Notes'),
            leading: const Icon(Icons.note_add),
            onTap: () {},
          ),
          ListTile(
            title: const Text('Reminders'),
            leading: const Icon(Icons.notifications_active_outlined),
            onTap: () {},
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text('Lables'),
              ),
              TextButton(onPressed: () {}, child: Text('Edit'))
            ],
          ),
          ListView(
            shrinkWrap: true,
            children: [
              ListTile(
                title: const Text('Personal'),
                leading: const Icon(Icons.label_outlined),
                onTap: () {},
              ),
              ListTile(
                title: const Text('Work'),
                leading: const Icon(Icons.label_outlined),
                onTap: () {},
              ),
              ListTile(
                title: const Text('Home'),
                leading: const Icon(Icons.label_outlined),
                onTap: () {},
              ),
            ],
          ),
          ListTile(
            title: const Text('Create New Label'),
            leading: const Icon(Icons.add_outlined),
            onTap: () {},
          ),
          Divider(),
          ListTile(
            title: const Text('Archive'),
            leading: const Icon(Icons.archive_outlined),
            onTap: () {},
          ),
          ListTile(
            title: const Text('Deleted'),
            leading: const Icon(Icons.delete_outlined),
            onTap: () {},
          ),
          ListTile(
            title: const Text('Settings'),
            leading: const Icon(Icons.settings_outlined),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
