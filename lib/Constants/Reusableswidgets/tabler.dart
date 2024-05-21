import 'package:flutter/material.dart';

import '../Theme.dart';

Widget _buildStaticHeader(List headers) {
  return Container(
    color: Colors.grey[300],
    padding: EdgeInsets.symmetric(vertical: 8,horizontal: 10),
    child: Row(
      children: List.generate(headers.length, (index) => Expanded(child: Text('${headers[index]}',style: boldfont,))),
    ),
  );
}