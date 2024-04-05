
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:web3/Screens/crm/crm_menus.dart';
import '../homeScreen.dart';
import 'Leads/Leads.dart';
import 'Projects/Projects.dart';
import 'customers/customers.dart';

late final myMenus = [
  Crmenus(
    title: 'Dashboard',
    widget: Leads(),
    icona: Icon(Icons.pix_rounded),
  ),
  Crmenus(
    title: 'Customers',
    widget: Customers(),
    icona: Icon(Icons.people),
  ),
  Crmenus(
      title: 'Projects',
      widget: Projects(),
      icona: Icon(Icons.propane_outlined),
  ),
  Crmenus(
      title: 'Leads',
      widget: Leads(),
      icona: Icon(Icons.important_devices),
  ),
  Crmenus(
      title: 'Sales',
      widget: homeScreen(),
      icona: Icon(Icons.margin),
  ),
  Crmenus(
      title: 'Schedules & Reminders',
      widget: homeScreen(),
      icona: Icon(Icons.calendar_month),
  ),
  Crmenus(
      title: 'Communication History',
      widget: homeScreen(),
      icona: Icon(Icons.message),
  ),
  Crmenus(
      title: 'Reports',
      widget: homeScreen(),
      icona: Icon(Icons.pause_presentation_sharp),
  ),
  Crmenus(
      title: 'Settings',
      widget: homeScreen(),
      icona: Icon(Icons.settings),
  ),

  // CrmMenuList()
];