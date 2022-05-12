import 'package:get/get.dart';

class PaginationController extends GetxController {
  int currentPage = 1;
  bool isGetAllPages = false;
  bool isLoading = true;

  Future<void> refreshData() async {
    currentPage = 1;
    isGetAllPages = false;
    changeLoadingState(true);
    await initData();
    changeLoadingState(false);
    await getNextPage();
  }

  Future<void> getNextPage() async {
    if (!isLoading && !isGetAllPages) {
      changeLoadingState(true);

      try {
        currentPage++;
        await getData(page: currentPage);
      } catch (e) {
        isGetAllPages = true;
        print(e);
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

  Future<void> getData({required int page}) async {}

  Future<void> getInfo() async {}
}

class Parameters {
  int page;
  int? cityId;

  Parameters({
    this.page = 1,
    this.cityId,
  });
}
