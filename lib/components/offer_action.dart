import 'dart:convert';
import 'dart:ui';

import 'package:ekrilli_app/components/submit_button.dart';
import 'package:ekrilli_app/components/text_field_with_title.dart';
import 'package:ekrilli_app/controllers/auth_controller.dart';
import 'package:ekrilli_app/controllers/messages_controller.dart';
import 'package:ekrilli_app/controllers/offers_controller.dart';
import 'package:ekrilli_app/controllers/pagination_controller.dart';
import 'package:ekrilli_app/helpers/offer_helper.dart';
import 'package:ekrilli_app/models/chat_item_model.dart';
import 'package:ekrilli_app/models/message.dart';
import 'package:ekrilli_app/models/offer_sended.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../utils/constants.dart';

class OfferAction extends StatelessWidget {
  OfferAction({
    Key? key,
    this.offerSended,
  }) : super(key: key);

  RxBool expanded = false.obs;
  RxBool isLoading = false.obs;
  OfferSended? offerSended;

  MessagesController messagesController = Get.find<MessagesController>();
  OfferController offerController = Get.find<OfferController>();

  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController totalPriceController = TextEditingController();

  initData() {
    if (offerSended?.startDate != null && offerSended?.endDate != null) {
      startDateController.text =
          DateFormat(dateTimeFormat).format(offerSended!.startDate!);
      endDateController.text =
          DateFormat(dateTimeFormat).format(offerSended!.endDate!);

      totalPriceController.text = OfferHelper.getTotalPrice(
        startDate: offerSended!.startDate!,
        endDate: offerSended!.endDate!,
        pricePerDay: messagesController.parameters!.offer!.pricePerDay!,
      ).toString();
    }
  }

