import 'package:d_liv/shared/constants/theme/colors.dart';
import 'package:d_liv/widgets/forms/custom_text_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/repositories/auth/auth_repository.dart';
import '../../widgets/forms/custom_text_field.dart';
import '../../widgets/forms/custom_button.dart';

class SettingsScreen extends StatefulWidget {

  const SettingsScreen({super.key});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isDark = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Paramètres"),
      ),
      body: Center(
        child: Container(
          color: Colors.white,
          child: ListView(
            children: [
              _SingleSection(
                title: "Général",
                children: [
                  _CustomListTile(
                      title: "Dark Mode",
                      icon: Icons.dark_mode_outlined,
                      trailing: Switch(
                          value: _isDark,
                          activeColor: DLivColors.primary,
                          inactiveThumbColor: DLivColors.secondary,
                          onChanged: (value) {
                            setState(() {
                              _isDark = value;
                            });
                          })),
                ],
              ),
              Divider(thickness: 13, color: Colors.grey[200],),
              _SingleSection(
                title: "Notifications",
                children: [
                  _CustomListTile(
                      title: "Livraison entrante",
                      icon: Icons.arrow_circle_down,
                      trailing: Switch(
                          value: true,
                          activeColor: DLivColors.primary,
                          inactiveThumbColor: DLivColors.secondary,
                          onChanged: (value) {}
                      )
                  ),
                  _CustomListTile(
                      title: "Etat de la livraison",
                      icon: Icons.delivery_dining,
                      trailing: Switch(
                          value: true,
                          activeColor: DLivColors.primary,
                          inactiveThumbColor: DLivColors.secondary,
                          onChanged: (value) {}
                      )
                  ),
                ],
              ),
              Divider(thickness: 13, color: Colors.grey[200],),
              _SingleSection(
                children: [
                  _CustomListTile(
                      title: "Aide et assistance",
                      icon: Icons.help_outline_rounded,
                      onTap: () {
                        Navigator.of(context).pushNamed('/profile/assistance');
                      }
                  ),
                  _CustomListTile(
                      title: "Invite un ami",
                      icon: Icons.person_add_alt
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CustomListTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget? trailing;
  final Function()? onTap;
  const _CustomListTile(
      {Key? key, required this.title, required this.icon, this.trailing, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: Icon(icon),
      trailing: trailing,
      onTap: onTap,
    );
  }
}

class _SingleSection extends StatelessWidget {
  final String? title;
  final List<Widget> children;
  const _SingleSection({
    Key? key,
    this.title,
    required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title!,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        Column(
          children: children,
        ),
      ],
    );
  }
}