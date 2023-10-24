// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'anime_title_updates.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TitleUpdates _$TitleUpdatesFromJson(Map<String, dynamic> json) => TitleUpdates(
      list: TitleUpdates._parseTitleList(json['list'] as List),
      pagination:
          Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TitleUpdatesToJson(TitleUpdates instance) =>
    <String, dynamic>{
      'list': instance.list,
      'pagination': instance.pagination,
    };

Pagination _$PaginationFromJson(Map<String, dynamic> json) => Pagination(
      pages: json['pages'] as int,
      currentPage: json['current_page'] as int,
      itemsPerPage: json['items_per_page'] as int,
      totalItems: json['total_items'] as int,
    );

Map<String, dynamic> _$PaginationToJson(Pagination instance) =>
    <String, dynamic>{
      'pages': instance.pages,
      'current_page': instance.currentPage,
      'items_per_page': instance.itemsPerPage,
      'total_items': instance.totalItems,
    };
