// Reusable pagination metadata from API responses
class PaginationMeta {
  final int page;
  final int limit;
  final int total;

  const PaginationMeta({
    required this.page,
    required this.limit,
    required this.total,
  });

  int get totalPages => (total / limit).ceil();
  bool get hasNextPage => page < totalPages;
  bool get hasPreviousPage => page > 1;

  factory PaginationMeta.fromJson(Map<String, dynamic> json) {
    return PaginationMeta(
      page: json['page'] as int,
      limit: json['limit'] as int,
      total: json['total'] as int,
    );
  }
}
