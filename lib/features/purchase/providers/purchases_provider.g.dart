// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'purchases_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$purchasesByCustomerHash() =>
    r'fea3bdd8464c9720c2b939e63588ca38e363d652';

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

/// See also [purchasesByCustomer].
@ProviderFor(purchasesByCustomer)
const purchasesByCustomerProvider = PurchasesByCustomerFamily();

/// See also [purchasesByCustomer].
class PurchasesByCustomerFamily extends Family<List<PurchaseModel>> {
  /// See also [purchasesByCustomer].
  const PurchasesByCustomerFamily();

  /// See also [purchasesByCustomer].
  PurchasesByCustomerProvider call(
    String customerId,
  ) {
    return PurchasesByCustomerProvider(
      customerId,
    );
  }

  @override
  PurchasesByCustomerProvider getProviderOverride(
    covariant PurchasesByCustomerProvider provider,
  ) {
    return call(
      provider.customerId,
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
  String? get name => r'purchasesByCustomerProvider';
}

/// See also [purchasesByCustomer].
class PurchasesByCustomerProvider
    extends AutoDisposeProvider<List<PurchaseModel>> {
  /// See also [purchasesByCustomer].
  PurchasesByCustomerProvider(
    String customerId,
  ) : this._internal(
          (ref) => purchasesByCustomer(
            ref as PurchasesByCustomerRef,
            customerId,
          ),
          from: purchasesByCustomerProvider,
          name: r'purchasesByCustomerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$purchasesByCustomerHash,
          dependencies: PurchasesByCustomerFamily._dependencies,
          allTransitiveDependencies:
              PurchasesByCustomerFamily._allTransitiveDependencies,
          customerId: customerId,
        );

  PurchasesByCustomerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.customerId,
  }) : super.internal();

  final String customerId;

