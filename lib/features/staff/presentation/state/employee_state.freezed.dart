// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'employee_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$StaffState {
  bool get isLoading => throw _privateConstructorUsedError;
  List<EmployeeEntity> get employees => throw _privateConstructorUsedError;
  List<DepartmentEntity> get departments => throw _privateConstructorUsedError;
  EmployeeEntity? get selectedEmployee => throw _privateConstructorUsedError;
  String get searchQuery => throw _privateConstructorUsedError;
  String get selectedDepartment => throw _privateConstructorUsedError;
  String get selectedView =>
      throw _privateConstructorUsedError; // 'departments' or 'employees'
  String? get errorMessage => throw _privateConstructorUsedError;
  AppException? get exception => throw _privateConstructorUsedError;

  /// Create a copy of StaffState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StaffStateCopyWith<StaffState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StaffStateCopyWith<$Res> {
  factory $StaffStateCopyWith(
          StaffState value, $Res Function(StaffState) then) =
      _$StaffStateCopyWithImpl<$Res, StaffState>;
  @useResult
  $Res call(
      {bool isLoading,
      List<EmployeeEntity> employees,
      List<DepartmentEntity> departments,
      EmployeeEntity? selectedEmployee,
      String searchQuery,
      String selectedDepartment,
      String selectedView,
      String? errorMessage,
      AppException? exception});
}

/// @nodoc
class _$StaffStateCopyWithImpl<$Res, $Val extends StaffState>
    implements $StaffStateCopyWith<$Res> {
  _$StaffStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StaffState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? employees = null,
    Object? departments = null,
    Object? selectedEmployee = freezed,
    Object? searchQuery = null,
    Object? selectedDepartment = null,
    Object? selectedView = null,
    Object? errorMessage = freezed,
    Object? exception = freezed,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      employees: null == employees
          ? _value.employees
          : employees // ignore: cast_nullable_to_non_nullable
              as List<EmployeeEntity>,
      departments: null == departments
          ? _value.departments
          : departments // ignore: cast_nullable_to_non_nullable
              as List<DepartmentEntity>,
      selectedEmployee: freezed == selectedEmployee
          ? _value.selectedEmployee
          : selectedEmployee // ignore: cast_nullable_to_non_nullable
              as EmployeeEntity?,
      searchQuery: null == searchQuery
          ? _value.searchQuery
          : searchQuery // ignore: cast_nullable_to_non_nullable
              as String,
      selectedDepartment: null == selectedDepartment
          ? _value.selectedDepartment
          : selectedDepartment // ignore: cast_nullable_to_non_nullable
              as String,
      selectedView: null == selectedView
          ? _value.selectedView
          : selectedView // ignore: cast_nullable_to_non_nullable
              as String,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      exception: freezed == exception
          ? _value.exception
          : exception // ignore: cast_nullable_to_non_nullable
              as AppException?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StaffStateImplCopyWith<$Res>
    implements $StaffStateCopyWith<$Res> {
  factory _$$StaffStateImplCopyWith(
          _$StaffStateImpl value, $Res Function(_$StaffStateImpl) then) =
      __$$StaffStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isLoading,
      List<EmployeeEntity> employees,
      List<DepartmentEntity> departments,
      EmployeeEntity? selectedEmployee,
      String searchQuery,
      String selectedDepartment,
      String selectedView,
      String? errorMessage,
      AppException? exception});
}

/// @nodoc
class __$$StaffStateImplCopyWithImpl<$Res>
    extends _$StaffStateCopyWithImpl<$Res, _$StaffStateImpl>
    implements _$$StaffStateImplCopyWith<$Res> {
  __$$StaffStateImplCopyWithImpl(
      _$StaffStateImpl _value, $Res Function(_$StaffStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of StaffState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? employees = null,
    Object? departments = null,
    Object? selectedEmployee = freezed,
    Object? searchQuery = null,
    Object? selectedDepartment = null,
    Object? selectedView = null,
    Object? errorMessage = freezed,
    Object? exception = freezed,
  }) {
    return _then(_$StaffStateImpl(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      employees: null == employees
          ? _value._employees
          : employees // ignore: cast_nullable_to_non_nullable
              as List<EmployeeEntity>,
      departments: null == departments
          ? _value._departments
          : departments // ignore: cast_nullable_to_non_nullable
              as List<DepartmentEntity>,
      selectedEmployee: freezed == selectedEmployee
          ? _value.selectedEmployee
          : selectedEmployee // ignore: cast_nullable_to_non_nullable
              as EmployeeEntity?,
      searchQuery: null == searchQuery
          ? _value.searchQuery
          : searchQuery // ignore: cast_nullable_to_non_nullable
              as String,
      selectedDepartment: null == selectedDepartment
          ? _value.selectedDepartment
          : selectedDepartment // ignore: cast_nullable_to_non_nullable
              as String,
      selectedView: null == selectedView
          ? _value.selectedView
          : selectedView // ignore: cast_nullable_to_non_nullable
              as String,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      exception: freezed == exception
          ? _value.exception
          : exception // ignore: cast_nullable_to_non_nullable
              as AppException?,
    ));
  }
}

