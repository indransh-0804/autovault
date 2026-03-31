// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parts_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$filteredPartsHash() => r'27275896ee0405cf46e5952ac31b5bddc8b23010';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [filteredParts].
@ProviderFor(filteredParts)
const filteredPartsProvider = FilteredPartsFamily();

/// See also [filteredParts].
class FilteredPartsFamily extends Family<List<PartModel>> {
  /// See also [filteredParts].
  const FilteredPartsFamily();

  /// See also [filteredParts].
  FilteredPartsProvider call({
    String query = '',
    String categoryFilter = 'All',
  }) {
    return FilteredPartsProvider(
      query: query,
      categoryFilter: categoryFilter,
    );
  }

  @override
  FilteredPartsProvider getProviderOverride(
    covariant FilteredPartsProvider provider,
  ) {
    return call(
      query: provider.query,
      categoryFilter: provider.categoryFilter,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'filteredPartsProvider';
}

/// See also [filteredParts].
class FilteredPartsProvider extends AutoDisposeProvider<List<PartModel>> {
  /// See also [filteredParts].
  FilteredPartsProvider({
    String query = '',
    String categoryFilter = 'All',
  }) : this._internal(
          (ref) => filteredParts(
            ref as FilteredPartsRef,
            query: query,
            categoryFilter: categoryFilter,
          ),
          from: filteredPartsProvider,
          name: r'filteredPartsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$filteredPartsHash,
          dependencies: FilteredPartsFamily._dependencies,
          allTransitiveDependencies:
              FilteredPartsFamily._allTransitiveDependencies,
          query: query,
          categoryFilter: categoryFilter,
        );

  FilteredPartsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.query,
    required this.categoryFilter,
  }) : super.internal();

  final String query;
  final String categoryFilter;

  @override
  Override overrideWith(
    List<PartModel> Function(FilteredPartsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FilteredPartsProvider._internal(
        (ref) => create(ref as FilteredPartsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        query: query,
        categoryFilter: categoryFilter,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<List<PartModel>> createElement() {
    return _FilteredPartsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FilteredPartsProvider &&
        other.query == query &&
        other.categoryFilter == categoryFilter;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, query.hashCode);
    hash = _SystemHash.combine(hash, categoryFilter.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin FilteredPartsRef on AutoDisposeProviderRef<List<PartModel>> {
  /// The parameter `query` of this provider.
  String get query;

  /// The parameter `categoryFilter` of this provider.
  String get categoryFilter;
}

class _FilteredPartsProviderElement
    extends AutoDisposeProviderElement<List<PartModel>> with FilteredPartsRef {
  _FilteredPartsProviderElement(super.provider);

  @override
  String get query => (origin as FilteredPartsProvider).query;
  @override
  String get categoryFilter => (origin as FilteredPartsProvider).categoryFilter;
}

String _$lowStockPartsHash() => r'16ce89de2741f4faa56b4b16306365e3b9c42d8f';

/// See also [lowStockParts].
@ProviderFor(lowStockParts)
final lowStockPartsProvider = AutoDisposeProvider<List<PartModel>>.internal(
  lowStockParts,
  name: r'lowStockPartsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$lowStockPartsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef LowStockPartsRef = AutoDisposeProviderRef<List<PartModel>>;
String _$partsNotifierHash() => r'7dff742978ce334275e5da6c9e680a44d4f7622c';

/// See also [PartsNotifier].
@ProviderFor(PartsNotifier)
final partsNotifierProvider =
    AutoDisposeNotifierProvider<PartsNotifier, List<PartModel>>.internal(
  PartsNotifier.new,
  name: r'partsNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$partsNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$PartsNotifier = AutoDisposeNotifier<List<PartModel>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
