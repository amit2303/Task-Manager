import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/task_model.dart'; 

class FirestoreService {
  final CollectionReference _tasksCollection =
      FirebaseFirestore.instance.collection('task');

  Future<void> addTask(Task task) {
    return _tasksCollection.add(task.toMap());
  }

  Future<void> updateTask(Task task) {
    return _tasksCollection.doc(task.id).update(task.toMap());
  }

  Future<void> deleteTask(String taskId) {
    return _tasksCollection.doc(taskId).delete();
  }

  Stream<List<Task>> getTasks(String loggedInUser) {
    return _tasksCollection.snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => Task.fromMap(doc.id, doc.data() as Map<String,dynamic>))
          .where((task) => task.user == loggedInUser)
          .toList();
    });
  }

  Future<void> toggleTaskCompletion(Task task) {
    return _tasksCollection
        .doc(task.id)
        .update({'isComplete': !task.isComplete});
  }
}
