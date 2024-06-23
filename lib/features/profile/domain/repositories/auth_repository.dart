// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthRepository {
  static const redirect = 'io.supabase.flutteranimeapp://login-callback';
  Future<bool> isAuth();
  Future<bool> signIn();
  Future<void> signOut();
  Future<Session?> getSession();
}

class AuthRepositoryImpl implements AuthRepository {
  final StreamController<bool> controller = StreamController<bool>.broadcast();
  final Supabase supabase;
  final FlutterSecureStorage secureStorage;
  StreamSubscription<AuthState>? subscription;
  AuthRepositoryImpl({required this.supabase, required this.secureStorage}) {
    _listenSupabase();
    final session = supabase.client.auth.currentSession?.toString();
    print(session);
  }

  @override
  Future<bool> isAuth() async => supabase.client.auth.currentSession != null;

  @override
  Future<bool> signIn() async {
    final rez = await supabase.client.auth.signInWithOAuth(OAuthProvider.google,
        redirectTo: AuthRepository.redirect);
    final token = supabase.client.auth.currentSession?.toString();
    print(token);
    await secureStorage.write(key: 'session', value: token);
    return rez;
  }

  @override
  Future<void> signOut() {
    return supabase.client.auth.signOut();
  }

  Future<void> close() async {
    await subscription?.cancel();
  }

  void _listenSupabase() {
    subscription =
        supabase.client.auth.onAuthStateChange.listen((AuthState authState) {
      final event = authState.event;
      print(event);
      if (event == AuthChangeEvent.signedIn) {
        controller.sink.add(true);
      } else {
        controller.sink.add(false);
      }
    });
  }

  @override
  Future<Session?> getSession() async {
    return supabase.client.auth.currentSession;
  }
}
