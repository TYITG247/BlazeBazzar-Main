import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';

class SellerController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // pickStoreImage(ImageSource source) async {
  //   final ImagePicker _imagePicker = ImagePicker();
  //   XFile? _file = await _imagePicker.pickImage(source: source);
  //   if (_file != null) {
  //     await _file.readAsBytes();
  //   } else {
  //     print("No Image Selected");
  //   }
  // }

  Future<String> registerSeller(
    String businessName,
    String email,
    String phoneNumber,
    String countryValue,
    String stateValue,
    String cityValue,
    String taxRegistered,
    String taxNumber,
  ) async {
    String res = "Something Went Wrong";
    try {
      if (businessName.isNotEmpty &&
          email.isNotEmpty &&
          phoneNumber.isNotEmpty &&
          countryValue.isNotEmpty &&
          stateValue.isNotEmpty &&
          cityValue.isNotEmpty &&
          taxRegistered.isNotEmpty &&
          taxNumber.isNotEmpty) {
        await _firestore.collection('sellers').doc(_auth.currentUser!.uid).set(
          {
            'businessName': businessName,
            'email': email,
            'phoneNumber': phoneNumber,
            'countryValue': countryValue,
            'stateValue': stateValue,
            'cityValue': cityValue,
            'taxRegistered': taxRegistered,
            'taxNumber': taxNumber,
            'approved': false,
            'sellerId': _auth.currentUser!.uid,
          },
        );
      } else {
        res = "Fields Cannot be Empty";
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
