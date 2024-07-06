import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:talkathon/utils/padding_marging.dart';

class UserChatRoom extends StatefulWidget {
  const UserChatRoom({super.key});

  @override
  State<UserChatRoom> createState() => _UserChatRoomState();
}

class _UserChatRoomState extends State<UserChatRoom> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,color: Colors.red,),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Row(
          children: [
            ClipOval(
              child: Image.network(
                'https://media.istockphoto.com/id/1337144146/vector/default-avatar-profile-icon-vector.jpg?s=612x612&w=0&k=20&c=BIbFwuv7FxTWvh5S3vB6bkT0Qv8Vn8N5Ffseq84ClGI=', // Placeholder for profile image
                width: 40,
                height: 40,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(Icons.person, size: 40);
                },
              ),
            ),
            SizedBox(width: 10),
            Text('Username'), // Placeholder for username
          ],
        ),
      ),
      backgroundColor: const Color(0xFFF8F8F8),
      body: Container(
        child:  Column(
          children:[
           Expanded(child: Container()),
            Container(
              decoration: const BoxDecoration(
                color: Color(0xffFFFFFF),
                borderRadius: BorderRadius.all(Radius.circular(27)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                 Flexible(
                   child: TextFormField(
                     maxLines: null,
                     decoration: const InputDecoration(
                       border: InputBorder.none,
                       hintText: "Start Message",
                       contentPadding:EdgeInsets.only(left: 10),
                       hintStyle: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),
                     ),
                   ).paddingOnly(bottom: 4),
                 ),
                  Container(
                    height: 40,
                    width: 40,
                    clipBehavior: Clip.antiAlias,
                   decoration: const BoxDecoration(
                     shape: BoxShape.circle,
                     color: Color(0xFF40518A),
                   ),
                    child: const Icon(Icons.send,color: Color(0xFFFFFFFF),),
                  ).paddingSymmetric(horizontal: 10,vertical: 10)
                ],
              ),
            )

        ],),
      ).paddingSymmetric(horizontal: 30,vertical: 30),
    );
  }
}
