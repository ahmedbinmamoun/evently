import 'package:event/ui/home/tabs/favotaite/favorite_tab.dart';
import 'package:event/ui/home/tabs/home_tab/home_tab.dart';
import 'package:event/ui/home/tabs/map/map_tab.dart';
import 'package:event/ui/home/tabs/profile/profile_tab.dart';
import 'package:event/utils/app_assets.dart';
import 'package:event/utils/app_colors.dart';
import 'package:event/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class HomeScreen extends StatefulWidget {
   HomeScreen({super.key});
     @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
   int selectIndex = 0;
   List<Widget> tabs = [
    HomeTab(),
    MapTab(),
    FavoriteTab(),
    ProfileTab(),
   ];

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return  Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectIndex,
        onTap: (index) {
          selectIndex = index;
          setState(() {
            
          });
        },
        
        items: [
          builtBottomNavigationBarItem(
            index: 0,
            selectedIconName: AppAssets.selectedHomeIcon,
            unSelectedIconName: AppAssets.homeIcon, 
          label:AppLocalizations.of(context)!.home
          ),
          builtBottomNavigationBarItem(
            index: 1,
            selectedIconName: AppAssets.selectedMapIcon,
            unSelectedIconName: AppAssets.mapIcon, 
          label:AppLocalizations.of(context)!.map
          ),
          builtBottomNavigationBarItem(
            index: 2,
            selectedIconName: AppAssets.selectedFavoriteIcon,
            unSelectedIconName: AppAssets.favoriteIcon,
          label:AppLocalizations.of(context)!.favorite
          ),
          builtBottomNavigationBarItem(
            index: 3,
            selectedIconName: AppAssets.selectedProfileIcon,
            unSelectedIconName: AppAssets.profileIcon,
          label:AppLocalizations.of(context)!.profile
          ),
        ]
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.pushNamed(context, AppRoutes.addEvent);
        },
      child: Icon(Icons.add,color: AppColors.whiteColor,size: 35,),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: tabs[selectIndex],
    );
  }

  BottomNavigationBarItem builtBottomNavigationBarItem({required String selectedIconName,required String unSelectedIconName,required String label,required int index}){
    return BottomNavigationBarItem(
      icon: Image.asset(selectIndex == index ? selectedIconName : unSelectedIconName),
      label: label
    );
  }
}