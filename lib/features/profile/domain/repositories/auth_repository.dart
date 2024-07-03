// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';


import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthRepository {
  static const redirect = 'io.supabase.flutteranimeapp://login-callback';
  Stream<bool> isAuth();
  Future<bool> signIn();
  Future<void> signOut();
  Future<Session?> getSession();
}

class AuthRepositoryImpl implements AuthRepository {
  final StreamController<bool> controller = StreamController<bool>.broadcast();
  final Supabase supabase;
  // final FlutterSecureStorage secureStorage;
  StreamSubscription<AuthState>? subscription;
  AuthRepositoryImpl({required this.supabase}) {
    _listenSupabase();
    final session = supabase.client.auth.currentSession?.toString();
    print(session);
  }

  @override
  Stream<bool> isAuth() => controller.stream;

  @override
  Future<bool> signIn() async {
    final rez = await supabase.client.auth.signInWithOAuth(OAuthProvider.google,
        redirectTo: AuthRepository.redirect);
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
      if (event == AuthChangeEvent.initialSession) {
        final session = supabase.client.auth.currentSession;
        session != null? controller.sink.add(true): controller.sink.add(false);
      } else if (event == AuthChangeEvent.signedIn) {
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
