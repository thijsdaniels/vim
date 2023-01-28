abstract class Model {
  const Model();

  Map<String, dynamic> toMap();

  /// TODO: Add a getter for the Firestore reference? That would only apply to
  /// models that are actually stored remotely though, so maybe I should create
  /// a subclass for that.
}
