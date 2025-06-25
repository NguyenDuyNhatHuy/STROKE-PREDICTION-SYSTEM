// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $UsersTable extends Users with TableInfo<$UsersTable, User> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<int> userId = GeneratedColumn<int>(
    'user_id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'UNIQUE',
  );
  static const VerificationMeta _passwordMeta = const VerificationMeta(
    'password',
  );
  @override
  late final GeneratedColumn<String> password = GeneratedColumn<String>(
    'password',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [userId, name, email, password];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'users';
  @override
  VerificationContext validateIntegrity(
    Insertable<User> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    if (data.containsKey('password')) {
      context.handle(
        _passwordMeta,
        password.isAcceptableOrUnknown(data['password']!, _passwordMeta),
      );
    } else if (isInserting) {
      context.missing(_passwordMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {userId};
  @override
  User map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return User(
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}user_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      )!,
      password: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}password'],
      )!,
    );
  }

  @override
  $UsersTable createAlias(String alias) {
    return $UsersTable(attachedDatabase, alias);
  }
}

class User extends DataClass implements Insertable<User> {
  final int userId;
  final String name;
  final String email;
  final String password;
  const User({
    required this.userId,
    required this.name,
    required this.email,
    required this.password,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['user_id'] = Variable<int>(userId);
    map['name'] = Variable<String>(name);
    map['email'] = Variable<String>(email);
    map['password'] = Variable<String>(password);
    return map;
  }

  UsersCompanion toCompanion(bool nullToAbsent) {
    return UsersCompanion(
      userId: Value(userId),
      name: Value(name),
      email: Value(email),
      password: Value(password),
    );
  }

  factory User.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return User(
      userId: serializer.fromJson<int>(json['userId']),
      name: serializer.fromJson<String>(json['name']),
      email: serializer.fromJson<String>(json['email']),
      password: serializer.fromJson<String>(json['password']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'userId': serializer.toJson<int>(userId),
      'name': serializer.toJson<String>(name),
      'email': serializer.toJson<String>(email),
      'password': serializer.toJson<String>(password),
    };
  }

  User copyWith({int? userId, String? name, String? email, String? password}) =>
      User(
        userId: userId ?? this.userId,
        name: name ?? this.name,
        email: email ?? this.email,
        password: password ?? this.password,
      );
  User copyWithCompanion(UsersCompanion data) {
    return User(
      userId: data.userId.present ? data.userId.value : this.userId,
      name: data.name.present ? data.name.value : this.name,
      email: data.email.present ? data.email.value : this.email,
      password: data.password.present ? data.password.value : this.password,
    );
  }

  @override
  String toString() {
    return (StringBuffer('User(')
          ..write('userId: $userId, ')
          ..write('name: $name, ')
          ..write('email: $email, ')
          ..write('password: $password')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(userId, name, email, password);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is User &&
          other.userId == this.userId &&
          other.name == this.name &&
          other.email == this.email &&
          other.password == this.password);
}

class UsersCompanion extends UpdateCompanion<User> {
  final Value<int> userId;
  final Value<String> name;
  final Value<String> email;
  final Value<String> password;
  const UsersCompanion({
    this.userId = const Value.absent(),
    this.name = const Value.absent(),
    this.email = const Value.absent(),
    this.password = const Value.absent(),
  });
  UsersCompanion.insert({
    this.userId = const Value.absent(),
    required String name,
    required String email,
    required String password,
  }) : name = Value(name),
       email = Value(email),
       password = Value(password);
  static Insertable<User> custom({
    Expression<int>? userId,
    Expression<String>? name,
    Expression<String>? email,
    Expression<String>? password,
  }) {
    return RawValuesInsertable({
      if (userId != null) 'user_id': userId,
      if (name != null) 'name': name,
      if (email != null) 'email': email,
      if (password != null) 'password': password,
    });
  }

  UsersCompanion copyWith({
    Value<int>? userId,
    Value<String>? name,
    Value<String>? email,
    Value<String>? password,
  }) {
    return UsersCompanion(
      userId: userId ?? this.userId,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (userId.present) {
      map['user_id'] = Variable<int>(userId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (password.present) {
      map['password'] = Variable<String>(password.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsersCompanion(')
          ..write('userId: $userId, ')
          ..write('name: $name, ')
          ..write('email: $email, ')
          ..write('password: $password')
          ..write(')'))
        .toString();
  }
}

class $PredictionHistoriesTable extends PredictionHistories
    with TableInfo<$PredictionHistoriesTable, PredictionHistory> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PredictionHistoriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _predictionIdMeta = const VerificationMeta(
    'predictionId',
  );
  @override
  late final GeneratedColumn<int> predictionId = GeneratedColumn<int>(
    'prediction_id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<int> userId = GeneratedColumn<int>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES users (user_id)',
    ),
  );
  static const VerificationMeta _genderMeta = const VerificationMeta('gender');
  @override
  late final GeneratedColumn<String> gender = GeneratedColumn<String>(
    'gender',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ageMeta = const VerificationMeta('age');
  @override
  late final GeneratedColumn<int> age = GeneratedColumn<int>(
    'age',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _hypertensionMeta = const VerificationMeta(
    'hypertension',
  );
  @override
  late final GeneratedColumn<int> hypertension = GeneratedColumn<int>(
    'hypertension',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _heartDiseaseMeta = const VerificationMeta(
    'heartDisease',
  );
  @override
  late final GeneratedColumn<int> heartDisease = GeneratedColumn<int>(
    'heart_disease',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _everMarriedMeta = const VerificationMeta(
    'everMarried',
  );
  @override
  late final GeneratedColumn<String> everMarried = GeneratedColumn<String>(
    'ever_married',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _workTypeMeta = const VerificationMeta(
    'workType',
  );
  @override
  late final GeneratedColumn<String> workType = GeneratedColumn<String>(
    'work_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _residenceTypeMeta = const VerificationMeta(
    'residenceType',
  );
  @override
  late final GeneratedColumn<String> residenceType = GeneratedColumn<String>(
    'residence_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _avgGlucoseLevelMeta = const VerificationMeta(
    'avgGlucoseLevel',
  );
  @override
  late final GeneratedColumn<double> avgGlucoseLevel = GeneratedColumn<double>(
    'avg_glucose_level',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bmiMeta = const VerificationMeta('bmi');
  @override
  late final GeneratedColumn<double> bmi = GeneratedColumn<double>(
    'bmi',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _smokingStatusMeta = const VerificationMeta(
    'smokingStatus',
  );
  @override
  late final GeneratedColumn<String> smokingStatus = GeneratedColumn<String>(
    'smoking_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _strokeMeta = const VerificationMeta('stroke');
  @override
  late final GeneratedColumn<bool> stroke = GeneratedColumn<bool>(
    'stroke',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("stroke" IN (0, 1))',
    ),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    predictionId,
    userId,
    gender,
    age,
    hypertension,
    heartDisease,
    everMarried,
    workType,
    residenceType,
    avgGlucoseLevel,
    bmi,
    smokingStatus,
    stroke,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'prediction_histories';
  @override
  VerificationContext validateIntegrity(
    Insertable<PredictionHistory> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('prediction_id')) {
      context.handle(
        _predictionIdMeta,
        predictionId.isAcceptableOrUnknown(
          data['prediction_id']!,
          _predictionIdMeta,
        ),
      );
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('gender')) {
      context.handle(
        _genderMeta,
        gender.isAcceptableOrUnknown(data['gender']!, _genderMeta),
      );
    } else if (isInserting) {
      context.missing(_genderMeta);
    }
    if (data.containsKey('age')) {
      context.handle(
        _ageMeta,
        age.isAcceptableOrUnknown(data['age']!, _ageMeta),
      );
    } else if (isInserting) {
      context.missing(_ageMeta);
    }
    if (data.containsKey('hypertension')) {
      context.handle(
        _hypertensionMeta,
        hypertension.isAcceptableOrUnknown(
          data['hypertension']!,
          _hypertensionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_hypertensionMeta);
    }
    if (data.containsKey('heart_disease')) {
      context.handle(
        _heartDiseaseMeta,
        heartDisease.isAcceptableOrUnknown(
          data['heart_disease']!,
          _heartDiseaseMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_heartDiseaseMeta);
    }
    if (data.containsKey('ever_married')) {
      context.handle(
        _everMarriedMeta,
        everMarried.isAcceptableOrUnknown(
          data['ever_married']!,
          _everMarriedMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_everMarriedMeta);
    }
    if (data.containsKey('work_type')) {
      context.handle(
        _workTypeMeta,
        workType.isAcceptableOrUnknown(data['work_type']!, _workTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_workTypeMeta);
    }
    if (data.containsKey('residence_type')) {
      context.handle(
        _residenceTypeMeta,
        residenceType.isAcceptableOrUnknown(
          data['residence_type']!,
          _residenceTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_residenceTypeMeta);
    }
    if (data.containsKey('avg_glucose_level')) {
      context.handle(
        _avgGlucoseLevelMeta,
        avgGlucoseLevel.isAcceptableOrUnknown(
          data['avg_glucose_level']!,
          _avgGlucoseLevelMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_avgGlucoseLevelMeta);
    }
    if (data.containsKey('bmi')) {
      context.handle(
        _bmiMeta,
        bmi.isAcceptableOrUnknown(data['bmi']!, _bmiMeta),
      );
    } else if (isInserting) {
      context.missing(_bmiMeta);
    }
    if (data.containsKey('smoking_status')) {
      context.handle(
        _smokingStatusMeta,
        smokingStatus.isAcceptableOrUnknown(
          data['smoking_status']!,
          _smokingStatusMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_smokingStatusMeta);
    }
    if (data.containsKey('stroke')) {
      context.handle(
        _strokeMeta,
        stroke.isAcceptableOrUnknown(data['stroke']!, _strokeMeta),
      );
    } else if (isInserting) {
      context.missing(_strokeMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {predictionId};
  @override
  PredictionHistory map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PredictionHistory(
      predictionId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}prediction_id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}user_id'],
      )!,
      gender: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}gender'],
      )!,
      age: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}age'],
      )!,
      hypertension: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}hypertension'],
      )!,
      heartDisease: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}heart_disease'],
      )!,
      everMarried: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ever_married'],
      )!,
      workType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}work_type'],
      )!,
      residenceType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}residence_type'],
      )!,
      avgGlucoseLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}avg_glucose_level'],
      )!,
      bmi: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}bmi'],
      )!,
      smokingStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}smoking_status'],
      )!,
      stroke: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}stroke'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $PredictionHistoriesTable createAlias(String alias) {
    return $PredictionHistoriesTable(attachedDatabase, alias);
  }
}

