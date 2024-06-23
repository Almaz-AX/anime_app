// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:supabase_flutter/supabase_flutter.dart';

abstract class ProfileRepository {
  uploadAvatar();
  changeProfileName();
}

class ProfileRepositiryImpl implements ProfileRepository {
  final Supabase supabase;
  ProfileRepositiryImpl({
    required this.supabase,
  });
  @override
  changeProfileName() {
    // TODO: implement update
    throw UnimplementedError();
  }

  @override
  uploadAvatar() {
    // TODO: implement uploadAvatar
    throw UnimplementedError();
  }

}
