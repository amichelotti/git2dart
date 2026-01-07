import 'package:git2dart/git2dart.dart';

/// A class that encapsulates various callback functions used in Git operations.
///
/// This class is primarily used with [Remote] methods and [Repository.clone]
/// operations to handle different aspects of Git operations:
/// - Authentication
/// - Progress tracking
/// - Reference updates
/// - Push status updates
class Callbacks {
  /// Creates a new instance of [Callbacks].
  ///
  /// All parameters are optional and can be provided based on the specific
  /// Git operation requirements:
  ///
  /// * [credentials] - Authentication credentials (see [Credentials] implementations)
  /// * [transferProgress] - Progress tracking for data transfers
  /// * [sidebandProgress] - Textual progress updates from remote
  /// * [updateTips] - Reference update notifications
  /// * [pushUpdateReference] - Push operation status updates
  /// * [certificateCheck] - SSL certificate verification callback
  const Callbacks({
    this.credentials,
    this.transferProgress,
    this.sidebandProgress,
    this.updateTips,
    this.pushUpdateReference,
    this.certificateCheck,
  });

  /// Authentication credentials for Git operations.
  ///
  /// Can be one of the following implementations:
  /// * [UserPass] - Username/password authentication
  /// * [Keypair] - SSH key pair authentication
  /// * [KeypairFromAgent] - SSH agent-based authentication
  /// * [KeypairFromMemory] - In-memory SSH key pair authentication
  final Credentials? credentials;

  /// Callback for tracking data transfer progress.
  ///
  /// Provides real-time updates about the progress of data transfers
  /// during Git operations.
  final void Function(TransferProgress)? transferProgress;

  /// Callback for receiving textual progress updates from remote.
  ///
  /// Used to receive and process text-based progress messages
  /// from the remote repository.
  final void Function(String message, int len, void payload)? sidebandProgress;

  /// Callback for reference update notifications.
  ///
  /// Reports changes to references with:
  /// * [refname] - Name of the reference being updated
  /// * [old] - Previous OID of the reference
  /// * [newOne] - New OID of the reference
  final void Function(String refname, Oid old, Oid newOne)? updateTips;

  /// Callback for push operation status updates.
  ///
  /// Provides information about the status of push operations:
  /// * [refname] - Name of the reference being pushed
  /// * [message] - Status message from the remote
  final void Function(String refname, String message)? pushUpdateReference;

  /// Callback for customizing SSL certificate verification.
  ///
  /// Called during HTTPS operations to allow custom certificate validation logic.
  /// This enables accepting self-signed or internally-signed certificates.
  ///
  /// Parameters:
  /// * [host] - The hostname of the remote server
  /// * [isValid] - Whether the certificate is valid according to standard validation
  ///
  /// Return value:
  /// * `0` - Accept the certificate and continue the operation
  /// * Non-zero - Reject the certificate and fail the operation
  ///
  /// Example: Accept all certificates (useful for internal/self-signed certs):
  /// ```dart
  /// certificateCheck: (host, isValid) => 0
  /// ```
  ///
  /// Example: Accept only for specific host:
  /// ```dart
  /// certificateCheck: (host, isValid) => host == 'internal.example.com' ? 0 : -1
  /// ```
  final int Function(String host, {required bool isValid})? certificateCheck;
}
