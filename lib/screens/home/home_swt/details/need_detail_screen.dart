import 'package:bootcamp/style/colors.dart';
import 'package:bootcamp/style/icons/helphub_icons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class NeedDetailScreen extends StatefulWidget {
  final String needId;

  const NeedDetailScreen({Key? key, required this.needId}) : super(key: key);

  @override
  State<NeedDetailScreen> createState() => _NeedDetailScreenState();
}

class _NeedDetailScreenState extends State<NeedDetailScreen> {
  Map<String, dynamic>? needData;
  String ihtiyacSahibiKullaniciAdi = '';
  String ihtiyacSahibiIsim = '';
  String ihtiyacSahibiSoyad = '';
  String ihtiyacSahibiProfilResmi = '';
  LatLng? needLocation;

  @override
  void initState() {
    super.initState();
    fetchNeedData();
  }

  Future<void> fetchNeedData() async {
    final docSnapshot = await FirebaseFirestore.instance
        .collection('needs')
        .doc(widget.needId)
        .get();

    if (docSnapshot.exists) {
      final needData = docSnapshot.data() ?? {};
      final ihtiyacsahibiId = needData['İhtiyaç Sahibi'];

      if (ihtiyacsahibiId != null) {
        final userSnapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(ihtiyacsahibiId)
            .get();

        if (userSnapshot.exists) {
          final userData = userSnapshot.data() ?? {};
          final il = needData['city'];
          final ilce = needData['district'];
          final adres = needData['address'];

          final needLocation = adres != null && ilce != null && il != null
              ? await convertAddressToLocation(adres, ilce, il)
              : const LatLng(41.005, 28.978);

          setState(() {
            this.needData = needData;
            ihtiyacSahibiKullaniciAdi = userData['username'] ?? '';
            ihtiyacSahibiIsim = userData['firstName'] ?? '';
            ihtiyacSahibiSoyad = userData['lastName'] ?? '';
            ihtiyacSahibiProfilResmi = userData['profileImageURL'] ?? '';
            this.needLocation = needLocation;
          });
        }
      }
    }
  }

  Future<LatLng> convertAddressToLocation(
      String address, String district, String city) async {
    final query = "$address, $district, $city";
    List<Location> locations = await locationFromAddress(query);

    if (locations.isNotEmpty) {
      final location = locations.first;
      return LatLng(location.latitude, location.longitude);
    }

    return const LatLng(41.005, 28.978);
  }

