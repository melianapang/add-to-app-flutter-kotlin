import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:developer';
import 'package:dio/dio.dart';

class ViewModel<T extends BaseViewModel> extends ConsumerStatefulWidget {
  const ViewModel({
    required this.model,
    this.onModelReady,
    required this.builder,
    this.child,
    this.onRetry,
    Key? key,
  }) : super(key: key);

  final Widget Function(
    BuildContext context,
    T model,
    Widget? child,
  ) builder;
  final T model;
  final Widget? child;
  final void Function(T)? onModelReady;
  final void Function(T)? onRetry;

  @override
  ConsumerState<ViewModel<T>> createState() => _ViewModelState<T>();
}

class _ViewModelState<T extends BaseViewModel>
    extends ConsumerState<ViewModel<T>> {
  late final _providerRef;
  @override
  void initState() {
    _providerRef = ChangeNotifierProvider<T>(
      (_) => widget.model,
    );
    final T model = widget.model;

    widget.onModelReady?.call(model);

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        return widget.builder(context, ref.watch(_providerRef), widget.child);
      },
    );
  }
}

/// Extends `BaseViewModel` when creating a new view model.
abstract class BaseViewModel extends ChangeNotifier {
  bool _busy = false;
  bool isDisposed = false;

  bool get busy => _busy;

  String errorMessage = '';

  void setBusy(
    bool value, {
    bool skipNotifyListener = false,
  }) {
    _busy = value;
    if (!isDisposed && !skipNotifyListener) {
      notifyListeners();
    }
  }

  void notify() {
    if (!isDisposed) notifyListeners();
  }

  dynamic initModel() {}

  dynamic disposeModel() {}

  bool hasError = false;
  void Function()? toRetry;

  void retry() {
    hasError = false;
    notifyListeners();
    toRetry!();
  }

  void handleError(Function()? toRetryFunc) {
    hasError = true;
    toRetry = toRetryFunc;
  }

  @override
  void dispose() {
    log('Model disposed: $runtimeType');
    isDisposed = true;
    disposeModel();
    super.dispose();
  }

  void mappingDioError(DioException dioError) {
    const String connectionFailedLabel = 'Koneksi sedang bermasalah';
    switch (dioError.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionError:
      case DioExceptionType.sendTimeout:
        errorMessage = 'Koneksi Time Out';
        break;
      case DioExceptionType.cancel:
      case DioExceptionType.unknown:
        errorMessage = connectionFailedLabel;
        break;
      case DioExceptionType.badResponse:

        /// need to mapping error
        errorMessage = connectionFailedLabel;
        break;
      case DioExceptionType.badCertificate:
        errorMessage = 'Bad Certificate';
        break;
    }
  }
}
