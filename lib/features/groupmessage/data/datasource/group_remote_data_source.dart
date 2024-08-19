import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:talkathon/features/groupmessage/domain/gropu_entites.dart';

class GroupRemoteDataSource {
  final FirebaseFirestore firestore;

  GroupRemoteDataSource(this.firestore);

  Future<void> createGroup(Group group) async {
    await firestore.collection('groups').doc(group.id).set(group.toMap());
  }
  Future<List<Group>> fetchGroups() async {
    final snapshot = await firestore.collection('groups').get();
    return snapshot.docs.map((doc) => Group.fromMap(doc.data())).toList();
  }
  
}
