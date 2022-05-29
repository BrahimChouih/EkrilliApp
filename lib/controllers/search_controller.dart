import 'package:ekrilli_app/controllers/pagination_controller.dart';
import 'package:ekrilli_app/data/repositories/offer_repository.dart';
import '../models/offer.dart';

class SearchController extends PaginationController with OfferRepository {
  List<Offer> offers = [];

  bool isSearching = false;

  final filterOptionsId = 'filterOptionsId';

  bool get isEmpty => offers.isEmpty;

  @override
  Future<void> getData({required int page, Parameters? parameters}) async {
    // changeLoadingState(true);

    List<Offer>? resualt = await super.search(
      page: page,
      cityId: parameters?.cityId,
      search: parameters?.search,
      orderBy: parameters?.orderBy,
      inversOrdering: parameters?.inversOrdering ?? false,
    );

    offers.addAll(resualt ?? []);
    // changeLoadingState(false);
  }

  @override
  Future<void> initData({Parameters? parameters}) async {
    isSearching = true;
    update();
    List<Offer>? resualt = await super.search(
      cityId: parameters?.cityId,
      search: parameters?.search,
      orderBy: parameters?.orderBy,
      inversOrdering: parameters?.inversOrdering ?? false,
    );

    offers = resualt ?? [];

    isSearching = false;
    update();
  }
}