  TextStyle? textStyle;
  @override
  Widget build(BuildContext context) {
    initData();
    textStyle = TextStyle(
      color: Colors.black.withOpacity(0.8),
    );
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 5,
          sigmaY: 5,
        ),
        child: Container(
          width: Get.width,
          color: deepPrimaryColor.withOpacity(0.1),
          padding: EdgeInsets.symmetric(
            horizontal: Get.width * 0.03,
          ).copyWith(
            top: Get.height * 0.01,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Make a deal with this person',
                style: textStyle,
              ),
              AnimatedSize(
                duration: const Duration(milliseconds: 200),
                child: Obx(
                  () => Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      expanded.value ? body(context) : const SizedBox(),
                      InkWell(
                        onTap: () {
                          expanded.value = !expanded.value;
                        },
                        child: SizedBox(
                          height: Get.height * 0.04,
                          width: Get.width * 0.5,
                          child: Center(
                            child: FaIcon(
                              expanded.value
                                  ? FontAwesomeIcons.caretUp
                                  : FontAwesomeIcons.caretDown,
                              color: Colors.black.withOpacity(0.75),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget body(BuildContext context) {
    if (messagesController.isMin(messagesController.parameters!.offer!)) {
      ///////////////// owner /////////////////////////////

      if (messagesController.parameters!.offer!.status == statusPublished) {
        return sendOffer(context);
      }

      if (messagesController.parameters!.offer!.status ==
          statusWaittingForAccepte) {
        return accepteOffer(context);
      }

      if (messagesController.parameters!.offer!.status == statusRented) {
        return messagesController.parameters!.offer!.user!.id ==
                messagesController.parameters!.user!.id
            ? rentedOffer(context)
            : Text(
                'This offer is not available for this user',
                style: textStyle!.copyWith(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              );
      }
    } else {
      ////////////////// user //////////////////
      if (messagesController.parameters!.offer!.status == statusPublished &&
          offerSended != null &&
          !messagesController.isMin(
            messagesController.parameters!.offer!,
          )) {
        return accepteOffer(context);
      }

      if (messagesController.parameters!.offer!.status == statusPublished) {
        return Text(
          'Text me for make a deal.',
          style: textStyle?.copyWith(
            color: Colors.amber,
            fontWeight: FontWeight.bold,
          ),
        );
      }
      if (messagesController.parameters!.offer!.status ==
          statusWaittingForAccepte) {
        return accepteOffer(
          context,
          waitting: true,
        );
      }

      if (messagesController.parameters!.offer!.status == statusRented) {
        return messagesController.parameters!.offer!.user!.id ==
                Get.find<AuthController>().currentUser!.id
            ? rentedOffer(context)
            : Text(
                'This offer is not available',
                style: textStyle?.copyWith(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              );
      }
    }
    if (messagesController.parameters!.offer!.status == statusDone) {
      return doneOffer(context);
    }

    return const SizedBox();
  }

  Widget accepteOffer(BuildContext context, {bool waitting = false}) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          offerInformation(
            context,
            clickable:
                messagesController.isMin(messagesController.parameters!.offer!),
          ),
          !waitting
              ? Row(
                  mainAxisAlignment: messagesController
                          .isMin(messagesController.parameters!.offer!)
                      ? MainAxisAlignment.spaceEvenly
                      : MainAxisAlignment.center,
                  children: [
                    customSubmitButton(
                      text: 'Accept Offer',
                      onTap: () async {
                        //// change offer status to Rented or Waitting_for_accept
                        await offerController.changeStatus(
                          offerId: messagesController.parameters!.offer!.id!,
                          status:
                              messagesController.parameters!.offer!.status ==
                                      statusWaittingForAccepte
                                  ? statusRented
                                  : statusWaittingForAccepte,
                          offerData:
                              messagesController.parameters!.offer!.status ==
                                      statusWaittingForAccepte
                                  ? offerSended!.toJson()
                                  : null,
                          userId: messagesController.parameters!.user!.id,
                        );

                        /// get message after change offer status
                        await messagesController.initData(
                            parameters: messagesController.parameters);

                        /// update offer in pramaters after change his status
                        messagesController.parameters!.offer!.status =
                            messagesController.parameters!.offer!.status ==
                                    statusWaittingForAccepte
                                ? statusRented
                                : statusWaittingForAccepte;

                        if (messagesController.parameters!.offer!.status ==
                            statusRented) {
                          messagesController.parameters!.offer!.user =
                              messagesController.parameters!.user;
                        }
                        messagesController.changeLoadingState(false);
                      },
                    ),
                    messagesController
                            .isMin(messagesController.parameters!.offer!)
                        ? sendOfferButton()
                        : const SizedBox(),
                  ],
                )
              : Container(
                  margin: const EdgeInsets.only(top: 15),
                  child: Text(
                    'Waitting for accept',
                    style: textStyle!.copyWith(
                      color: Colors.amber,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
        ],
      );

  Widget rentedOffer(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          offerInformation(context, clickable: false),
          messagesController.isMin(messagesController.parameters!.offer!)
              ? customSubmitButton(
                  text: 'Done',
                  onTap: () async {
                    await offerController.changeStatus(
                      offerId: messagesController.parameters!.offer!.id!,
                      status: statusDone,
                      offerData: messagesController.parameters!.offer!.status ==
                              statusWaittingForAccepte
                          ? offerSended!.toJson()
                          : null,
                      userId: messagesController.parameters!.user!.id,
                    );
                    messagesController.parameters!.offer!.status = statusDone;
                    await messagesController.initData(
                        parameters: messagesController.parameters);
                    messagesController.changeLoadingState(false);
                  },
                )
              : Container(
                  margin: const EdgeInsets.only(top: 15),
                  child: Text(
                    'Ranted to you',
                    style: textStyle?.copyWith(
                      color: Colors.amber,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
        ],
      );
  Widget doneOffer(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          offerInformation(
            context,
            clickable: false,
          ),
          Container(
            margin: const EdgeInsets.only(top: 15),
            child: const Text(
              'Done',
              style: TextStyle(
                color: Colors.amber,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      );

  Widget sendOffer(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          offerInformation(context),
          sendOfferButton(),
        ],
      );

  sendOfferButton({String text = 'Send Offer'}) => customSubmitButton(
        text: text,
        onTap: () async {
          if (offerSended!.startDate != null && offerSended!.endDate != null) {
            await messagesController.sendMessage(
              offerId: messagesController.parameters!.offer!.id!,
              userId: messagesController.parameters!.user!.id!,
              message: Message(
                contentType: "OFFER_INFO",
                messageType: messagesController.messageType(
                  ChatItemModel(
                      offer: messagesController.parameters?.offer,
                      user: messagesController.parameters?.user),
                ),
                message: json.encode(
                  {
                    'start_date': offerSended!.startDate!.toIso8601String(),
                    'end_date': offerSended!.endDate!.toIso8601String(),
                    // 'status': statusPublished,
                  },
                ),
              ),
            );
            await offerController.changeStatus(
              offerId: messagesController.parameters!.offer!.id!,
              userId: messagesController.parameters!.user!.id!,
              status: statusPublished,
            );
            messagesController.parameters!.offer!.status = statusPublished;
            await messagesController.chatOfferSended(
              parameters: messagesController.parameters!,
            );
          }
        },
      );

  void offerDateRangePicker(BuildContext context) async {
    DateTimeRange? dateTimeRange = await showDateRangePicker(
      context: context,
      firstDate: offerSended?.startDate ?? DateTime(2015),
      lastDate: DateTime(2030),
      initialDateRange: DateTimeRange(
        start: offerSended?.startDate ?? DateTime.now(),
        end: offerSended?.endDate ?? DateTime.now(),
      ),
    );
    if (dateTimeRange != null) {
      offerSended = OfferSended(
        startDate: dateTimeRange.start,
        endDate: dateTimeRange.end,
      );
      initData();
    }
  }

  Widget offerInformation(BuildContext context, {bool clickable = true}) =>
      IgnorePointer(
        ignoring: !clickable,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFielWithTitle(
              controller: startDateController,
              title: 'Start Date',
              readOnly: true,
              validator: (_) => null,
              onTap: () => offerDateRangePicker(context),
            ),
            SizedBox(height: Get.height * 0.02),
            TextFielWithTitle(
              controller: endDateController,
              title: 'End Date',
              readOnly: true,
              validator: (_) => null,
              onTap: () => offerDateRangePicker(context),
            ),
            SizedBox(height: Get.height * 0.02),
            TextFielWithTitle(
              controller: totalPriceController,
              title: 'Total Price',
              readOnly: true,
              validator: (_) => null,
            ),
          ],
        ),
      );
  Widget customSubmitButton({required String text, Future Function()? onTap}) =>
      Obx(
        () => IgnorePointer(
          ignoring: isLoading.value,
          child: SubmitButton(
            text: isLoading.value ? 'Wait...' : text,
            onTap: () async {
              if (onTap != null) {
                isLoading.value = true;
                try {
                  await onTap();
                  await messagesController.chatOfferSended(
                    parameters: messagesController.parameters!,
                  );
                } catch (e) {
                  print(e);
                }

                isLoading.value = false;
              }
            },
            color: primaryColor.withOpacity(0.8),
            textColor: Colors.white.withOpacity(0.9),
            margin: EdgeInsets.symmetric(
              vertical: Get.height * 0.02,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 5,
            ),
          ),
        ),
      );
}
