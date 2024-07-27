// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:io';

import 'package:supabase_flutter/supabase_flutter.dart';
import '../../data/models/profile.dart';

abstract class ProfileRepository {
  Future<Profile?>getProfile();
  uploadAvatar(File file);
  changeProfileName(String newName);
}

class ProfileRepositiryImpl implements ProfileRepository {
  final Supabase supabase;
  ProfileRepositiryImpl({
    required this.supabase,
  });
  @override
  Future<void> changeProfileName(String newName) async {
    final currentUser = supabase.client.auth.currentUser;
    if (currentUser == null) {
      return;
    }
    await supabase.client
        .from(Profile.tableName)
        .update({'user_name': newName}).eq('id', currentUser.id);
  }

  @override
  Future<void> uploadAvatar(File file) async {
    throw UnimplementedError();
  }

  @override
  Future<Profile?> getProfile() async {
    final currentUser = supabase.client.auth.currentUser;
    if (currentUser == null) {
      return null;
    }
    final data = (await supabase.client
            .from(Profile.tableName)
            .select()
            .eq('id', currentUser.id))
        .first;
    return Profile.fromJson(data);
  }
}
