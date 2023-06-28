import 'package:bootcamp/style/colors.dart';
import 'package:bootcamp/style/icons/helphub_icons.dart';
import 'package:flutter/material.dart';

class ProfilBilgileri extends StatelessWidget {
  const ProfilBilgileri({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth - (screenWidth - 25),
        vertical: 25,
      ),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 5,
        color: Colors.grey.shade50,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                'Profil Bilgileri',
                style: TextStyle(
                  color: AppColors.darkGrey,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              leading: const CircleAvatar(
                backgroundImage: AssetImage(
                    'assets/profil/isa.jpg'),
                radius: 20,
              ),
              title: const Text(
                'Profil Resmi',
                style: TextStyle(color: AppColors.darkGrey),
              ),
              trailing: IconButton(
                icon: const Icon(
                  Icons.edit,
                  color: AppColors.purple,
                ),
                onPressed: () {

                },
              ),
            ),
            ListTile(
              leading: const Icon(
                Helphub.user,
                color: AppColors.purple,
              ),
              title: const Text(
                'İsim',
                style: TextStyle(color: AppColors.darkGrey),
              ),
              subtitle: const Text(
                'John Doe',
                style: TextStyle(color: AppColors.grey3),
              ),
              trailing: IconButton(
                icon: const Icon(
                  Icons.edit,
                  color: AppColors.purple,
                ),
                onPressed: () {},
              ),
            ),
            ListTile(
              leading: const Icon(
                Helphub.user,
                color: AppColors.purple,
              ),
              title: const Text(
                'Soyisim',
                style: TextStyle(color: AppColors.darkGrey),
              ),
              subtitle: const Text(
                'Doe',
                style: TextStyle(color: AppColors.grey3),
              ),
              trailing: IconButton(
                icon: const Icon(
                  Icons.edit,
                  color: AppColors.purple,
                ),
                onPressed: () {},
              ),
            ),
            ListTile(
              leading: const Icon(
                Helphub.user_outline,
                color: AppColors.purple,
              ),
              title: const Text(
                'Kullanıcı Adı',
                style: TextStyle(color: AppColors.darkGrey),
              ),
              subtitle: const Text(
                'johndoe123',
                style: TextStyle(color: AppColors.grey3),
              ),
              trailing: IconButton(
                icon: const Icon(
                  Icons.edit,
                  color: AppColors.purple,
                ),
                onPressed: () {},
              ),
            ),
            ListTile(
              leading: const Icon(
                Helphub.mail,
                color: AppColors.purple,
              ),
              title: const Text(
                'E-posta Adresi',
                style: TextStyle(color: AppColors.darkGrey),
              ),
              subtitle: const Text(
                'johndoe@example.com',
                style: TextStyle(color: AppColors.grey3),
              ),
              trailing: IconButton(
                icon: const Icon(
                  Icons.edit,
                  color: AppColors.purple,
                ),
                onPressed: () {},
              ),
            ),
            ListTile(
              leading: const Icon(
                Helphub.phone,
                color: AppColors.purple,
              ),
              title: const Text(
                'Telefon',
                style: TextStyle(color: AppColors.darkGrey),
              ),
              subtitle: const Text(
                '+1 123-456-7890',
                style: TextStyle(color: AppColors.grey3),
              ),
              trailing: IconButton(
                icon: const Icon(
                  Icons.edit,
                  color: AppColors.purple,
                ),
                onPressed: () {},
              ),
            ),
            ListTile(
              leading: const Icon(
                Helphub.home,
                color: AppColors.purple,
              ),
              title: const Text(
                'Adres',
                style: TextStyle(color: AppColors.darkGrey),
              ),
              subtitle: const Text(
                '123 Main St, City, Country',
                style: TextStyle(color: AppColors.grey3),
              ),
              trailing: IconButton(
                icon: const Icon(
                  Icons.edit,
                  color: AppColors.purple,
                ),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
