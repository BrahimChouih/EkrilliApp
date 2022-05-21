import 'dart:convert';
import 'dart:ui';

import 'package:ekrilli_app/components/submit_button.dart';
import 'package:ekrilli_app/components/text_field_with_title.dart';
import 'package:ekrilli_app/controllers/messages_controller.dart';
import 'package:ekrilli_app/controllers/pagination_controller.dart';
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
    this.parameters,
  }) : super(key: key);
  RxBool expanded = false.obs;
  OfferSended? offerSended;
  final Parameters? parameters;
  MessagesController messagesController = Get.find<MessagesController>();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    startDateController.text = offerSended?.startDate != null
        ? DateFormat(dateTimeFormat).format(offerSended!.startDate!)
        : '';
    endDateController.text = offerSended?.startDate != null
        ? DateFormat(dateTimeFormat).format(offerSended!.endDate!)
        : '';
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
                style: TextStyle(
                  color: Colors.black.withOpacity(0.8),
                ),
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
    if (parameters!.offer!.status == statusPublished) {
      return sendOffer(context);
    }
    if (parameters!.offer!.status == statusWaittingForAccepte) {
      return accepteOffer();
    }
    if (parameters!.offer!.status == statusRented) {
      return rentedOffer();
    }
    if (parameters!.offer!.status == statusDone) {
      return doneOffer();
    }

    return const SizedBox();
  }

  Widget accepteOffer() => Container();
  Widget rentedOffer() => Container();
  Widget doneOffer() => Container();

  Widget sendOffer(BuildContext context) => Column(
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
          SubmitButton(
            text: 'Send Offer',
            onTap: () async {
              if (offerSended!.startDate != null &&
                  offerSended!.endDate != null) {
                await messagesController.sendMessage(
                  offerId: parameters!.offer!.id!,
                  userId: parameters!.user!.id!,
                  message: Message(
                    contentType: "OFFER_INFO",
                    messageType: messagesController.messageType(
                      ChatItemModel(
                          offer: parameters?.offer, user: parameters?.user),
                    ),
                    message: json.encode(
                      {
                        'start_date': offerSended!.startDate!.toIso8601String(),
                        'end_date': offerSended!.endDate!.toIso8601String(),
                      },
                    ),
                  ),
                );
                await messagesController.chatOfferSended(
                  parameters: parameters!,
                );
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
        ],
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
      startDateController.text = DateFormat(dateTimeFormat).format(
        dateTimeRange.start,
      );
      endDateController.text = DateFormat(dateTimeFormat).format(
        dateTimeRange.end,
      );
    }
  }
}