/// @nodoc

class _$StaffStateImpl extends _StaffState {
  const _$StaffStateImpl(
      {this.isLoading = false,
      final List<EmployeeEntity> employees = const [],
      final List<DepartmentEntity> departments = const [],
      this.selectedEmployee,
      this.searchQuery = '',
      this.selectedDepartment = 'all',
      this.selectedView = 'departments',
      this.errorMessage,
      this.exception})
      : _employees = employees,
        _departments = departments,
        super._();

  @override
  @JsonKey()
  final bool isLoading;
  final List<EmployeeEntity> _employees;
  @override
  @JsonKey()
  List<EmployeeEntity> get employees {
    if (_employees is EqualUnmodifiableListView) return _employees;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_employees);
  }

  final List<DepartmentEntity> _departments;
  @override
  @JsonKey()
  List<DepartmentEntity> get departments {
    if (_departments is EqualUnmodifiableListView) return _departments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_departments);
  }

  @override
  final EmployeeEntity? selectedEmployee;
  @override
  @JsonKey()
  final String searchQuery;
  @override
  @JsonKey()
  final String selectedDepartment;
  @override
  @JsonKey()
  final String selectedView;
// 'departments' or 'employees'
  @override
  final String? errorMessage;
  @override
  final AppException? exception;

  @override
  String toString() {
    return 'StaffState(isLoading: $isLoading, employees: $employees, departments: $departments, selectedEmployee: $selectedEmployee, searchQuery: $searchQuery, selectedDepartment: $selectedDepartment, selectedView: $selectedView, errorMessage: $errorMessage, exception: $exception)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StaffStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            const DeepCollectionEquality()
                .equals(other._employees, _employees) &&
            const DeepCollectionEquality()
                .equals(other._departments, _departments) &&
            (identical(other.selectedEmployee, selectedEmployee) ||
                other.selectedEmployee == selectedEmployee) &&
            (identical(other.searchQuery, searchQuery) ||
                other.searchQuery == searchQuery) &&
            (identical(other.selectedDepartment, selectedDepartment) ||
                other.selectedDepartment == selectedDepartment) &&
            (identical(other.selectedView, selectedView) ||
                other.selectedView == selectedView) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.exception, exception) ||
                other.exception == exception));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      isLoading,
      const DeepCollectionEquality().hash(_employees),
      const DeepCollectionEquality().hash(_departments),
      selectedEmployee,
      searchQuery,
      selectedDepartment,
      selectedView,
      errorMessage,
      exception);

  /// Create a copy of StaffState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StaffStateImplCopyWith<_$StaffStateImpl> get copyWith =>
      __$$StaffStateImplCopyWithImpl<_$StaffStateImpl>(this, _$identity);
}

abstract class _StaffState extends StaffState {
  const factory _StaffState(
      {final bool isLoading,
      final List<EmployeeEntity> employees,
      final List<DepartmentEntity> departments,
      final EmployeeEntity? selectedEmployee,
      final String searchQuery,
      final String selectedDepartment,
      final String selectedView,
      final String? errorMessage,
      final AppException? exception}) = _$StaffStateImpl;
  const _StaffState._() : super._();

  @override
  bool get isLoading;
  @override
  List<EmployeeEntity> get employees;
  @override
  List<DepartmentEntity> get departments;
  @override
  EmployeeEntity? get selectedEmployee;
  @override
  String get searchQuery;
  @override
  String get selectedDepartment;
  @override
  String get selectedView; // 'departments' or 'employees'
  @override
  String? get errorMessage;
  @override
  AppException? get exception;

  /// Create a copy of StaffState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StaffStateImplCopyWith<_$StaffStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
