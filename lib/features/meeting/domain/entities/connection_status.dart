/// The deterministic connection states (constitution Article IV).
///
/// `joining` begins at the API call; `connected`/`disconnected` are driven only
/// by Chime SDK lifecycle callbacks, never by the HTTP response alone.
enum ConnectionStatus { idle, joining, connected, disconnected, error }