  @override
  Override overrideWith(
    List<PurchaseModel> Function(PurchasesByCustomerRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: PurchasesByCustomerProvider._internal(
        (ref) => create(ref as PurchasesByCustomerRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        customerId: customerId,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<List<PurchaseModel>> createElement() {
    return _PurchasesByCustomerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PurchasesByCustomerProvider &&
        other.customerId == customerId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, customerId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin PurchasesByCustomerRef on AutoDisposeProviderRef<List<PurchaseModel>> {
  /// The parameter `customerId` of this provider.
  String get customerId;
}

class _PurchasesByCustomerProviderElement
    extends AutoDisposeProviderElement<List<PurchaseModel>>
    with PurchasesByCustomerRef {
  _PurchasesByCustomerProviderElement(super.provider);

  @override
  String get customerId => (origin as PurchasesByCustomerProvider).customerId;
}

String _$purchasesByEmployeeHash() =>
    r'b5a33617cc82e0a28cec83cf6bc99884a825e107';

/// See also [purchasesByEmployee].
@ProviderFor(purchasesByEmployee)
const purchasesByEmployeeProvider = PurchasesByEmployeeFamily();

/// See also [purchasesByEmployee].
class PurchasesByEmployeeFamily extends Family<List<PurchaseModel>> {
  /// See also [purchasesByEmployee].
  const PurchasesByEmployeeFamily();

  /// See also [purchasesByEmployee].
  PurchasesByEmployeeProvider call(
    String employeeId,
  ) {
    return PurchasesByEmployeeProvider(
      employeeId,
    );
  }

  @override
  PurchasesByEmployeeProvider getProviderOverride(
    covariant PurchasesByEmployeeProvider provider,
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
  String? get name => r'purchasesByEmployeeProvider';
}

/// See also [purchasesByEmployee].
class PurchasesByEmployeeProvider
    extends AutoDisposeProvider<List<PurchaseModel>> {
  /// See also [purchasesByEmployee].
  PurchasesByEmployeeProvider(
    String employeeId,
  ) : this._internal(
          (ref) => purchasesByEmployee(
            ref as PurchasesByEmployeeRef,
            employeeId,
          ),
          from: purchasesByEmployeeProvider,
          name: r'purchasesByEmployeeProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$purchasesByEmployeeHash,
          dependencies: PurchasesByEmployeeFamily._dependencies,
          allTransitiveDependencies:
              PurchasesByEmployeeFamily._allTransitiveDependencies,
          employeeId: employeeId,
        );

  PurchasesByEmployeeProvider._internal(
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
    List<PurchaseModel> Function(PurchasesByEmployeeRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: PurchasesByEmployeeProvider._internal(
        (ref) => create(ref as PurchasesByEmployeeRef),
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
  AutoDisposeProviderElement<List<PurchaseModel>> createElement() {
    return _PurchasesByEmployeeProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PurchasesByEmployeeProvider &&
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
mixin PurchasesByEmployeeRef on AutoDisposeProviderRef<List<PurchaseModel>> {
  /// The parameter `employeeId` of this provider.
  String get employeeId;
}

class _PurchasesByEmployeeProviderElement
    extends AutoDisposeProviderElement<List<PurchaseModel>>
    with PurchasesByEmployeeRef {
  _PurchasesByEmployeeProviderElement(super.provider);

  @override
  String get employeeId => (origin as PurchasesByEmployeeProvider).employeeId;
}

String _$purchaseByIdHash() => r'e01c1a2a8768934f6768cb62507fa7a9f6509e9e';

/// See also [purchaseById].
@ProviderFor(purchaseById)
const purchaseByIdProvider = PurchaseByIdFamily();

/// See also [purchaseById].
class PurchaseByIdFamily extends Family<PurchaseModel?> {
  /// See also [purchaseById].
  const PurchaseByIdFamily();

  /// See also [purchaseById].
  PurchaseByIdProvider call(
    String id,
  ) {
    return PurchaseByIdProvider(
      id,
    );
  }

  @override
  PurchaseByIdProvider getProviderOverride(
    covariant PurchaseByIdProvider provider,
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
  String? get name => r'purchaseByIdProvider';
}

/// See also [purchaseById].
class PurchaseByIdProvider extends AutoDisposeProvider<PurchaseModel?> {
  /// See also [purchaseById].
  PurchaseByIdProvider(
    String id,
  ) : this._internal(
          (ref) => purchaseById(
            ref as PurchaseByIdRef,
            id,
          ),
          from: purchaseByIdProvider,
          name: r'purchaseByIdProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$purchaseByIdHash,
          dependencies: PurchaseByIdFamily._dependencies,
          allTransitiveDependencies:
              PurchaseByIdFamily._allTransitiveDependencies,
          id: id,
        );

  PurchaseByIdProvider._internal(
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
    PurchaseModel? Function(PurchaseByIdRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: PurchaseByIdProvider._internal(
        (ref) => create(ref as PurchaseByIdRef),
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
  AutoDisposeProviderElement<PurchaseModel?> createElement() {
    return _PurchaseByIdProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PurchaseByIdProvider && other.id == id;
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
mixin PurchaseByIdRef on AutoDisposeProviderRef<PurchaseModel?> {
  /// The parameter `id` of this provider.
  String get id;
}

class _PurchaseByIdProviderElement
    extends AutoDisposeProviderElement<PurchaseModel?> with PurchaseByIdRef {
  _PurchaseByIdProviderElement(super.provider);

  @override
  String get id => (origin as PurchaseByIdProvider).id;
}

String _$recentPurchasesHash() => r'1f550955a76758da7ca2986f3c425ab0e6759355';

/// See also [recentPurchases].
@ProviderFor(recentPurchases)
const recentPurchasesProvider = RecentPurchasesFamily();

/// See also [recentPurchases].
class RecentPurchasesFamily extends Family<List<PurchaseModel>> {
  /// See also [recentPurchases].
  const RecentPurchasesFamily();

  /// See also [recentPurchases].
  RecentPurchasesProvider call({
    int limit = 10,
  }) {
    return RecentPurchasesProvider(
      limit: limit,
    );
  }

  @override
  RecentPurchasesProvider getProviderOverride(
    covariant RecentPurchasesProvider provider,
  ) {
    return call(
      limit: provider.limit,
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
  String? get name => r'recentPurchasesProvider';
}

/// See also [recentPurchases].
class RecentPurchasesProvider extends AutoDisposeProvider<List<PurchaseModel>> {
  /// See also [recentPurchases].
  RecentPurchasesProvider({
    int limit = 10,
  }) : this._internal(
          (ref) => recentPurchases(
            ref as RecentPurchasesRef,
            limit: limit,
          ),
          from: recentPurchasesProvider,
          name: r'recentPurchasesProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$recentPurchasesHash,
          dependencies: RecentPurchasesFamily._dependencies,
          allTransitiveDependencies:
              RecentPurchasesFamily._allTransitiveDependencies,
          limit: limit,
        );

  RecentPurchasesProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.limit,
  }) : super.internal();

  final int limit;

  @override
  Override overrideWith(
    List<PurchaseModel> Function(RecentPurchasesRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: RecentPurchasesProvider._internal(
        (ref) => create(ref as RecentPurchasesRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        limit: limit,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<List<PurchaseModel>> createElement() {
    return _RecentPurchasesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is RecentPurchasesProvider && other.limit == limit;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, limit.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin RecentPurchasesRef on AutoDisposeProviderRef<List<PurchaseModel>> {
  /// The parameter `limit` of this provider.
  int get limit;
}

class _RecentPurchasesProviderElement
    extends AutoDisposeProviderElement<List<PurchaseModel>>
    with RecentPurchasesRef {
  _RecentPurchasesProviderElement(super.provider);

  @override
  int get limit => (origin as RecentPurchasesProvider).limit;
}

String _$purchasesNotifierHash() => r'd95ce4e5fd2b6141e06f91d2a0312267ee7eae96';

/// See also [PurchasesNotifier].
@ProviderFor(PurchasesNotifier)
final purchasesNotifierProvider = AutoDisposeNotifierProvider<PurchasesNotifier,
    List<PurchaseModel>>.internal(
  PurchasesNotifier.new,
  name: r'purchasesNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$purchasesNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$PurchasesNotifier = AutoDisposeNotifier<List<PurchaseModel>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
