// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'watched_title.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetWatchedTitleCollection on Isar {
  IsarCollection<WatchedTitle> get watchedTitles => this.collection();
}

const WatchedTitleSchema = CollectionSchema(
  name: r'WatchedTitle',
  id: -3630238573977050511,
  properties: {
    r'watchedEpisodes': PropertySchema(
      id: 0,
      name: r'watchedEpisodes',
      type: IsarType.longList,
    )
  },
  estimateSize: _watchedTitleEstimateSize,
  serialize: _watchedTitleSerialize,
  deserialize: _watchedTitleDeserialize,
  deserializeProp: _watchedTitleDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _watchedTitleGetId,
  getLinks: _watchedTitleGetLinks,
  attach: _watchedTitleAttach,
  version: '3.1.0+1',
);

int _watchedTitleEstimateSize(
  WatchedTitle object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.watchedEpisodes.length * 8;
  return bytesCount;
}

void _watchedTitleSerialize(
  WatchedTitle object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLongList(offsets[0], object.watchedEpisodes);
}

WatchedTitle _watchedTitleDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = WatchedTitle(
    id: id,
    watchedEpisodes: reader.readLongList(offsets[0]) ?? [],
  );
  return object;
}

P _watchedTitleDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLongList(offset) ?? []) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _watchedTitleGetId(WatchedTitle object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _watchedTitleGetLinks(WatchedTitle object) {
  return [];
}

void _watchedTitleAttach(
    IsarCollection<dynamic> col, Id id, WatchedTitle object) {}

extension WatchedTitleQueryWhereSort
    on QueryBuilder<WatchedTitle, WatchedTitle, QWhere> {
  QueryBuilder<WatchedTitle, WatchedTitle, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension WatchedTitleQueryWhere
    on QueryBuilder<WatchedTitle, WatchedTitle, QWhereClause> {
  QueryBuilder<WatchedTitle, WatchedTitle, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<WatchedTitle, WatchedTitle, QAfterWhereClause> idNotEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<WatchedTitle, WatchedTitle, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<WatchedTitle, WatchedTitle, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<WatchedTitle, WatchedTitle, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension WatchedTitleQueryFilter
    on QueryBuilder<WatchedTitle, WatchedTitle, QFilterCondition> {
  QueryBuilder<WatchedTitle, WatchedTitle, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<WatchedTitle, WatchedTitle, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<WatchedTitle, WatchedTitle, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<WatchedTitle, WatchedTitle, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<WatchedTitle, WatchedTitle, QAfterFilterCondition>
      watchedEpisodesElementEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'watchedEpisodes',
        value: value,
      ));
    });
  }

  QueryBuilder<WatchedTitle, WatchedTitle, QAfterFilterCondition>
      watchedEpisodesElementGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'watchedEpisodes',
        value: value,
      ));
    });
  }

  QueryBuilder<WatchedTitle, WatchedTitle, QAfterFilterCondition>
      watchedEpisodesElementLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'watchedEpisodes',
        value: value,
      ));
    });
  }

  QueryBuilder<WatchedTitle, WatchedTitle, QAfterFilterCondition>
      watchedEpisodesElementBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'watchedEpisodes',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<WatchedTitle, WatchedTitle, QAfterFilterCondition>
      watchedEpisodesLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'watchedEpisodes',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<WatchedTitle, WatchedTitle, QAfterFilterCondition>
      watchedEpisodesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'watchedEpisodes',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<WatchedTitle, WatchedTitle, QAfterFilterCondition>
      watchedEpisodesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'watchedEpisodes',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<WatchedTitle, WatchedTitle, QAfterFilterCondition>
      watchedEpisodesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'watchedEpisodes',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<WatchedTitle, WatchedTitle, QAfterFilterCondition>
      watchedEpisodesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'watchedEpisodes',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<WatchedTitle, WatchedTitle, QAfterFilterCondition>
      watchedEpisodesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'watchedEpisodes',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }
}

extension WatchedTitleQueryObject
    on QueryBuilder<WatchedTitle, WatchedTitle, QFilterCondition> {}

extension WatchedTitleQueryLinks
    on QueryBuilder<WatchedTitle, WatchedTitle, QFilterCondition> {}

extension WatchedTitleQuerySortBy
    on QueryBuilder<WatchedTitle, WatchedTitle, QSortBy> {}

extension WatchedTitleQuerySortThenBy
    on QueryBuilder<WatchedTitle, WatchedTitle, QSortThenBy> {
  QueryBuilder<WatchedTitle, WatchedTitle, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<WatchedTitle, WatchedTitle, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }
}

extension WatchedTitleQueryWhereDistinct
    on QueryBuilder<WatchedTitle, WatchedTitle, QDistinct> {
  QueryBuilder<WatchedTitle, WatchedTitle, QDistinct>
      distinctByWatchedEpisodes() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'watchedEpisodes');
    });
  }
}

extension WatchedTitleQueryProperty
    on QueryBuilder<WatchedTitle, WatchedTitle, QQueryProperty> {
  QueryBuilder<WatchedTitle, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<WatchedTitle, List<int>, QQueryOperations>
      watchedEpisodesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'watchedEpisodes');
    });
  }
}
