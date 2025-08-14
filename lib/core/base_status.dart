import 'package:freezed_annotation/freezed_annotation.dart';

part 'base_status.freezed.dart';

@freezed
sealed class BaseStatus with _$BaseStatus {
  const BaseStatus._();

  const factory BaseStatus.initial() = _Initial;
  const factory BaseStatus.loading() = _Loading;
  const factory BaseStatus.success() = _Success;
  const factory BaseStatus.error() = _Error;

  bool get isInitial => this is _Initial;
  bool get isLoading => this is _Loading;
  bool get isSuccess => this is _Success;
  bool get isError => this is _Error;
}