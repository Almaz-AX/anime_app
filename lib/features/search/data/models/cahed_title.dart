// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:equatable/equatable.dart';

class CahedTitle extends Equatable {
  final int id;
  final String name;
  final String poster;
  final List<String> genres;
  const CahedTitle({
    required this.id,
    required this.name,
    required this.poster,
    required this.genres,
  });
  
  @override
  // TODO: implement props
  List<Object> get props => [id, name, poster, genres];

  

 

  CahedTitle copyWith({
    int? id,
    String? name,
    String? poster,
    List<String>? genres,
  }) {
    return CahedTitle(
      id: id ?? this.id,
      name: name ?? this.name,
      poster: poster ?? this.poster,
      genres: genres ?? this.genres,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'poster': poster,
      'genres': genres,
    };
  }

  factory CahedTitle.fromMap(Map<String, dynamic> map) {
    return CahedTitle(
      id: map['id'] as int,
      name: map['name'] as String,
      poster: map['poster'] as String,
      genres: List<String>.from((map['genres'] as List<String>),
    ));
  }

  String toJson() => json.encode(toMap());

  factory CahedTitle.fromJson(String source) => CahedTitle.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;
}
