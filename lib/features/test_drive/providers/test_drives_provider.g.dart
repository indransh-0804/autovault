// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'test_drives_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$testDrivesByDateHash() => r'f77ca146195d67342c604f14f8bc038c1bedfbe5';

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

/// See also [testDrivesByDate].
@ProviderFor(testDrivesByDate)
const testDrivesByDateProvider = TestDrivesByDateFamily();

/// See also [testDrivesByDate].
class TestDrivesByDateFamily extends Family<List<TestDriveModel>> {
  /// See also [testDrivesByDate].
  const TestDrivesByDateFamily();

  /// See also [testDrivesByDate].
  TestDrivesByDateProvider call(
    DateTime date,
  ) {
    return TestDrivesByDateProvider(
      date,
    );
  }

  @override
  TestDrivesByDateProvider getProviderOverride(
    covariant TestDrivesByDateProvider provider,
  ) {
    return call(
      provider.date,
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
  String? get name => r'testDrivesByDateProvider';
}

/// See also [testDrivesByDate].
class TestDrivesByDateProvider
    extends AutoDisposeProvider<List<TestDriveModel>> {
  /// See also [testDrivesByDate].
  TestDrivesByDateProvider(
    DateTime date,
  ) : this._internal(
          (ref) => testDrivesByDate(
            ref as TestDrivesByDateRef,
            date,
          ),
          from: testDrivesByDateProvider,
          name: r'testDrivesByDateProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$testDrivesByDateHash,
          dependencies: TestDrivesByDateFamily._dependencies,
          allTransitiveDependencies:
              TestDrivesByDateFamily._allTransitiveDependencies,
          date: date,
        );

  TestDrivesByDateProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.date,
  }) : super.internal();

  final DateTime date;

