// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cars_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$filteredCarsHash() => r'be9058572a27a20ed27e9e5422526712e01d9354';

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

/// See also [filteredCars].
@ProviderFor(filteredCars)
const filteredCarsProvider = FilteredCarsFamily();

/// See also [filteredCars].
class FilteredCarsFamily extends Family<List<CarModel>> {
  /// See also [filteredCars].
  const FilteredCarsFamily();

  /// See also [filteredCars].
  FilteredCarsProvider call({
    String query = '',
    String statusFilter = 'All',
  }) {
    return FilteredCarsProvider(
      query: query,
      statusFilter: statusFilter,
    );
  }

  @override
  FilteredCarsProvider getProviderOverride(
    covariant FilteredCarsProvider provider,
  ) {
    return call(
      query: provider.query,
      statusFilter: provider.statusFilter,
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
  String? get name => r'filteredCarsProvider';
}

/// See also [filteredCars].
class FilteredCarsProvider extends AutoDisposeProvider<List<CarModel>> {
  /// See also [filteredCars].
  FilteredCarsProvider({
    String query = '',
    String statusFilter = 'All',
  }) : this._internal(
          (ref) => filteredCars(
            ref as FilteredCarsRef,
            query: query,
            statusFilter: statusFilter,
          ),
          from: filteredCarsProvider,
          name: r'filteredCarsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$filteredCarsHash,
          dependencies: FilteredCarsFamily._dependencies,
          allTransitiveDependencies:
              FilteredCarsFamily._allTransitiveDependencies,
          query: query,
          statusFilter: statusFilter,
        );

  FilteredCarsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.query,
    required this.statusFilter,
  }) : super.internal();

  final String query;
  final String statusFilter;

  @override
  Override overrideWith(
    List<CarModel> Function(FilteredCarsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FilteredCarsProvider._internal(
        (ref) => create(ref as FilteredCarsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        query: query,
        statusFilter: statusFilter,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<List<CarModel>> createElement() {
    return _FilteredCarsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FilteredCarsProvider &&
        other.query == query &&
        other.statusFilter == statusFilter;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, query.hashCode);
    hash = _SystemHash.combine(hash, statusFilter.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin FilteredCarsRef on AutoDisposeProviderRef<List<CarModel>> {
  /// The parameter `query` of this provider.
  String get query;

  /// The parameter `statusFilter` of this provider.
  String get statusFilter;
}

class _FilteredCarsProviderElement
    extends AutoDisposeProviderElement<List<CarModel>> with FilteredCarsRef {
  _FilteredCarsProviderElement(super.provider);

  @override
  String get query => (origin as FilteredCarsProvider).query;
  @override
  String get statusFilter => (origin as FilteredCarsProvider).statusFilter;
}

String _$carsStatsHash() => r'82936389434775d5058108b15273ccccb73bc4d4';

/// See also [carsStats].
@ProviderFor(carsStats)
final carsStatsProvider = AutoDisposeProvider<Map<String, int>>.internal(
  carsStats,
  name: r'carsStatsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$carsStatsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CarsStatsRef = AutoDisposeProviderRef<Map<String, int>>;
String _$carsNotifierHash() => r'0a0bed3814c885fc24e8ff0896f33441935f5625';

/// See also [CarsNotifier].
@ProviderFor(CarsNotifier)
final carsNotifierProvider =
    AutoDisposeNotifierProvider<CarsNotifier, List<CarModel>>.internal(
  CarsNotifier.new,
  name: r'carsNotifierProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$carsNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CarsNotifier = AutoDisposeNotifier<List<CarModel>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
