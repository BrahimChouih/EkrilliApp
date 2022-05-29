import 'package:ekrilli_app/models/offer.dart';
import 'package:ekrilli_app/models/user.dart';
import 'package:get/get.dart';

class PaginationController extends GetxController {
  int currentPage = 1;
  bool isGetAllPages = false;
  bool isLoading = true;

  Future<void> refreshData({Parameters? parameters}) async {
    currentPage = 1;
    isGetAllPages = false;
    changeLoadingState(true);
    await initData(parameters: parameters);
    changeLoadingState(false);
    await getNextPage(parameters: parameters);
  }

  Future<void> getNextPage({Parameters? parameters}) async {
    if (!isLoading && !isGetAllPages) {
      changeLoadingState(true);

      try {
        currentPage++;
        await getData(
          page: currentPage,
          parameters: parameters,
        );
      } catch (e) {
        isGetAllPages = true;
        // print(e);
      }

      changeLoadingState(false);
    }
  }

  void changeLoadingState(bool state) {
    isLoading = state;
    update();
  }

// override functions

  Future<void> initData({Parameters? parameters}) async {}

  Future<void> getData({required int page, Parameters? parameters}) async {}

  Future<void> getInfo() async {}
}

class Parameters {
  int page;
  int? cityId;
  Offer? offer;
  User? user;
  bool myHouses;
  String? search;
  String? orderBy;
  bool inversOrdering;

  Parameters({
    this.page = 1,
    this.cityId,
    this.offer,
    this.user,
    this.myHouses = false,
    this.search,
    this.orderBy = 'created_at',
    this.inversOrdering = false,
  });
}
