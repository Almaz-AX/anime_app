// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:io';

import 'package:supabase_flutter/supabase_flutter.dart';
import '../../data/models/profile.dart';

abstract class ProfileRepository {
  Future<Profile?> getProfile();
  Future<String> uploadAvatar(File file, Profile profile);
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
  Future<String> uploadAvatar(File file, Profile profile) async {
    DateTime.timestamp().toString();
    final path =
        '/${profile.userName}/${DateTime.timestamp().toIso8601String().toString()}';
    await supabase.client.storage.from('avatars').upload(path, file,
        fileOptions: const FileOptions(contentType: 'image/jpeg'));
    String url = supabase.client.storage.from('avatars').getPublicUrl(path);
    await supabase.client
        .from(Profile.tableName)
        .update({'avatar_url': url}).eq('id', profile.id);
    return url;
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
