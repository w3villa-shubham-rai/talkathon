
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talkathon/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:talkathon/features/chat/presentation/bloc/chat_event.dart';
import 'package:talkathon/utils/component/extension_of_size.dart';
import 'package:talkathon/utils/padding_marging.dart';

class ChatListingPage extends StatefulWidget {
  const ChatListingPage({super.key});
  @override
  State<ChatListingPage> createState() => _ChatListingPageState();
}

class _ChatListingPageState extends State<ChatListingPage> {
  late ChatBloc chatBloc;
  @override
  void initState() {
    super.initState();
     chatBloc = BlocProvider.of<ChatBloc>(context);
    chatBloc.add(UserListingEvent());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: const Color(0xFFF2F2F2))
                ),
                child: TextFormField(
                  maxLines: null,
                  decoration: const InputDecoration(
                    isDense: true,
                    fillColor: Color(0xffFFFFFF),
                    hintText: "Search employe name",
                    hintStyle: TextStyle(color: Color(0xFFB7B7B7)),
                    prefixIcon: Icon(Icons.search,size: 30,),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                  ),
                ),
              ).paddingSymmetric(vertical: 10),
              ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                return  Row(
                children: [
                    Flexible(
                      flex: 2,
                      child: Container(
                        height: 55,
                        width: 55,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: ClipOval(
                              child: Image.network("https://images.unsplash.com/photo-1716968921500-6bce26915c37?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw3fHx8ZW58MHx8fHx8", fit: BoxFit.cover,
                              ),
                         ),
                      ),
                    ),
                    15.bw,
                    Expanded(
                    flex: 8,
                     child: Column(
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 9,
                              child: Text("Shubham Rai",style: TextStyle(color: Color(0xFF363636),fontSize: 16,fontWeight: FontWeight.bold),)),
                    
                            Expanded(
                              flex: 2,
                              child: Text("10:19",style: TextStyle(color: Color(0xFF40518A),fontSize: 12,fontWeight: FontWeight.w300),)),
                           ],
                        ),
                        Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Expanded(
                              flex: 9,
                              child: Text("Hello, Shubham Have you shared",style: TextStyle(color: Color(0xFFB7B7B7),fontSize: 13,fontWeight: FontWeight.w300),)),
                            Container(
                              height: 17,
                              width: 17,
                              decoration: const BoxDecoration(shape: BoxShape.circle,color: Color(0xFF2E58E6)),
                              child: const Center(child: Text("3",style: TextStyle(color: Color(0xFFFFFFFF),fontSize: 12,fontWeight: FontWeight.bold),)),
                            )
                           ],
                        ),
                      ],
                     ),
                   ) 
                ],
              ).paddingSymmetric(vertical:5);
            
              }, 
              separatorBuilder: (context, index) =>  const Divider(
                color: Color(0xFFE0E0E0),
              ),
              itemCount: 20)
             ],
          ).paddingSymmetric(horizontal: 33,vertical: 10),
        ),
      ),
    );
  }
}
