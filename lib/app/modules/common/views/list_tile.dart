import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_initicon/flutter_initicon.dart';import 'package:intl/intl.dart';

class FrappeListTile extends StatelessWidget {
  String title;
  String subtitle;
  String? date;
  String? image;
  String trailingText;
  Color? trailingTextColor;

  FrappeListTile({required this.title, required this. subtitle,required this.trailingText, this.date,this.image, this.trailingTextColor});

  @override
  Widget build(BuildContext context) {
    return ListTile(
            leading: date != null ? RichText(
              textAlign: TextAlign.center,

              text: TextSpan(
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue[600],fontSize: 15),
                text:DateFormat('dd-MMM').format(DateTime.parse(date!)).toString().toUpperCase()
,                children: <TextSpan>[
                  TextSpan(text: '\n'),
                  TextSpan(
                      style:TextStyle(fontWeight: FontWeight.bold, color: Colors.blue[600],fontSize: 15,),
                      text: DateFormat('yyyy').format(DateTime.parse(date!)).toString()),
                ],
              ),
            )
          : image !=null?CircleAvatar(
        backgroundImage: AssetImage("image.png"),
      ):
      Initicon(text: title,borderRadius:BorderRadius.circular(5),)
      ,
      title: Text(title, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue[600]),),
      trailing:  SizedBox(
        width: 150,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
          Chip(
            backgroundColor: Colors.greenAccent,
              label: Text('Test')
          ),
          Text(trailingText, style: TextStyle(fontWeight: FontWeight.bold, color: trailingTextColor??Colors.blue[600]),),
        ],),
      ),
      subtitle: Text(subtitle),
      // tileColor: Colors.grey[100],
    );
  }
}
