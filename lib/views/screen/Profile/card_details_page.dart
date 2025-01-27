import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zen_active/views/components/custom_app_bar.dart';
import 'package:zen_active/views/components/custom_button.dart';
import 'package:zen_active/views/components/custom_text_field.dart';
import 'package:zen_active/views/screen/Profile/subscription_confirmation_page.dart';

class CardDetailsPage extends StatefulWidget {
  const CardDetailsPage({super.key});

  @override
  State<CardDetailsPage> createState() => _CardDetailsPageState();
}

class _CardDetailsPageState extends State<CardDetailsPage> {
  TextEditingController hnController =
      TextEditingController(text: "Esther Howard");
  TextEditingController numController =
      TextEditingController(text: "4874 5246 9874 4528");
  TextEditingController cvvController = TextEditingController(text: "755");
  DateTime expiryDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(
              title: "Card Details",
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 24,
                ),
                child: Column(
                  spacing: 24,
                  children: [
                    const SizedBox(
                      height: 4,
                    ),
                    CustomTextField(
                      title: "Card Holder Name",
                      controller: hnController,
                    ),
                    CustomTextField(
                      title: "Card Number",
                      controller: numController,
                    ),
                    CustomTextField(
                      title: "Expiry Date",
                      controller: TextEditingController(
                        text:
                            "${expiryDate.day}/${expiryDate.month}/${expiryDate.year}",
                      ),
                      isDisabled: true,
                      onTap: () async {
                        DateTime? temp = await showDatePicker(
                          context: context,
                          firstDate: DateTime(2000),
                          lastDate: DateTime(
                            2050,
                          ),
                        );
                        setState(() {
                          if (temp != null) {
                            expiryDate = temp;
                          }
                        });
                      },
                    ),
                    CustomTextField(
                      title: "CVV",
                      controller: cvvController,
                    ),
                    const Spacer(),
                    CustomButton(
                      buttonName: "Confirm Purchase",
                      onPressed: () {
                        Get.to(SubscriptionConfirmationPage());
                      },
                    ),
                    const SizedBox(
                      height: 132,
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
