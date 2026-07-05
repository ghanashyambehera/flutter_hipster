/// Application configuration sourced exclusively from `--dart-define` values.
///
/// Secrets (API key) and environment (base URL) are never hardcoded in tracked
/// source beyond convenience defaults that are meant to be overridden at build
/// time. See README for the run/build commands.
class AppConfig {
  const AppConfig({
    required this.apiBaseUrl,
    required this.apiKey,
    required this.useFakeRtc,
  });

  final String apiBaseUrl;
  final String apiKey;

  /// When true, an in-memory [RtcClient] is used instead of the native Chime
  /// bridge, enabling the full flow to be demoed/tested without the SDK.
  final bool useFakeRtc;

  factory AppConfig.fromEnvironment() {
    return const AppConfig(
      apiBaseUrl: String.fromEnvironment(
        'API_BASE_URL',
        defaultValue: 'https://assess.hipster-dev.com/api',
      ),
      apiKey: String.fromEnvironment(
        'API_KEY',
        defaultValue: 'qxsm2peuW5ZiMz5Nq7DS',
      ),
      useFakeRtc: bool.fromEnvironment('USE_FAKE_RTC'),
    );
  }
}
