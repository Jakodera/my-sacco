import 'package:flutter/material.dart';

class SideMenuItem {
    final String title;
    final String destination;
    final IconData associatedIcon;
    final bool hasDivider;

    SideMenuItem(this.title, this.destination, this.associatedIcon, this.hasDivider);
}

final List<SideMenuItem> sideMenus = <SideMenuItem>[
    SideMenuItem(
        "home",
        "/Home",
        Icons.home,
        false,
    ),
    SideMenuItem(
        "Transact",
        "/Transact",
        Icons.compare_arrows,
        false,
    ),
    SideMenuItem(
        "My Account",
        "/MyAccount",
        Icons.person,
        false,
    ),
    SideMenuItem(
        "Loans",
        "/Loans",
        Icons.attach_money,
        false,
    ),
    SideMenuItem(
        "Other Services",
        "/OtherServices",
        Icons.line_style,
        true,
    ),
    SideMenuItem(
        "Settings",
        "/Settings",
        Icons.settings,
        false,
    ),
    SideMenuItem(
        "Contacts",
        "/Contacts",
        Icons.call,
        false,
    ),
    SideMenuItem(
        "Logout",
        "/Logout",
        Icons.exit_to_app,
        false,
    )
];
