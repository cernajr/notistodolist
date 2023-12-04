import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

Future<List> listTareas() async {
  List tareas = [];
  CollectionReference tareasCollection = db.collection('tasks');
  QuerySnapshot taskQuery = await tareasCollection.get();
  for (var document in taskQuery.docs) {
    tareas.add(document.data());
  }
  return tareas;
}

Future<void> guardarTarea(String titulo, bool estado) async {
  await db.collection("tareas").add({"titulo": titulo, "estado": estado});
}

Future<void> eliminarTarea(String id) async {
  await db.collection("tareas").doc(id).delete();
}

Future<void> actualizarTarea(String id, String titulo, bool estado) async {
  try {
    await db.collection("tareas").doc(id).update({"titulo": titulo, "estado": estado});
  } catch (e) {
    print('Error al actualizar la tarea: $e');
  }
}