  @override
  Widget build(BuildContext context) {
    Set<Marker> _createMarkers() {
      final markers = <Marker>{};

      if (needLocation != null) {
        markers.add(
          Marker(
            markerId: const MarkerId('needLocation'),
            position: needLocation!,
          ),
        );
      }

      return markers;
    }

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    if (needData == null) {
      return Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          backgroundColor: AppColors.purple,
          title: const Text('İhtiyaç Detayı'),
          elevation: 0,
        ),
        body: const Center(
          child: CircularProgressIndicator(
            color: AppColors.yellow,
            backgroundColor: AppColors.purple,
          ),
        ),
      );
    } else {
      final anakategori = needData!['anaKategori'];
      final altkategori = needData!['Alt Kategori'];
      final ihtiyac = needData!['İhtiyaç'];
      final il = needData!['city'];
      final ilce = needData!['district'];
      final adres = needData!['address'];
      final tarih = needData!['createdAt'] as Timestamp;
      DateTime dateTime = tarih.toDate();

      final formattedDate =
          DateFormat('dd MMMM EEEE HH:mm', 'tr_TR').format(dateTime);

      return Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            title: const Text(
              'İhtiyaç Detayı',
              style: TextStyle(color: AppColors.purple, fontSize: 25),
            ),
            iconTheme: const IconThemeData(color: AppColors.purple),
            leading: IconButton(
              icon: const Icon(Helphub.back),
              onPressed: () {
                Navigator.pop(context);
              },
            )),
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: screenWidth - (screenWidth - 25)),
                child: Card(
                  elevation: 5,
                  color: Colors.grey.shade50,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.02,
                        vertical: screenHeight * 0.02),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              anakategori + '/ ' + altkategori,
                              style: const TextStyle(
                                  color: AppColors.darkGrey,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.start,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: screenHeight * 0.03,
                        ),
                        Text(
                         ihtiyac,
                          style: const TextStyle(
                              color: AppColors.purple,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.start,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: screenWidth - (screenWidth - 25)),
                child: Card(
                  elevation: 5,
                  color: Colors.grey.shade50,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.02,
                        vertical: screenHeight * 0.02),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              '📆 ',
                              style: TextStyle(
                                  color: AppColors.darkGrey,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.start,
                            ),
                            Text(
                              formattedDate,
                              style: const TextStyle(
                                  color: AppColors.darkGrey,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.start,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: screenHeight * 0.02,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              '📍 ',
                              style: TextStyle(
                                  color: AppColors.darkGrey,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.start,
                            ),
                            Text(
                              "$ilce, $il",
                              style: const TextStyle(
                                  color: AppColors.darkGrey,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.start,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: screenWidth - (screenWidth - 25)),
                child: Card(
                  elevation: 5,
                  color: Colors.grey.shade50,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.02,
                        vertical: screenHeight * 0.01),
                    child: Column(
                      children: [
                        SizedBox(
                          height: screenHeight * 0.2,
                          child: GoogleMap(
                            initialCameraPosition: CameraPosition(
                              target: needLocation!,
                              zoom: 10,
                            ),
                            markers: _createMarkers(),
                            myLocationButtonEnabled: false,
                            myLocationEnabled: false,
                            mapType: MapType.normal,
                          ),
                        ),
                        SizedBox(
                          height: screenHeight * 0.01,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "$ilce, $il",
                              style: const TextStyle(
                                  color: AppColors.darkGrey,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.start,
                            ),
                            SizedBox(
                              width: screenWidth * 0.03,
                            ),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  final url =
                                      'https://www.google.com/maps/dir/?api=1&destination=$adres,$ilce,$il';
                                  launchUrl(Uri.parse(url));
                                },
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: AppColors.white,
                                  backgroundColor: AppColors.purple,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Text(
                                    "Yol Tarifi Al",
                                    style: TextStyle(
                                        color: AppColors.white, fontSize: 15),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: screenWidth - (screenWidth - 25)),
                      child: Card(
                        elevation: 5,
                        color: Colors.grey.shade50,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.02,
                              vertical: screenHeight * 0.02),
                          child: Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: AppColors.purple,
                                    width: 3,
                                  ),
                                ),
                                child: CircleAvatar(
                                  backgroundColor: Colors.grey.shade50,
                                  backgroundImage: ihtiyacSahibiProfilResmi
                                          .isNotEmpty
                                      ? NetworkImage(ihtiyacSahibiProfilResmi)
                                      : const AssetImage(
                                              'assets/profile/user_profile.png')
                                          as ImageProvider<Object>?,
                                  radius: 25,
                                ),
                              ),
                              SizedBox(
                                width: screenWidth * 0.03,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '$ihtiyacSahibiIsim $ihtiyacSahibiSoyad',
                                    style: const TextStyle(
                                        color: AppColors.darkGrey,
                                        fontSize: 20),
                                  ),
                                  SizedBox(
                                    height: screenHeight * 0.005,
                                  ),
                                  Text(
                                    '@$ihtiyacSahibiKullaniciAdi',
                                    style: const TextStyle(
                                        color: AppColors.purple, fontSize: 15),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.03,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: screenWidth - (screenWidth - 25)),
                      child: Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                foregroundColor: AppColors.white,
                                backgroundColor: AppColors.purple,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text(
                                  "Destek Ol",
                                  style: TextStyle(
                                      color: AppColors.white, fontSize: 25),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}
