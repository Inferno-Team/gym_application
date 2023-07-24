import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_application/models/club_subscription.dart';
import 'package:gym_application/ui/custom_widget/custom_text.dart';

class BottomSheetClubSubscription extends StatelessWidget {
  final List<ClubSubScription>? subs;
  final void Function(ClubSubScription)? onTap;

  const BottomSheetClubSubscription({
    super.key,
    this.subs,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 450,
      color: Colors.white,
      child: Column(
        children: [
          Container(
            margin:const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => Get.back(),
                  child: const Icon(Icons.arrow_back_ios),
                ),
                const CustomText(
                  margin: EdgeInsets.symmetric( horizontal: 10),
                  text: "Subscriptions",
                  fontSize: 21,
                  alignment: Alignment.center,
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),
          ),
          if (subs == null) Container(),
          for (ClubSubScription sub in subs!)
            GestureDetector(
              onTap: () => onTap!(sub),
              child: Container(
                height: 60,
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.black12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.type_specimen,
                          color: Colors.black45,
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        CustomText(
                          text: sub.subscription.name,
                          alignment: Alignment.center,
                        )
                      ],
                    ),
                    CustomText(
                      text: "${sub.subscription.duration} Day",
                      alignment: Alignment.center,
                      isItalic: true,
                    ),
                    CustomText(
                      text: "${sub.price} SYP",
                      alignment: Alignment.center,
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
