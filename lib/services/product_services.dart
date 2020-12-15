import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latihan2/models/models.dart';

class ProductServices {
  //setup cloud firestroe
  static CollectionReference productCollection =
      FirebaseFirestore.instance.collection("products");
  static DocumentReference productDoc;

  //setup firestore storage
  static Reference ref;
  static UploadTask uploadTask;

  static String imgUrl;

  static Future<bool> addProduct(Products product, PickedFile imgFile) async {
    await Firebase.initializeApp();

    productDoc = await productCollection.add({
      'id': "",
      'name': product.name,
      'price': product.price,
      'image': "",
    });

    if (productDoc.id != null) {
      ref = FirebaseStorage.instance
          .ref()
          .child("image")
          .child(productDoc.id + ".png");
      uploadTask = ref.putFile(File(imgFile.path));

      await uploadTask.whenComplete(() => ref.getDownloadURL().then(
            (value) => imgUrl = value,
          ));

      productCollection.doc(productDoc.id).update({
        'id': productDoc.id,
        'image': imgUrl,
      });
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> editProduct(name, price, productid) async {
    if (name != "" && price != "" && productid != "") {
      DocumentReference p =
          FirebaseFirestore.instance.collection("products").doc(productid);
      p.update({
        'name': name,
        'price': price,
      });
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> deleteProduct(productid) async {
    if (productid != "") {
      DocumentReference p =
          FirebaseFirestore.instance.collection("products").doc(productid);
      p.delete();
      return true;
    } else {
      return false;
    }
  }
}
