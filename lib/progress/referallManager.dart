import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nantap/progress/state.dart';

class ReferralManager {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Generates and stores the referral code for the user
  Future<String> generateReferralCode(GlobalState state) async {
    String referralCode = state.level.toString() + DateTime.now().millisecondsSinceEpoch.toString().substring(8);

    // Save the referral code in Firestore
    await _firestore.collection('users').doc(state.level.toString()).set(
      {
        'referralCode': referralCode,
        'invitedFriends': [],
      },
      SetOptions(merge: true),
    );
    return referralCode;
  }

  /// Validates and processes the referral code entered by the user
  Future<void> processReferralCode(String referralCode, GlobalState state) async {
    final referralData = await _firestore.collection('users').where('referralCode', isEqualTo: referralCode).get();

    if (referralData.docs.isEmpty) {
      throw Exception('Invalid referral code.');
    }

    String referrerId = referralData.docs.first.id;

    // Update the referred user's state in Firestore
    await _firestore.collection('users').doc(state.level.toString()).set(
      {'referredBy': referrerId},
      SetOptions(merge: true),
    );

    // Update the referrer's invited friends
    await _firestore.collection('users').doc(referrerId).update({
      'invitedFriends': FieldValue.arrayUnion([state.level.toString()]),
    });
  }

  /// Retrieves the list of invited friends for the current user
  Future<List<String>> getInvitedFriends(GlobalState state) async {
    final userDoc = await _firestore.collection('users').doc(state.level.toString()).get();
    return List<String>.from(userDoc.data()?['invitedFriends'] ?? []);
  }
}
