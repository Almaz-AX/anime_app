// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_titles.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchTitles _$SearchTitlesFromJson(Map<String, dynamic> json) => SearchTitles(
      list: SearchTitles._parseTitleList(json['list'] as List),
      pagination:
          Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SearchTitlesToJson(SearchTitles instance) =>
    <String, dynamic>{
      'list': instance.list,
      'pagination': instance.pagination,
    };
