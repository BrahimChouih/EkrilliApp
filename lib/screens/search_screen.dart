import 'package:ekrilli_app/components/custom_app_bar.dart';
import 'package:ekrilli_app/controllers/pagination_controller.dart';
import 'package:ekrilli_app/controllers/search_controller.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../components/custom_text_field.dart';
import '../components/empty_screen.dart';
import '../components/house_widget.dart';
import '../utils/constants.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  SearchController searchController = Get.put(SearchController());
  Parameters? parameters;
  TextEditingController searchStatmentController = TextEditingController();

  ScrollController searchScrollController = ScrollController();
  void search() async {
    parameters?.search = searchStatmentController.text;
    await searchController.refreshData(
      parameters: parameters,
    );
  }

  @override
  void initState() {
    parameters = Parameters();
    if (searchController.isEmpty) {
      searchController.refreshData(parameters: parameters);
    }
    searchScrollController.addListener(() {
      if ((searchScrollController.position.maxScrollExtent * 0.9) <
          searchScrollController.position.pixels) {
        searchController.getNextPage(parameters: parameters);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    searchScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(
              backButton: true,
              title: 'Search',
            ),
            Expanded(
              child: SingleChildScrollView(
                controller: searchScrollController,
                child: Column(
                  children: [
                    SizedBox(height: Get.height * 0.01),
                    CustomTextField(
                      hintText: 'Search',
                      margin:
                          EdgeInsets.symmetric(horizontal: Get.width * 0.05),
                      borderColor: deepPrimaryColor,
                      controller: searchStatmentController,
                      onSubmitted: (value) {
                        search();
                      },
                      prefixIcon: IconButton(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onPressed: search,
                        icon: const Icon(
                          FontAwesomeIcons.magnifyingGlass,
                          color: deepPrimaryColor,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                        vertical: 5,
                      ).copyWith(
                        left: Get.width * 0.05,
                        right: Get.width * 0.02,
                      ),
                      child: GetBuilder<SearchController>(
                          id: searchController.filterOptionsId,
                          builder: (context) {
                            return Row(
                              children: [
                                Text('Order by'.tr),
                                const Spacer(),
                                DropdownButton<String>(
                                  isExpanded: false,
                                  items: [
                                    DropdownMenuItem(
                                      child: Text('Date'.tr),
                                      value: 'created_at',
                                    ),
                                    DropdownMenuItem(
                                      child: Text('Number of reviews'.tr),
                                      value: 'numReviews',
                                    ),
                                    DropdownMenuItem(
                                      child: Text('Price'.tr),
                                      value: 'price_per_day',
                                    ),
                                  ],
                                  value: parameters?.orderBy,
                                  onChanged: (value) async {
                                    parameters?.orderBy = value;
                                    searchController.update([
                                      searchController.filterOptionsId,
                                    ]);
                                    await searchController.refreshData(
                                        parameters: parameters);
                                  },
                                ),
                                const Spacer(),
                                InkWell(
                                  onTap: () async {
                                    parameters?.inversOrdering =
                                        (parameters?.inversOrdering) ?? false;
                                    searchController.update([
                                      searchController.filterOptionsId,
                                    ]);
                                    await searchController.refreshData(
                                      parameters: parameters,
                                    );
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('Reverse'.tr),
                                      Checkbox(
                                          value: parameters?.inversOrdering,
                                          activeColor:
                                              primaryColor.withOpacity(0.9),
                                          onChanged: (value) async {
                                            parameters?.inversOrdering = value!;
                                            searchController.update([
                                              searchController.filterOptionsId,
                                            ]);
                                            await searchController.refreshData(
                                              parameters: parameters,
                                            );
                                          }),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          }),
                    ),
                    GetBuilder<SearchController>(
                      builder: (_) => searchController.isSearching
                          ? const HouseLoader()
                          : searchController.isEmpty
                              ? searchController.isLoading
                                  ? const HouseLoader()
                                  : const Center(
                                      child: EmptyScreen(
                                        title: 'No Houses yet',
                                        icon: FontAwesomeIcons
                                            .houseCircleExclamation,
                                        isExpanded: false,
                                      ),
                                    )
                              : ListView.builder(
                                  itemCount: searchController.offers.length,
                                  shrinkWrap: true,
                                  primary: false,
                                  itemBuilder: (_, index) =>
                                      // index != searchController.offers.length
                                      //     ?
                                      HouseWidget(
                                    offer: searchController.offers[index],
                                  ),
                                  // : searchController.isGetAllPages
                                  //     ? const SizedBox()
                                  //     : Container(
                                  //         alignment: Alignment.center,
                                  //         margin:
                                  //             const EdgeInsets.symmetric(
                                  //                 vertical: 5),
                                  //         child:
                                  //             const CircularProgressIndicator(),
                                  //       ),
                                ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
