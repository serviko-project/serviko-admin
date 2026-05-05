enum ProviderStatus {
  pending,
  approved,
  rejected,
  blocked;

  static ProviderStatus fromString(String value) {
    return ProviderStatus.values.firstWhere(
      (e) => e.name == value,
      orElse: () => ProviderStatus.pending,
    );
  }
}
