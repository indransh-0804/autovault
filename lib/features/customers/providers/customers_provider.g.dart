// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customers_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$customerByIdHash() => r'735564f5c340e14434ab53426268ab7119179935';

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

/// See also [customerById].
@ProviderFor(customerById)
const customerByIdProvider = CustomerByIdFamily();

/// See also [customerById].
class CustomerByIdFamily extends Family<CustomerModel?> {
  /// See also [customerById].
  const CustomerByIdFamily();

  /// See also [customerById].
  CustomerByIdProvider call(
    String id,
  ) {
    return CustomerByIdProvider(
      id,
    );
  }

  @override
  CustomerByIdProvider getProviderOverride(
    covariant CustomerByIdProvider provider,
  ) {
    return call(
      provider.id,
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
  String? get name => r'customerByIdProvider';
}

/// See also [customerById].
class CustomerByIdProvider extends AutoDisposeProvider<CustomerModel?> {
  /// See also [customerById].
  CustomerByIdProvider(
    String id,
  ) : this._internal(
          (ref) => customerById(
            ref as CustomerByIdRef,
            id,
          ),
          from: customerByIdProvider,
          name: r'customerByIdProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$customerByIdHash,
          dependencies: CustomerByIdFamily._dependencies,
          allTransitiveDependencies:
              CustomerByIdFamily._allTransitiveDependencies,
          id: id,
        );

  CustomerByIdProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final String id;

  @override
  Override overrideWith(
    CustomerModel? Function(CustomerByIdRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CustomerByIdProvider._internal(
        (ref) => create(ref as CustomerByIdRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<CustomerModel?> createElement() {
    return _CustomerByIdProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CustomerByIdProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin CustomerByIdRef on AutoDisposeProviderRef<CustomerModel?> {
  /// The parameter `id` of this provider.
  String get id;
}

class _CustomerByIdProviderElement
    extends AutoDisposeProviderElement<CustomerModel?> with CustomerByIdRef {
  _CustomerByIdProviderElement(super.provider);

  @override
  String get id => (origin as CustomerByIdProvider).id;
}

String _$filteredCustomersHash() => r'd0c029cc407ab41b9d277b76be6bf8eff3652fc0';

/// See also [filteredCustomers].
@ProviderFor(filteredCustomers)
const filteredCustomersProvider = FilteredCustomersFamily();

/// See also [filteredCustomers].
class FilteredCustomersFamily extends Family<List<CustomerModel>> {
  /// See also [filteredCustomers].
  const FilteredCustomersFamily();

  /// See also [filteredCustomers].
  FilteredCustomersProvider call({
    String query = '',
    String statusFilter = 'All',
    String sortBy = 'Recent',
    String? employeeId,
  }) {
    return FilteredCustomersProvider(
      query: query,
      statusFilter: statusFilter,
      sortBy: sortBy,
      employeeId: employeeId,
    );
  }

  @override
  FilteredCustomersProvider getProviderOverride(
    covariant FilteredCustomersProvider provider,
  ) {
    return call(
      query: provider.query,
      statusFilter: provider.statusFilter,
      sortBy: provider.sortBy,
      employeeId: provider.employeeId,
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
  String? get name => r'filteredCustomersProvider';
}

/// See also [filteredCustomers].
class FilteredCustomersProvider
    extends AutoDisposeProvider<List<CustomerModel>> {
  /// See also [filteredCustomers].
  FilteredCustomersProvider({
    String query = '',
    String statusFilter = 'All',
    String sortBy = 'Recent',
    String? employeeId,
  }) : this._internal(
          (ref) => filteredCustomers(
            ref as FilteredCustomersRef,
            query: query,
            statusFilter: statusFilter,
            sortBy: sortBy,
            employeeId: employeeId,
          ),
          from: filteredCustomersProvider,
          name: r'filteredCustomersProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$filteredCustomersHash,
          dependencies: FilteredCustomersFamily._dependencies,
          allTransitiveDependencies:
              FilteredCustomersFamily._allTransitiveDependencies,
          query: query,
          statusFilter: statusFilter,
          sortBy: sortBy,
          employeeId: employeeId,
        );

  FilteredCustomersProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.query,
    required this.statusFilter,
    required this.sortBy,
    required this.employeeId,
  }) : super.internal();

  final String query;
  final String statusFilter;
  final String sortBy;
  final String? employeeId;

  @override
  Override overrideWith(
    List<CustomerModel> Function(FilteredCustomersRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FilteredCustomersProvider._internal(
        (ref) => create(ref as FilteredCustomersRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        query: query,
        statusFilter: statusFilter,
        sortBy: sortBy,
        employeeId: employeeId,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<List<CustomerModel>> createElement() {
    return _FilteredCustomersProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FilteredCustomersProvider &&
        other.query == query &&
        other.statusFilter == statusFilter &&
        other.sortBy == sortBy &&
        other.employeeId == employeeId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, query.hashCode);
    hash = _SystemHash.combine(hash, statusFilter.hashCode);
    hash = _SystemHash.combine(hash, sortBy.hashCode);
    hash = _SystemHash.combine(hash, employeeId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin FilteredCustomersRef on AutoDisposeProviderRef<List<CustomerModel>> {
  /// The parameter `query` of this provider.
  String get query;

  /// The parameter `statusFilter` of this provider.
  String get statusFilter;

  /// The parameter `sortBy` of this provider.
  String get sortBy;

  /// The parameter `employeeId` of this provider.
  String? get employeeId;
}

class _FilteredCustomersProviderElement
    extends AutoDisposeProviderElement<List<CustomerModel>>
    with FilteredCustomersRef {
  _FilteredCustomersProviderElement(super.provider);

  @override
  String get query => (origin as FilteredCustomersProvider).query;
  @override
  String get statusFilter => (origin as FilteredCustomersProvider).statusFilter;
  @override
  String get sortBy => (origin as FilteredCustomersProvider).sortBy;
  @override
  String? get employeeId => (origin as FilteredCustomersProvider).employeeId;
}

String _$customersByStatusHash() => r'28fb3c5d219d2cdf541b7c45f92d558326b3dc50';

/// See also [customersByStatus].
@ProviderFor(customersByStatus)
const customersByStatusProvider = CustomersByStatusFamily();

/// See also [customersByStatus].
class CustomersByStatusFamily extends Family<List<CustomerModel>> {
  /// See also [customersByStatus].
  const CustomersByStatusFamily();

  /// See also [customersByStatus].
  CustomersByStatusProvider call(
    LeadStatus status,
  ) {
    return CustomersByStatusProvider(
      status,
    );
  }

  @override
  CustomersByStatusProvider getProviderOverride(
    covariant CustomersByStatusProvider provider,
  ) {
    return call(
      provider.status,
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
  String? get name => r'customersByStatusProvider';
}

/// See also [customersByStatus].
class CustomersByStatusProvider
    extends AutoDisposeProvider<List<CustomerModel>> {
  /// See also [customersByStatus].
  CustomersByStatusProvider(
    LeadStatus status,
  ) : this._internal(
          (ref) => customersByStatus(
            ref as CustomersByStatusRef,
            status,
          ),
          from: customersByStatusProvider,
          name: r'customersByStatusProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$customersByStatusHash,
          dependencies: CustomersByStatusFamily._dependencies,
          allTransitiveDependencies:
              CustomersByStatusFamily._allTransitiveDependencies,
          status: status,
        );

  CustomersByStatusProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.status,
  }) : super.internal();

  final LeadStatus status;

  @override
  Override overrideWith(
    List<CustomerModel> Function(CustomersByStatusRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CustomersByStatusProvider._internal(
        (ref) => create(ref as CustomersByStatusRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        status: status,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<List<CustomerModel>> createElement() {
    return _CustomersByStatusProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CustomersByStatusProvider && other.status == status;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, status.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin CustomersByStatusRef on AutoDisposeProviderRef<List<CustomerModel>> {
  /// The parameter `status` of this provider.
  LeadStatus get status;
}

class _CustomersByStatusProviderElement
    extends AutoDisposeProviderElement<List<CustomerModel>>
    with CustomersByStatusRef {
  _CustomersByStatusProviderElement(super.provider);

  @override
  LeadStatus get status => (origin as CustomersByStatusProvider).status;
}

String _$customersByEmployeeHash() =>
    r'3d228632059358cece7bbf736b170064166700a3';

/// See also [customersByEmployee].
@ProviderFor(customersByEmployee)
const customersByEmployeeProvider = CustomersByEmployeeFamily();

/// See also [customersByEmployee].
class CustomersByEmployeeFamily extends Family<List<CustomerModel>> {
  /// See also [customersByEmployee].
  const CustomersByEmployeeFamily();

  /// See also [customersByEmployee].
  CustomersByEmployeeProvider call(
    String employeeId,
  ) {
    return CustomersByEmployeeProvider(
      employeeId,
    );
  }

  @override
  CustomersByEmployeeProvider getProviderOverride(
    covariant CustomersByEmployeeProvider provider,
  ) {
    return call(
      provider.employeeId,
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
  String? get name => r'customersByEmployeeProvider';
}

/// See also [customersByEmployee].
class CustomersByEmployeeProvider
    extends AutoDisposeProvider<List<CustomerModel>> {
  /// See also [customersByEmployee].
  CustomersByEmployeeProvider(
    String employeeId,
  ) : this._internal(
          (ref) => customersByEmployee(
            ref as CustomersByEmployeeRef,
            employeeId,
          ),
          from: customersByEmployeeProvider,
          name: r'customersByEmployeeProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$customersByEmployeeHash,
          dependencies: CustomersByEmployeeFamily._dependencies,
          allTransitiveDependencies:
              CustomersByEmployeeFamily._allTransitiveDependencies,
          employeeId: employeeId,
        );

  CustomersByEmployeeProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.employeeId,
  }) : super.internal();

  final String employeeId;

  @override
  Override overrideWith(
    List<CustomerModel> Function(CustomersByEmployeeRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CustomersByEmployeeProvider._internal(
        (ref) => create(ref as CustomersByEmployeeRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        employeeId: employeeId,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<List<CustomerModel>> createElement() {
    return _CustomersByEmployeeProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CustomersByEmployeeProvider &&
        other.employeeId == employeeId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, employeeId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin CustomersByEmployeeRef on AutoDisposeProviderRef<List<CustomerModel>> {
  /// The parameter `employeeId` of this provider.
  String get employeeId;
}

class _CustomersByEmployeeProviderElement
    extends AutoDisposeProviderElement<List<CustomerModel>>
    with CustomersByEmployeeRef {
  _CustomersByEmployeeProviderElement(super.provider);

  @override
  String get employeeId => (origin as CustomersByEmployeeProvider).employeeId;
}

String _$allCustomersHash() => r'd5686a88f10acfc677f64627eb20f2c4c6c41f16';

/// Returns all customers — useful for purchase/loan customer picker dropdowns.
///
/// Copied from [allCustomers].
@ProviderFor(allCustomers)
final allCustomersProvider = AutoDisposeProvider<List<CustomerModel>>.internal(
  allCustomers,
  name: r'allCustomersProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$allCustomersHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AllCustomersRef = AutoDisposeProviderRef<List<CustomerModel>>;
String _$customersNotifierHash() => r'1f77b429e17d7a438a7abb99016e953bea185f28';

/// See also [CustomersNotifier].
@ProviderFor(CustomersNotifier)
final customersNotifierProvider = AutoDisposeNotifierProvider<CustomersNotifier,
    List<CustomerModel>>.internal(
  CustomersNotifier.new,
  name: r'customersNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$customersNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CustomersNotifier = AutoDisposeNotifier<List<CustomerModel>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
