# awcoding.com

My portfolio site [unger1984.pro](https://unger1984.pro)

Created with Flutter Web.

## History

[CHANGELOG](./CHANGELOG.md)

## Analyze
```shell
# Поиск неиспользуемого кода
flutter pub run dart_code_metrics:metrics check-unused-code lib
```

## Run

```shell
# Генерация кодегена
flutter pub run build_runner build --delete-conflicting-outputs
# Сборка релизной версии
flutter build web --release
```

