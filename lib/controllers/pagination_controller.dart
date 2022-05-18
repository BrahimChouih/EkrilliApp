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
  int? offerId;
  int? userId;
  bool myHouses;

  Parameters({
    this.page = 1,
    this.cityId,
    this.offerId,
    this.userId,
    this.myHouses = false,
  });
}