  @override
  Override overrideWith(
    List<TestDriveModel> Function(TestDrivesByDateRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: TestDrivesByDateProvider._internal(
        (ref) => create(ref as TestDrivesByDateRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        date: date,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<List<TestDriveModel>> createElement() {
    return _TestDrivesByDateProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TestDrivesByDateProvider && other.date == date;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, date.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin TestDrivesByDateRef on AutoDisposeProviderRef<List<TestDriveModel>> {
  /// The parameter `date` of this provider.
  DateTime get date;
}

class _TestDrivesByDateProviderElement
    extends AutoDisposeProviderElement<List<TestDriveModel>>
    with TestDrivesByDateRef {
  _TestDrivesByDateProviderElement(super.provider);

  @override
  DateTime get date => (origin as TestDrivesByDateProvider).date;
}

String _$testDrivesByCustomerHash() =>
    r'd458793e4c76edcd4664ff1ab26472904bc9ab4b';

/// See also [testDrivesByCustomer].
@ProviderFor(testDrivesByCustomer)
const testDrivesByCustomerProvider = TestDrivesByCustomerFamily();

/// See also [testDrivesByCustomer].
class TestDrivesByCustomerFamily extends Family<List<TestDriveModel>> {
  /// See also [testDrivesByCustomer].
  const TestDrivesByCustomerFamily();

  /// See also [testDrivesByCustomer].
  TestDrivesByCustomerProvider call(
    String customerId,
  ) {
    return TestDrivesByCustomerProvider(
      customerId,
    );
  }

  @override
  TestDrivesByCustomerProvider getProviderOverride(
    covariant TestDrivesByCustomerProvider provider,
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
  String? get name => r'testDrivesByCustomerProvider';
}

/// See also [testDrivesByCustomer].
class TestDrivesByCustomerProvider
    extends AutoDisposeProvider<List<TestDriveModel>> {
  /// See also [testDrivesByCustomer].
  TestDrivesByCustomerProvider(
    String customerId,
  ) : this._internal(
          (ref) => testDrivesByCustomer(
            ref as TestDrivesByCustomerRef,
            customerId,
          ),
          from: testDrivesByCustomerProvider,
          name: r'testDrivesByCustomerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$testDrivesByCustomerHash,
          dependencies: TestDrivesByCustomerFamily._dependencies,
          allTransitiveDependencies:
              TestDrivesByCustomerFamily._allTransitiveDependencies,
          customerId: customerId,
        );

  TestDrivesByCustomerProvider._internal(
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
    List<TestDriveModel> Function(TestDrivesByCustomerRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: TestDrivesByCustomerProvider._internal(
        (ref) => create(ref as TestDrivesByCustomerRef),
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
  AutoDisposeProviderElement<List<TestDriveModel>> createElement() {
    return _TestDrivesByCustomerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TestDrivesByCustomerProvider &&
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
mixin TestDrivesByCustomerRef on AutoDisposeProviderRef<List<TestDriveModel>> {
  /// The parameter `customerId` of this provider.
  String get customerId;
}

class _TestDrivesByCustomerProviderElement
    extends AutoDisposeProviderElement<List<TestDriveModel>>
    with TestDrivesByCustomerRef {
  _TestDrivesByCustomerProviderElement(super.provider);

  @override
  String get customerId => (origin as TestDrivesByCustomerProvider).customerId;
}

String _$testDrivesByEmployeeHash() =>
    r'809711731521de3b0641ff402248e3f7f9c92cbd';

/// See also [testDrivesByEmployee].
@ProviderFor(testDrivesByEmployee)
const testDrivesByEmployeeProvider = TestDrivesByEmployeeFamily();

/// See also [testDrivesByEmployee].
class TestDrivesByEmployeeFamily extends Family<List<TestDriveModel>> {
  /// See also [testDrivesByEmployee].
  const TestDrivesByEmployeeFamily();

  /// See also [testDrivesByEmployee].
  TestDrivesByEmployeeProvider call(
    String employeeId,
  ) {
    return TestDrivesByEmployeeProvider(
      employeeId,
    );
  }

  @override
  TestDrivesByEmployeeProvider getProviderOverride(
    covariant TestDrivesByEmployeeProvider provider,
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
  String? get name => r'testDrivesByEmployeeProvider';
}

/// See also [testDrivesByEmployee].
class TestDrivesByEmployeeProvider
    extends AutoDisposeProvider<List<TestDriveModel>> {
  /// See also [testDrivesByEmployee].
  TestDrivesByEmployeeProvider(
    String employeeId,
  ) : this._internal(
          (ref) => testDrivesByEmployee(
            ref as TestDrivesByEmployeeRef,
            employeeId,
          ),
          from: testDrivesByEmployeeProvider,
          name: r'testDrivesByEmployeeProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$testDrivesByEmployeeHash,
          dependencies: TestDrivesByEmployeeFamily._dependencies,
          allTransitiveDependencies:
              TestDrivesByEmployeeFamily._allTransitiveDependencies,
          employeeId: employeeId,
        );

  TestDrivesByEmployeeProvider._internal(
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
    List<TestDriveModel> Function(TestDrivesByEmployeeRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: TestDrivesByEmployeeProvider._internal(
        (ref) => create(ref as TestDrivesByEmployeeRef),
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
  AutoDisposeProviderElement<List<TestDriveModel>> createElement() {
    return _TestDrivesByEmployeeProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TestDrivesByEmployeeProvider &&
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
mixin TestDrivesByEmployeeRef on AutoDisposeProviderRef<List<TestDriveModel>> {
  /// The parameter `employeeId` of this provider.
  String get employeeId;
}

class _TestDrivesByEmployeeProviderElement
    extends AutoDisposeProviderElement<List<TestDriveModel>>
    with TestDrivesByEmployeeRef {
  _TestDrivesByEmployeeProviderElement(super.provider);

  @override
  String get employeeId => (origin as TestDrivesByEmployeeProvider).employeeId;
}

String _$upcomingTestDrivesHash() =>
    r'770b6d933f8fbdcf5e2d1510ec7198fe3301f770';

/// See also [upcomingTestDrives].
@ProviderFor(upcomingTestDrives)
final upcomingTestDrivesProvider =
    AutoDisposeProvider<List<TestDriveModel>>.internal(
  upcomingTestDrives,
  name: r'upcomingTestDrivesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$upcomingTestDrivesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef UpcomingTestDrivesRef = AutoDisposeProviderRef<List<TestDriveModel>>;
String _$todaysTestDrivesHash() => r'522d484c6e38fe77069c85d685576ebf68589150';

/// See also [todaysTestDrives].
@ProviderFor(todaysTestDrives)
final todaysTestDrivesProvider =
    AutoDisposeProvider<List<TestDriveModel>>.internal(
  todaysTestDrives,
  name: r'todaysTestDrivesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$todaysTestDrivesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TodaysTestDrivesRef = AutoDisposeProviderRef<List<TestDriveModel>>;
String _$conflictingTestDriveHash() =>
    r'037100085be2b21e40b224c9db9a056a123964b4';

/// See also [conflictingTestDrive].
@ProviderFor(conflictingTestDrive)
const conflictingTestDriveProvider = ConflictingTestDriveFamily();

/// See also [conflictingTestDrive].
class ConflictingTestDriveFamily extends Family<TestDriveModel?> {
  /// See also [conflictingTestDrive].
  const ConflictingTestDriveFamily();

  /// See also [conflictingTestDrive].
  ConflictingTestDriveProvider call({
    required String carId,
    required DateTime scheduledAt,
    required int durationMinutes,
    String? excludeId,
  }) {
    return ConflictingTestDriveProvider(
      carId: carId,
      scheduledAt: scheduledAt,
      durationMinutes: durationMinutes,
      excludeId: excludeId,
    );
  }

  @override
  ConflictingTestDriveProvider getProviderOverride(
    covariant ConflictingTestDriveProvider provider,
  ) {
    return call(
      carId: provider.carId,
      scheduledAt: provider.scheduledAt,
      durationMinutes: provider.durationMinutes,
      excludeId: provider.excludeId,
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
  String? get name => r'conflictingTestDriveProvider';
}

/// See also [conflictingTestDrive].
class ConflictingTestDriveProvider
    extends AutoDisposeProvider<TestDriveModel?> {
  /// See also [conflictingTestDrive].
  ConflictingTestDriveProvider({
    required String carId,
    required DateTime scheduledAt,
    required int durationMinutes,
    String? excludeId,
  }) : this._internal(
          (ref) => conflictingTestDrive(
            ref as ConflictingTestDriveRef,
            carId: carId,
            scheduledAt: scheduledAt,
            durationMinutes: durationMinutes,
            excludeId: excludeId,
          ),
          from: conflictingTestDriveProvider,
          name: r'conflictingTestDriveProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$conflictingTestDriveHash,
          dependencies: ConflictingTestDriveFamily._dependencies,
          allTransitiveDependencies:
              ConflictingTestDriveFamily._allTransitiveDependencies,
          carId: carId,
          scheduledAt: scheduledAt,
          durationMinutes: durationMinutes,
          excludeId: excludeId,
        );

  ConflictingTestDriveProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.carId,
    required this.scheduledAt,
    required this.durationMinutes,
    required this.excludeId,
  }) : super.internal();

  final String carId;
  final DateTime scheduledAt;
  final int durationMinutes;
  final String? excludeId;

  @override
  Override overrideWith(
    TestDriveModel? Function(ConflictingTestDriveRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ConflictingTestDriveProvider._internal(
        (ref) => create(ref as ConflictingTestDriveRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        carId: carId,
        scheduledAt: scheduledAt,
        durationMinutes: durationMinutes,
        excludeId: excludeId,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<TestDriveModel?> createElement() {
    return _ConflictingTestDriveProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ConflictingTestDriveProvider &&
        other.carId == carId &&
        other.scheduledAt == scheduledAt &&
        other.durationMinutes == durationMinutes &&
        other.excludeId == excludeId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, carId.hashCode);
    hash = _SystemHash.combine(hash, scheduledAt.hashCode);
    hash = _SystemHash.combine(hash, durationMinutes.hashCode);
    hash = _SystemHash.combine(hash, excludeId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ConflictingTestDriveRef on AutoDisposeProviderRef<TestDriveModel?> {
  /// The parameter `carId` of this provider.
  String get carId;

  /// The parameter `scheduledAt` of this provider.
  DateTime get scheduledAt;

  /// The parameter `durationMinutes` of this provider.
  int get durationMinutes;

  /// The parameter `excludeId` of this provider.
  String? get excludeId;
}

class _ConflictingTestDriveProviderElement
    extends AutoDisposeProviderElement<TestDriveModel?>
    with ConflictingTestDriveRef {
  _ConflictingTestDriveProviderElement(super.provider);

  @override
  String get carId => (origin as ConflictingTestDriveProvider).carId;
  @override
  DateTime get scheduledAt =>
      (origin as ConflictingTestDriveProvider).scheduledAt;
  @override
  int get durationMinutes =>
      (origin as ConflictingTestDriveProvider).durationMinutes;
  @override
  String? get excludeId => (origin as ConflictingTestDriveProvider).excludeId;
}

String _$testDriveByIdHash() => r'0b75f2a8ac179c28dc6a081f0058f8a31a65d41d';

/// See also [testDriveById].
@ProviderFor(testDriveById)
const testDriveByIdProvider = TestDriveByIdFamily();

/// See also [testDriveById].
class TestDriveByIdFamily extends Family<TestDriveModel?> {
  /// See also [testDriveById].
  const TestDriveByIdFamily();

  /// See also [testDriveById].
  TestDriveByIdProvider call(
    String id,
  ) {
    return TestDriveByIdProvider(
      id,
    );
  }

  @override
  TestDriveByIdProvider getProviderOverride(
    covariant TestDriveByIdProvider provider,
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
  String? get name => r'testDriveByIdProvider';
}

/// See also [testDriveById].
class TestDriveByIdProvider extends AutoDisposeProvider<TestDriveModel?> {
  /// See also [testDriveById].
  TestDriveByIdProvider(
    String id,
  ) : this._internal(
          (ref) => testDriveById(
            ref as TestDriveByIdRef,
            id,
          ),
          from: testDriveByIdProvider,
          name: r'testDriveByIdProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$testDriveByIdHash,
          dependencies: TestDriveByIdFamily._dependencies,
          allTransitiveDependencies:
              TestDriveByIdFamily._allTransitiveDependencies,
          id: id,
        );

  TestDriveByIdProvider._internal(
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
    TestDriveModel? Function(TestDriveByIdRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: TestDriveByIdProvider._internal(
        (ref) => create(ref as TestDriveByIdRef),
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
  AutoDisposeProviderElement<TestDriveModel?> createElement() {
    return _TestDriveByIdProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TestDriveByIdProvider && other.id == id;
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
mixin TestDriveByIdRef on AutoDisposeProviderRef<TestDriveModel?> {
  /// The parameter `id` of this provider.
  String get id;
}

class _TestDriveByIdProviderElement
    extends AutoDisposeProviderElement<TestDriveModel?> with TestDriveByIdRef {
  _TestDriveByIdProviderElement(super.provider);

  @override
  String get id => (origin as TestDriveByIdProvider).id;
}

String _$testDrivesNotifierHash() =>
    r'1d14fc6c0b7c254949b78216565ec0b6f5e2c398';

/// See also [TestDrivesNotifier].
@ProviderFor(TestDrivesNotifier)
final testDrivesNotifierProvider = AutoDisposeNotifierProvider<
    TestDrivesNotifier, List<TestDriveModel>>.internal(
  TestDrivesNotifier.new,
  name: r'testDrivesNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$testDrivesNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$TestDrivesNotifier = AutoDisposeNotifier<List<TestDriveModel>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
