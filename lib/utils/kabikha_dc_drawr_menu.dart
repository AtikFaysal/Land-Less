import 'package:drawerbehavior/drawerbehavior.dart';
import 'package:flutter/material.dart';

List<MenuItem> Kabikha_dcMenu = [
  new MenuItem<int>(
    id: 0,
    title: 'ড্যাশবোর্ড',
    icon: Icons.dashboard,
  ),
  new MenuItem<int>(
    id: 1,
    title: 'কাবিখা প্রকল্প তালিকা',
    icon: Icons.list,
  ),
  new MenuItem<int>(
    id: 2,
    title: 'রিপোর্ট',
    icon: Icons.assignment,
  ),
  new MenuItem<int>(
    id: 3,
    title: 'আপনার তথ্য পরিবর্তন করুন',
    icon: Icons.person,
  ),
  new MenuItem<int>(
      id: 4,
      title: 'লগআউট করুন',
      icon: Icons.logout
  ),
/*  new MenuItem<int>(
    id: 5,
    title: 'REPORTS',
    icon: Icons.report,
  ),
  new MenuItem<int>(
    id: 6,
    title: 'DOCUMENTS',
    icon: Icons.assignment,
  ),*/
];
final menuDc = Menu(
  items: Kabikha_dcMenu.map((e) => e.copyWith(icon: null)).toList(),
);

final menuWithIconDcKabikha = Menu(
  items: Kabikha_dcMenu,
);