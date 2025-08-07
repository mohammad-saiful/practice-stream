class LoadingStateData {
  final bool initial;
  final bool loading;
  final bool success;
  final bool error;

  const LoadingStateData({
     this.initial=true,
     this.loading=false,
     this.success=false,
     this.error=false,
  });
  LoadingStateData copyWith({
    bool? initial,
    bool? loading,
    bool? success,
    bool? error,
  }) {
    return LoadingStateData(
      initial: initial ?? this.initial,
      loading: loading ?? this.loading,
      success: success ?? this.success,
      error: error ?? this.error,
    );
  }
}
