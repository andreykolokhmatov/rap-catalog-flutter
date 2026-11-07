import '../../../../common/network/load_exception.dart';
import '../../../../l10n/app_localizations.dart';

extension LoadExceptionX on LoadException {
  String message(AppLocalizations l10n) => switch (this) {
    ConnectionLoadException() => l10n.errorConnection,
    ServerLoadException(statusCode: 503) => l10n.errorRateLimit,
    ServerLoadException() || NotFoundLoadException() => l10n.errorServer,
  };
}