class PredictionHistory extends DataClass
    implements Insertable<PredictionHistory> {
  final int predictionId;
  final int userId;
  final String gender;
  final int age;
  final int hypertension;
  final int heartDisease;
  final String everMarried;
  final String workType;
  final String residenceType;
  final double avgGlucoseLevel;
  final double bmi;
  final String smokingStatus;
  final bool stroke;
  final DateTime createdAt;
  const PredictionHistory({
    required this.predictionId,
    required this.userId,
    required this.gender,
    required this.age,
    required this.hypertension,
    required this.heartDisease,
    required this.everMarried,
    required this.workType,
    required this.residenceType,
    required this.avgGlucoseLevel,
    required this.bmi,
    required this.smokingStatus,
    required this.stroke,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['prediction_id'] = Variable<int>(predictionId);
    map['user_id'] = Variable<int>(userId);
    map['gender'] = Variable<String>(gender);
    map['age'] = Variable<int>(age);
    map['hypertension'] = Variable<int>(hypertension);
    map['heart_disease'] = Variable<int>(heartDisease);
    map['ever_married'] = Variable<String>(everMarried);
    map['work_type'] = Variable<String>(workType);
    map['residence_type'] = Variable<String>(residenceType);
    map['avg_glucose_level'] = Variable<double>(avgGlucoseLevel);
    map['bmi'] = Variable<double>(bmi);
    map['smoking_status'] = Variable<String>(smokingStatus);
    map['stroke'] = Variable<bool>(stroke);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  PredictionHistoriesCompanion toCompanion(bool nullToAbsent) {
    return PredictionHistoriesCompanion(
      predictionId: Value(predictionId),
      userId: Value(userId),
      gender: Value(gender),
      age: Value(age),
      hypertension: Value(hypertension),
      heartDisease: Value(heartDisease),
      everMarried: Value(everMarried),
      workType: Value(workType),
      residenceType: Value(residenceType),
      avgGlucoseLevel: Value(avgGlucoseLevel),
      bmi: Value(bmi),
      smokingStatus: Value(smokingStatus),
      stroke: Value(stroke),
      createdAt: Value(createdAt),
    );
  }

  factory PredictionHistory.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PredictionHistory(
      predictionId: serializer.fromJson<int>(json['predictionId']),
      userId: serializer.fromJson<int>(json['userId']),
      gender: serializer.fromJson<String>(json['gender']),
      age: serializer.fromJson<int>(json['age']),
      hypertension: serializer.fromJson<int>(json['hypertension']),
      heartDisease: serializer.fromJson<int>(json['heartDisease']),
      everMarried: serializer.fromJson<String>(json['everMarried']),
      workType: serializer.fromJson<String>(json['workType']),
      residenceType: serializer.fromJson<String>(json['residenceType']),
      avgGlucoseLevel: serializer.fromJson<double>(json['avgGlucoseLevel']),
      bmi: serializer.fromJson<double>(json['bmi']),
      smokingStatus: serializer.fromJson<String>(json['smokingStatus']),
      stroke: serializer.fromJson<bool>(json['stroke']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'predictionId': serializer.toJson<int>(predictionId),
      'userId': serializer.toJson<int>(userId),
      'gender': serializer.toJson<String>(gender),
      'age': serializer.toJson<int>(age),
      'hypertension': serializer.toJson<int>(hypertension),
      'heartDisease': serializer.toJson<int>(heartDisease),
      'everMarried': serializer.toJson<String>(everMarried),
      'workType': serializer.toJson<String>(workType),
      'residenceType': serializer.toJson<String>(residenceType),
      'avgGlucoseLevel': serializer.toJson<double>(avgGlucoseLevel),
      'bmi': serializer.toJson<double>(bmi),
      'smokingStatus': serializer.toJson<String>(smokingStatus),
      'stroke': serializer.toJson<bool>(stroke),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  PredictionHistory copyWith({
    int? predictionId,
    int? userId,
    String? gender,
    int? age,
    int? hypertension,
    int? heartDisease,
    String? everMarried,
    String? workType,
    String? residenceType,
    double? avgGlucoseLevel,
    double? bmi,
    String? smokingStatus,
    bool? stroke,
    DateTime? createdAt,
  }) => PredictionHistory(
    predictionId: predictionId ?? this.predictionId,
    userId: userId ?? this.userId,
    gender: gender ?? this.gender,
    age: age ?? this.age,
    hypertension: hypertension ?? this.hypertension,
    heartDisease: heartDisease ?? this.heartDisease,
    everMarried: everMarried ?? this.everMarried,
    workType: workType ?? this.workType,
    residenceType: residenceType ?? this.residenceType,
    avgGlucoseLevel: avgGlucoseLevel ?? this.avgGlucoseLevel,
    bmi: bmi ?? this.bmi,
    smokingStatus: smokingStatus ?? this.smokingStatus,
    stroke: stroke ?? this.stroke,
    createdAt: createdAt ?? this.createdAt,
  );
  PredictionHistory copyWithCompanion(PredictionHistoriesCompanion data) {
    return PredictionHistory(
      predictionId: data.predictionId.present
          ? data.predictionId.value
          : this.predictionId,
      userId: data.userId.present ? data.userId.value : this.userId,
      gender: data.gender.present ? data.gender.value : this.gender,
      age: data.age.present ? data.age.value : this.age,
      hypertension: data.hypertension.present
          ? data.hypertension.value
          : this.hypertension,
      heartDisease: data.heartDisease.present
          ? data.heartDisease.value
          : this.heartDisease,
      everMarried: data.everMarried.present
          ? data.everMarried.value
          : this.everMarried,
      workType: data.workType.present ? data.workType.value : this.workType,
      residenceType: data.residenceType.present
          ? data.residenceType.value
          : this.residenceType,
      avgGlucoseLevel: data.avgGlucoseLevel.present
          ? data.avgGlucoseLevel.value
          : this.avgGlucoseLevel,
      bmi: data.bmi.present ? data.bmi.value : this.bmi,
      smokingStatus: data.smokingStatus.present
          ? data.smokingStatus.value
          : this.smokingStatus,
      stroke: data.stroke.present ? data.stroke.value : this.stroke,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PredictionHistory(')
          ..write('predictionId: $predictionId, ')
          ..write('userId: $userId, ')
          ..write('gender: $gender, ')
          ..write('age: $age, ')
          ..write('hypertension: $hypertension, ')
          ..write('heartDisease: $heartDisease, ')
          ..write('everMarried: $everMarried, ')
          ..write('workType: $workType, ')
          ..write('residenceType: $residenceType, ')
          ..write('avgGlucoseLevel: $avgGlucoseLevel, ')
          ..write('bmi: $bmi, ')
          ..write('smokingStatus: $smokingStatus, ')
          ..write('stroke: $stroke, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    predictionId,
    userId,
    gender,
    age,
    hypertension,
    heartDisease,
    everMarried,
    workType,
    residenceType,
    avgGlucoseLevel,
    bmi,
    smokingStatus,
    stroke,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PredictionHistory &&
          other.predictionId == this.predictionId &&
          other.userId == this.userId &&
          other.gender == this.gender &&
          other.age == this.age &&
          other.hypertension == this.hypertension &&
          other.heartDisease == this.heartDisease &&
          other.everMarried == this.everMarried &&
          other.workType == this.workType &&
          other.residenceType == this.residenceType &&
          other.avgGlucoseLevel == this.avgGlucoseLevel &&
          other.bmi == this.bmi &&
          other.smokingStatus == this.smokingStatus &&
          other.stroke == this.stroke &&
          other.createdAt == this.createdAt);
}

class PredictionHistoriesCompanion extends UpdateCompanion<PredictionHistory> {
  final Value<int> predictionId;
  final Value<int> userId;
  final Value<String> gender;
  final Value<int> age;
  final Value<int> hypertension;
  final Value<int> heartDisease;
  final Value<String> everMarried;
  final Value<String> workType;
  final Value<String> residenceType;
  final Value<double> avgGlucoseLevel;
  final Value<double> bmi;
  final Value<String> smokingStatus;
  final Value<bool> stroke;
  final Value<DateTime> createdAt;
  const PredictionHistoriesCompanion({
    this.predictionId = const Value.absent(),
    this.userId = const Value.absent(),
    this.gender = const Value.absent(),
    this.age = const Value.absent(),
    this.hypertension = const Value.absent(),
    this.heartDisease = const Value.absent(),
    this.everMarried = const Value.absent(),
    this.workType = const Value.absent(),
    this.residenceType = const Value.absent(),
    this.avgGlucoseLevel = const Value.absent(),
    this.bmi = const Value.absent(),
    this.smokingStatus = const Value.absent(),
    this.stroke = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  PredictionHistoriesCompanion.insert({
    this.predictionId = const Value.absent(),
    required int userId,
    required String gender,
    required int age,
    required int hypertension,
    required int heartDisease,
    required String everMarried,
    required String workType,
    required String residenceType,
    required double avgGlucoseLevel,
    required double bmi,
    required String smokingStatus,
    required bool stroke,
    this.createdAt = const Value.absent(),
  }) : userId = Value(userId),
       gender = Value(gender),
       age = Value(age),
       hypertension = Value(hypertension),
       heartDisease = Value(heartDisease),
       everMarried = Value(everMarried),
       workType = Value(workType),
       residenceType = Value(residenceType),
       avgGlucoseLevel = Value(avgGlucoseLevel),
       bmi = Value(bmi),
       smokingStatus = Value(smokingStatus),
       stroke = Value(stroke);
  static Insertable<PredictionHistory> custom({
    Expression<int>? predictionId,
    Expression<int>? userId,
    Expression<String>? gender,
    Expression<int>? age,
    Expression<int>? hypertension,
    Expression<int>? heartDisease,
    Expression<String>? everMarried,
    Expression<String>? workType,
    Expression<String>? residenceType,
    Expression<double>? avgGlucoseLevel,
    Expression<double>? bmi,
    Expression<String>? smokingStatus,
    Expression<bool>? stroke,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (predictionId != null) 'prediction_id': predictionId,
      if (userId != null) 'user_id': userId,
      if (gender != null) 'gender': gender,
      if (age != null) 'age': age,
      if (hypertension != null) 'hypertension': hypertension,
      if (heartDisease != null) 'heart_disease': heartDisease,
      if (everMarried != null) 'ever_married': everMarried,
      if (workType != null) 'work_type': workType,
      if (residenceType != null) 'residence_type': residenceType,
      if (avgGlucoseLevel != null) 'avg_glucose_level': avgGlucoseLevel,
      if (bmi != null) 'bmi': bmi,
      if (smokingStatus != null) 'smoking_status': smokingStatus,
      if (stroke != null) 'stroke': stroke,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  PredictionHistoriesCompanion copyWith({
    Value<int>? predictionId,
    Value<int>? userId,
    Value<String>? gender,
    Value<int>? age,
    Value<int>? hypertension,
    Value<int>? heartDisease,
    Value<String>? everMarried,
    Value<String>? workType,
    Value<String>? residenceType,
    Value<double>? avgGlucoseLevel,
    Value<double>? bmi,
    Value<String>? smokingStatus,
    Value<bool>? stroke,
    Value<DateTime>? createdAt,
  }) {
    return PredictionHistoriesCompanion(
      predictionId: predictionId ?? this.predictionId,
      userId: userId ?? this.userId,
      gender: gender ?? this.gender,
      age: age ?? this.age,
      hypertension: hypertension ?? this.hypertension,
      heartDisease: heartDisease ?? this.heartDisease,
      everMarried: everMarried ?? this.everMarried,
      workType: workType ?? this.workType,
      residenceType: residenceType ?? this.residenceType,
      avgGlucoseLevel: avgGlucoseLevel ?? this.avgGlucoseLevel,
      bmi: bmi ?? this.bmi,
      smokingStatus: smokingStatus ?? this.smokingStatus,
      stroke: stroke ?? this.stroke,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (predictionId.present) {
      map['prediction_id'] = Variable<int>(predictionId.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<int>(userId.value);
    }
    if (gender.present) {
      map['gender'] = Variable<String>(gender.value);
    }
    if (age.present) {
      map['age'] = Variable<int>(age.value);
    }
    if (hypertension.present) {
      map['hypertension'] = Variable<int>(hypertension.value);
    }
    if (heartDisease.present) {
      map['heart_disease'] = Variable<int>(heartDisease.value);
    }
    if (everMarried.present) {
      map['ever_married'] = Variable<String>(everMarried.value);
    }
    if (workType.present) {
      map['work_type'] = Variable<String>(workType.value);
    }
    if (residenceType.present) {
      map['residence_type'] = Variable<String>(residenceType.value);
    }
    if (avgGlucoseLevel.present) {
      map['avg_glucose_level'] = Variable<double>(avgGlucoseLevel.value);
    }
    if (bmi.present) {
      map['bmi'] = Variable<double>(bmi.value);
    }
    if (smokingStatus.present) {
      map['smoking_status'] = Variable<String>(smokingStatus.value);
    }
    if (stroke.present) {
      map['stroke'] = Variable<bool>(stroke.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PredictionHistoriesCompanion(')
          ..write('predictionId: $predictionId, ')
          ..write('userId: $userId, ')
          ..write('gender: $gender, ')
          ..write('age: $age, ')
          ..write('hypertension: $hypertension, ')
          ..write('heartDisease: $heartDisease, ')
          ..write('everMarried: $everMarried, ')
          ..write('workType: $workType, ')
          ..write('residenceType: $residenceType, ')
          ..write('avgGlucoseLevel: $avgGlucoseLevel, ')
          ..write('bmi: $bmi, ')
          ..write('smokingStatus: $smokingStatus, ')
          ..write('stroke: $stroke, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $HospitalsTable extends Hospitals
    with TableInfo<$HospitalsTable, Hospital> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HospitalsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _addressMeta = const VerificationMeta(
    'address',
  );
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
    'address',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _latitudeMeta = const VerificationMeta(
    'latitude',
  );
  @override
  late final GeneratedColumn<double> latitude = GeneratedColumn<double>(
    'latitude',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _longitudeMeta = const VerificationMeta(
    'longitude',
  );
  @override
  late final GeneratedColumn<double> longitude = GeneratedColumn<double>(
    'longitude',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    address,
    latitude,
    longitude,
    phone,
    type,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'hospitals';
  @override
  VerificationContext validateIntegrity(
    Insertable<Hospital> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('address')) {
      context.handle(
        _addressMeta,
        address.isAcceptableOrUnknown(data['address']!, _addressMeta),
      );
    } else if (isInserting) {
      context.missing(_addressMeta);
    }
    if (data.containsKey('latitude')) {
      context.handle(
        _latitudeMeta,
        latitude.isAcceptableOrUnknown(data['latitude']!, _latitudeMeta),
      );
    } else if (isInserting) {
      context.missing(_latitudeMeta);
    }
    if (data.containsKey('longitude')) {
      context.handle(
        _longitudeMeta,
        longitude.isAcceptableOrUnknown(data['longitude']!, _longitudeMeta),
      );
    } else if (isInserting) {
      context.missing(_longitudeMeta);
    }
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    } else if (isInserting) {
      context.missing(_phoneMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Hospital map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Hospital(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      address: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}address'],
      )!,
      latitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}latitude'],
      )!,
      longitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}longitude'],
      )!,
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
    );
  }

  @override
  $HospitalsTable createAlias(String alias) {
    return $HospitalsTable(attachedDatabase, alias);
  }
}

class Hospital extends DataClass implements Insertable<Hospital> {
  final int id;
  final String name;
  final String address;
  final double latitude;
  final double longitude;
  final String phone;
  final String type;
  const Hospital({
    required this.id,
    required this.name,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.phone,
    required this.type,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['address'] = Variable<String>(address);
    map['latitude'] = Variable<double>(latitude);
    map['longitude'] = Variable<double>(longitude);
    map['phone'] = Variable<String>(phone);
    map['type'] = Variable<String>(type);
    return map;
  }

  HospitalsCompanion toCompanion(bool nullToAbsent) {
    return HospitalsCompanion(
      id: Value(id),
      name: Value(name),
      address: Value(address),
      latitude: Value(latitude),
      longitude: Value(longitude),
      phone: Value(phone),
      type: Value(type),
    );
  }

  factory Hospital.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Hospital(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      address: serializer.fromJson<String>(json['address']),
      latitude: serializer.fromJson<double>(json['latitude']),
      longitude: serializer.fromJson<double>(json['longitude']),
      phone: serializer.fromJson<String>(json['phone']),
      type: serializer.fromJson<String>(json['type']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'address': serializer.toJson<String>(address),
      'latitude': serializer.toJson<double>(latitude),
      'longitude': serializer.toJson<double>(longitude),
      'phone': serializer.toJson<String>(phone),
      'type': serializer.toJson<String>(type),
    };
  }

  Hospital copyWith({
    int? id,
    String? name,
    String? address,
    double? latitude,
    double? longitude,
    String? phone,
    String? type,
  }) => Hospital(
    id: id ?? this.id,
    name: name ?? this.name,
    address: address ?? this.address,
    latitude: latitude ?? this.latitude,
    longitude: longitude ?? this.longitude,
    phone: phone ?? this.phone,
    type: type ?? this.type,
  );
  Hospital copyWithCompanion(HospitalsCompanion data) {
    return Hospital(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      address: data.address.present ? data.address.value : this.address,
      latitude: data.latitude.present ? data.latitude.value : this.latitude,
      longitude: data.longitude.present ? data.longitude.value : this.longitude,
      phone: data.phone.present ? data.phone.value : this.phone,
      type: data.type.present ? data.type.value : this.type,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Hospital(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('address: $address, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('phone: $phone, ')
          ..write('type: $type')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, address, latitude, longitude, phone, type);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Hospital &&
          other.id == this.id &&
          other.name == this.name &&
          other.address == this.address &&
          other.latitude == this.latitude &&
          other.longitude == this.longitude &&
          other.phone == this.phone &&
          other.type == this.type);
}

class HospitalsCompanion extends UpdateCompanion<Hospital> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> address;
  final Value<double> latitude;
  final Value<double> longitude;
  final Value<String> phone;
  final Value<String> type;
  const HospitalsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.address = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.phone = const Value.absent(),
    this.type = const Value.absent(),
  });
  HospitalsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String address,
    required double latitude,
    required double longitude,
    required String phone,
    required String type,
  }) : name = Value(name),
       address = Value(address),
       latitude = Value(latitude),
       longitude = Value(longitude),
       phone = Value(phone),
       type = Value(type);
  static Insertable<Hospital> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? address,
    Expression<double>? latitude,
    Expression<double>? longitude,
    Expression<String>? phone,
    Expression<String>? type,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (address != null) 'address': address,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      if (phone != null) 'phone': phone,
      if (type != null) 'type': type,
    });
  }

  HospitalsCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? address,
    Value<double>? latitude,
    Value<double>? longitude,
    Value<String>? phone,
    Value<String>? type,
  }) {
    return HospitalsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      phone: phone ?? this.phone,
      type: type ?? this.type,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (latitude.present) {
      map['latitude'] = Variable<double>(latitude.value);
    }
    if (longitude.present) {
      map['longitude'] = Variable<double>(longitude.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HospitalsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('address: $address, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('phone: $phone, ')
          ..write('type: $type')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $UsersTable users = $UsersTable(this);
  late final $PredictionHistoriesTable predictionHistories =
      $PredictionHistoriesTable(this);
  late final $HospitalsTable hospitals = $HospitalsTable(this);
  late final UserDao userDao = UserDao(this as AppDatabase);
  late final PredictionDao predictionDao = PredictionDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    users,
    predictionHistories,
    hospitals,
  ];
}

typedef $$UsersTableCreateCompanionBuilder =
    UsersCompanion Function({
      Value<int> userId,
      required String name,
      required String email,
      required String password,
    });
typedef $$UsersTableUpdateCompanionBuilder =
    UsersCompanion Function({
      Value<int> userId,
      Value<String> name,
      Value<String> email,
      Value<String> password,
    });

final class $$UsersTableReferences
    extends BaseReferences<_$AppDatabase, $UsersTable, User> {
  $$UsersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$PredictionHistoriesTable, List<PredictionHistory>>
  _predictionHistoriesRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.predictionHistories,
        aliasName: $_aliasNameGenerator(
          db.users.userId,
          db.predictionHistories.userId,
        ),
      );

  $$PredictionHistoriesTableProcessedTableManager get predictionHistoriesRefs {
    final manager = $$PredictionHistoriesTableTableManager(
      $_db,
      $_db.predictionHistories,
    ).filter((f) => f.userId.userId.sqlEquals($_itemColumn<int>('user_id')!));

    final cache = $_typedResult.readTableOrNull(
      _predictionHistoriesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$UsersTableFilterComposer extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get password => $composableBuilder(
    column: $table.password,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> predictionHistoriesRefs(
    Expression<bool> Function($$PredictionHistoriesTableFilterComposer f) f,
  ) {
    final $$PredictionHistoriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.predictionHistories,
      getReferencedColumn: (t) => t.userId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PredictionHistoriesTableFilterComposer(
            $db: $db,
            $table: $db.predictionHistories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$UsersTableOrderingComposer
    extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get password => $composableBuilder(
    column: $table.password,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UsersTableAnnotationComposer
    extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get password =>
      $composableBuilder(column: $table.password, builder: (column) => column);

  Expression<T> predictionHistoriesRefs<T extends Object>(
    Expression<T> Function($$PredictionHistoriesTableAnnotationComposer a) f,
  ) {
    final $$PredictionHistoriesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.userId,
          referencedTable: $db.predictionHistories,
          getReferencedColumn: (t) => t.userId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$PredictionHistoriesTableAnnotationComposer(
                $db: $db,
                $table: $db.predictionHistories,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$UsersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UsersTable,
          User,
          $$UsersTableFilterComposer,
          $$UsersTableOrderingComposer,
          $$UsersTableAnnotationComposer,
          $$UsersTableCreateCompanionBuilder,
          $$UsersTableUpdateCompanionBuilder,
          (User, $$UsersTableReferences),
          User,
          PrefetchHooks Function({bool predictionHistoriesRefs})
        > {
  $$UsersTableTableManager(_$AppDatabase db, $UsersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UsersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UsersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UsersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> userId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> email = const Value.absent(),
                Value<String> password = const Value.absent(),
              }) => UsersCompanion(
                userId: userId,
                name: name,
                email: email,
                password: password,
              ),
          createCompanionCallback:
              ({
                Value<int> userId = const Value.absent(),
                required String name,
                required String email,
                required String password,
              }) => UsersCompanion.insert(
                userId: userId,
                name: name,
                email: email,
                password: password,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$UsersTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({predictionHistoriesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (predictionHistoriesRefs) db.predictionHistories,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (predictionHistoriesRefs)
                    await $_getPrefetchedData<
                      User,
                      $UsersTable,
                      PredictionHistory
                    >(
                      currentTable: table,
                      referencedTable: $$UsersTableReferences
                          ._predictionHistoriesRefsTable(db),
                      managerFromTypedResult: (p0) => $$UsersTableReferences(
                        db,
                        table,
                        p0,
                      ).predictionHistoriesRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.userId == item.userId),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$UsersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UsersTable,
      User,
      $$UsersTableFilterComposer,
      $$UsersTableOrderingComposer,
      $$UsersTableAnnotationComposer,
      $$UsersTableCreateCompanionBuilder,
      $$UsersTableUpdateCompanionBuilder,
      (User, $$UsersTableReferences),
      User,
      PrefetchHooks Function({bool predictionHistoriesRefs})
    >;
typedef $$PredictionHistoriesTableCreateCompanionBuilder =
    PredictionHistoriesCompanion Function({
      Value<int> predictionId,
      required int userId,
      required String gender,
      required int age,
      required int hypertension,
      required int heartDisease,
      required String everMarried,
      required String workType,
      required String residenceType,
      required double avgGlucoseLevel,
      required double bmi,
      required String smokingStatus,
      required bool stroke,
      Value<DateTime> createdAt,
    });
typedef $$PredictionHistoriesTableUpdateCompanionBuilder =
    PredictionHistoriesCompanion Function({
      Value<int> predictionId,
      Value<int> userId,
      Value<String> gender,
      Value<int> age,
      Value<int> hypertension,
      Value<int> heartDisease,
      Value<String> everMarried,
      Value<String> workType,
      Value<String> residenceType,
      Value<double> avgGlucoseLevel,
      Value<double> bmi,
      Value<String> smokingStatus,
      Value<bool> stroke,
      Value<DateTime> createdAt,
    });

final class $$PredictionHistoriesTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $PredictionHistoriesTable,
          PredictionHistory
        > {
  $$PredictionHistoriesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $UsersTable _userIdTable(_$AppDatabase db) => db.users.createAlias(
    $_aliasNameGenerator(db.predictionHistories.userId, db.users.userId),
  );

  $$UsersTableProcessedTableManager get userId {
    final $_column = $_itemColumn<int>('user_id')!;

    final manager = $$UsersTableTableManager(
      $_db,
      $_db.users,
    ).filter((f) => f.userId.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_userIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PredictionHistoriesTableFilterComposer
    extends Composer<_$AppDatabase, $PredictionHistoriesTable> {
  $$PredictionHistoriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get predictionId => $composableBuilder(
    column: $table.predictionId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get gender => $composableBuilder(
    column: $table.gender,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get age => $composableBuilder(
    column: $table.age,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get hypertension => $composableBuilder(
    column: $table.hypertension,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get heartDisease => $composableBuilder(
    column: $table.heartDisease,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get everMarried => $composableBuilder(
    column: $table.everMarried,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get workType => $composableBuilder(
    column: $table.workType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get residenceType => $composableBuilder(
    column: $table.residenceType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get avgGlucoseLevel => $composableBuilder(
    column: $table.avgGlucoseLevel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get bmi => $composableBuilder(
    column: $table.bmi,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get smokingStatus => $composableBuilder(
    column: $table.smokingStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get stroke => $composableBuilder(
    column: $table.stroke,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$UsersTableFilterComposer get userId {
    final $$UsersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.userId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableFilterComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PredictionHistoriesTableOrderingComposer
    extends Composer<_$AppDatabase, $PredictionHistoriesTable> {
  $$PredictionHistoriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get predictionId => $composableBuilder(
    column: $table.predictionId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get gender => $composableBuilder(
    column: $table.gender,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get age => $composableBuilder(
    column: $table.age,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get hypertension => $composableBuilder(
    column: $table.hypertension,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get heartDisease => $composableBuilder(
    column: $table.heartDisease,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get everMarried => $composableBuilder(
    column: $table.everMarried,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get workType => $composableBuilder(
    column: $table.workType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get residenceType => $composableBuilder(
    column: $table.residenceType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get avgGlucoseLevel => $composableBuilder(
    column: $table.avgGlucoseLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get bmi => $composableBuilder(
    column: $table.bmi,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get smokingStatus => $composableBuilder(
    column: $table.smokingStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get stroke => $composableBuilder(
    column: $table.stroke,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$UsersTableOrderingComposer get userId {
    final $$UsersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.userId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableOrderingComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PredictionHistoriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $PredictionHistoriesTable> {
  $$PredictionHistoriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get predictionId => $composableBuilder(
    column: $table.predictionId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get gender =>
      $composableBuilder(column: $table.gender, builder: (column) => column);

  GeneratedColumn<int> get age =>
      $composableBuilder(column: $table.age, builder: (column) => column);

  GeneratedColumn<int> get hypertension => $composableBuilder(
    column: $table.hypertension,
    builder: (column) => column,
  );

  GeneratedColumn<int> get heartDisease => $composableBuilder(
    column: $table.heartDisease,
    builder: (column) => column,
  );

  GeneratedColumn<String> get everMarried => $composableBuilder(
    column: $table.everMarried,
    builder: (column) => column,
  );

  GeneratedColumn<String> get workType =>
      $composableBuilder(column: $table.workType, builder: (column) => column);

  GeneratedColumn<String> get residenceType => $composableBuilder(
    column: $table.residenceType,
    builder: (column) => column,
  );

  GeneratedColumn<double> get avgGlucoseLevel => $composableBuilder(
    column: $table.avgGlucoseLevel,
    builder: (column) => column,
  );

  GeneratedColumn<double> get bmi =>
      $composableBuilder(column: $table.bmi, builder: (column) => column);

  GeneratedColumn<String> get smokingStatus => $composableBuilder(
    column: $table.smokingStatus,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get stroke =>
      $composableBuilder(column: $table.stroke, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$UsersTableAnnotationComposer get userId {
    final $$UsersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.userId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableAnnotationComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PredictionHistoriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PredictionHistoriesTable,
          PredictionHistory,
          $$PredictionHistoriesTableFilterComposer,
          $$PredictionHistoriesTableOrderingComposer,
          $$PredictionHistoriesTableAnnotationComposer,
          $$PredictionHistoriesTableCreateCompanionBuilder,
          $$PredictionHistoriesTableUpdateCompanionBuilder,
          (PredictionHistory, $$PredictionHistoriesTableReferences),
          PredictionHistory,
          PrefetchHooks Function({bool userId})
        > {
  $$PredictionHistoriesTableTableManager(
    _$AppDatabase db,
    $PredictionHistoriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PredictionHistoriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PredictionHistoriesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$PredictionHistoriesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> predictionId = const Value.absent(),
                Value<int> userId = const Value.absent(),
                Value<String> gender = const Value.absent(),
                Value<int> age = const Value.absent(),
                Value<int> hypertension = const Value.absent(),
                Value<int> heartDisease = const Value.absent(),
                Value<String> everMarried = const Value.absent(),
                Value<String> workType = const Value.absent(),
                Value<String> residenceType = const Value.absent(),
                Value<double> avgGlucoseLevel = const Value.absent(),
                Value<double> bmi = const Value.absent(),
                Value<String> smokingStatus = const Value.absent(),
                Value<bool> stroke = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => PredictionHistoriesCompanion(
                predictionId: predictionId,
                userId: userId,
                gender: gender,
                age: age,
                hypertension: hypertension,
                heartDisease: heartDisease,
                everMarried: everMarried,
                workType: workType,
                residenceType: residenceType,
                avgGlucoseLevel: avgGlucoseLevel,
                bmi: bmi,
                smokingStatus: smokingStatus,
                stroke: stroke,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> predictionId = const Value.absent(),
                required int userId,
                required String gender,
                required int age,
                required int hypertension,
                required int heartDisease,
                required String everMarried,
                required String workType,
                required String residenceType,
                required double avgGlucoseLevel,
                required double bmi,
                required String smokingStatus,
                required bool stroke,
                Value<DateTime> createdAt = const Value.absent(),
              }) => PredictionHistoriesCompanion.insert(
                predictionId: predictionId,
                userId: userId,
                gender: gender,
                age: age,
                hypertension: hypertension,
                heartDisease: heartDisease,
                everMarried: everMarried,
                workType: workType,
                residenceType: residenceType,
                avgGlucoseLevel: avgGlucoseLevel,
                bmi: bmi,
                smokingStatus: smokingStatus,
                stroke: stroke,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PredictionHistoriesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({userId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (userId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.userId,
                                referencedTable:
                                    $$PredictionHistoriesTableReferences
                                        ._userIdTable(db),
                                referencedColumn:
                                    $$PredictionHistoriesTableReferences
                                        ._userIdTable(db)
                                        .userId,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$PredictionHistoriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PredictionHistoriesTable,
      PredictionHistory,
      $$PredictionHistoriesTableFilterComposer,
      $$PredictionHistoriesTableOrderingComposer,
      $$PredictionHistoriesTableAnnotationComposer,
      $$PredictionHistoriesTableCreateCompanionBuilder,
      $$PredictionHistoriesTableUpdateCompanionBuilder,
      (PredictionHistory, $$PredictionHistoriesTableReferences),
      PredictionHistory,
      PrefetchHooks Function({bool userId})
    >;
typedef $$HospitalsTableCreateCompanionBuilder =
    HospitalsCompanion Function({
      Value<int> id,
      required String name,
      required String address,
      required double latitude,
      required double longitude,
      required String phone,
      required String type,
    });
typedef $$HospitalsTableUpdateCompanionBuilder =
    HospitalsCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> address,
      Value<double> latitude,
      Value<double> longitude,
      Value<String> phone,
      Value<String> type,
    });

class $$HospitalsTableFilterComposer
    extends Composer<_$AppDatabase, $HospitalsTable> {
  $$HospitalsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );
}

class $$HospitalsTableOrderingComposer
    extends Composer<_$AppDatabase, $HospitalsTable> {
  $$HospitalsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$HospitalsTableAnnotationComposer
    extends Composer<_$AppDatabase, $HospitalsTable> {
  $$HospitalsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumn<double> get latitude =>
      $composableBuilder(column: $table.latitude, builder: (column) => column);

  GeneratedColumn<double> get longitude =>
      $composableBuilder(column: $table.longitude, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);
}

class $$HospitalsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $HospitalsTable,
          Hospital,
          $$HospitalsTableFilterComposer,
          $$HospitalsTableOrderingComposer,
          $$HospitalsTableAnnotationComposer,
          $$HospitalsTableCreateCompanionBuilder,
          $$HospitalsTableUpdateCompanionBuilder,
          (Hospital, BaseReferences<_$AppDatabase, $HospitalsTable, Hospital>),
          Hospital,
          PrefetchHooks Function()
        > {
  $$HospitalsTableTableManager(_$AppDatabase db, $HospitalsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HospitalsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HospitalsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$HospitalsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> address = const Value.absent(),
                Value<double> latitude = const Value.absent(),
                Value<double> longitude = const Value.absent(),
                Value<String> phone = const Value.absent(),
                Value<String> type = const Value.absent(),
              }) => HospitalsCompanion(
                id: id,
                name: name,
                address: address,
                latitude: latitude,
                longitude: longitude,
                phone: phone,
                type: type,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String address,
                required double latitude,
                required double longitude,
                required String phone,
                required String type,
              }) => HospitalsCompanion.insert(
                id: id,
                name: name,
                address: address,
                latitude: latitude,
                longitude: longitude,
                phone: phone,
                type: type,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$HospitalsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $HospitalsTable,
      Hospital,
      $$HospitalsTableFilterComposer,
      $$HospitalsTableOrderingComposer,
      $$HospitalsTableAnnotationComposer,
      $$HospitalsTableCreateCompanionBuilder,
      $$HospitalsTableUpdateCompanionBuilder,
      (Hospital, BaseReferences<_$AppDatabase, $HospitalsTable, Hospital>),
      Hospital,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$UsersTableTableManager get users =>
      $$UsersTableTableManager(_db, _db.users);
  $$PredictionHistoriesTableTableManager get predictionHistories =>
      $$PredictionHistoriesTableTableManager(_db, _db.predictionHistories);
  $$HospitalsTableTableManager get hospitals =>
      $$HospitalsTableTableManager(_db, _db.hospitals);
}
