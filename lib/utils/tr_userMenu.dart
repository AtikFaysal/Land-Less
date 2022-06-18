import 'package:drawerbehavior/drawerbehavior.dart';
import 'package:flutter/material.dart';

List<MenuItem> trUserMenu = [
  new MenuItem<int>(
    id: 0,
    title: 'ড্যাশবোর্ড',
    icon: Icons.dashboard,
  ),
  new MenuItem<int>(
    id: 1,
    title: 'টি.আর প্রকল্প তথ্য দিন',
    icon: Icons.info,
  ),
  new MenuItem<int>(
    id: 2,
    title: 'টি.আর প্রকল্প তালিকা',
    icon: Icons.list,
  ),
  new MenuItem<int>(
    id: 3,
    title: 'রিপোর্ট',
    icon: Icons.assignment,
  ),
  new MenuItem<int>(
    id: 4,
    title: 'আপনার তথ্য পরিবর্তন করুন',
    icon: Icons.person,
  ),
  new MenuItem<int>(
      id: 5,
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
final menu = Menu(
  items: trUserMenu.map((e) => e.copyWith(icon: null)).toList(),
);

final trMenuWithIcon = Menu(
  items: trUserMenu,
);