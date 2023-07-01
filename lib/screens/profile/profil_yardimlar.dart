import 'package:bootcamp/style/colors.dart';
import 'package:flutter/material.dart';

class ProfilYardimlar extends StatelessWidget {
  const ProfilYardimlar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
              border: Border.symmetric(
                horizontal: BorderSide(width: 3, color: AppColors.purple),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Expanded(
                        child: Text(
                          "7 Nisan 2023",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500),
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.more_vert),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Card(
                      elevation: 5,
                      color: Colors.grey.shade50,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          children: [
                            const Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "Şişli, İstanbul",
                                    style: TextStyle(
                                      color: AppColors.purple,
                                    ),
                                  ),
                                ),
                                Text(
                                  "Cuma",
                                  style: TextStyle(color: AppColors.grey3),
                                )
                              ],
                            ),
                            const Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "Bebek Bezi",
                                    style: TextStyle(
                                        color: AppColors.darkGrey,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Text(
                                  "10:00",
                                  style: TextStyle(
                                    color: AppColors.darkGrey,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Divider(
                              color: Colors.white,
                              thickness: 1.5,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(children: [
                              const Row(
                                children: [
                                  CircleAvatar(
                                    backgroundImage:
                                        AssetImage("assets/profile/isa.jpg"),
                                    radius: 15,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "1 kişi destek veriyor",
                                    style: TextStyle(
                                        color: AppColors.darkGrey,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                              Expanded(
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        backgroundColor: Colors.purple),
                                    child: const Text(
                                      "Detay",
                                      style: TextStyle(color: AppColors.white),
                                    ),
                                  ),
                                ),
                              )
                            ])
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
