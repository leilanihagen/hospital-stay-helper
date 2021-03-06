import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:hospital_stay_helper/class/sharePref.dart';
import 'package:hospital_stay_helper/config/styles.dart';
import 'package:hospital_stay_helper/plugins/firebase_analytics.dart';
import 'package:hospital_stay_helper/screens/checkHospital.dart';
import 'package:hospital_stay_helper/screens/dashboard.dart';
import 'package:hospital_stay_helper/screens/guidelinesPage.dart';
import 'package:hospital_stay_helper/screens/profilePage.dart';
import 'package:hospital_stay_helper/screens/searchPage.dart';
import 'package:hospital_stay_helper/screens/visitsTimelinePage.dart';
import 'screens/guidelinesPage.dart';
import 'screens/visitsTimelinePage.dart';

class AppBottomNavBarController extends StatefulWidget {
  final int currentIndex;
  AppBottomNavBarController({Key key, @required this.currentIndex})
      : super(key: key);

  @override
  _AppBottomNavBarControllerState createState() =>
      _AppBottomNavBarControllerState();
}

// (Below) re-implementing the state of AppBottomNavBarController
class _AppBottomNavBarControllerState extends State<AppBottomNavBarController> {
  List<Widget> pages;
  PageController _pageController;
  int _selectedIndex;
  bool profileSelected = false;
  bool haveOpenProfile = false;

  @override
  void initState() {
    _selectedIndex = widget.currentIndex;
    super.initState();
    observer.analytics.logAppOpen();
    pages = [
      DashboardPage(
        key: PageStorageKey('dashboard'),
        openPage: openPage,
      ),
      RootCategoriesPage(),
      VisitsTimelinePage(key: PageStorageKey('visitstimeline')),
      HospitalSearchPage(key: PageStorageKey('hospitalsearch')),
      SearchPage(key: PageStorageKey('searchservices')),
      ProfilePage(key: PageStorageKey('yourprofile')),
    ];
    _pageController = PageController(initialPage: _selectedIndex);
    profileSelect();
  }

  profileSelect() async {
    var temp = await MySharedPreferences.instance.getBoolValue("selectProfile");
    setState(() {
      haveOpenProfile = temp;
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void openPage(int index) async {
    setState(() {
      if (index < 5)
        _selectedIndex = index;
      else
        profileSelected = true;
      _pageController.jumpToPage(index);
    });
    switch (index) {
      case 0:
        observer.analytics.logEvent(name: 'open_dashboard');

        break;
      case 1:
        observer.analytics.logEvent(name: 'open_guildelines');
        break;
      case 2:
        observer.analytics.logEvent(name: 'open_visittimeline');

        break;
      case 3:
        observer.analytics.logEvent(name: 'open_checkhospital');
        break;
      case 4:
        observer.analytics.logEvent(name: 'open_searchpage');
        break;
      case 5:
        observer.analytics.logEvent(name: 'open_profilepage');
        break;
      default:
    }
  }

  Widget _bottomNavBar(int selectedIndex) => Theme(
        data: Theme.of(context).copyWith(canvasColor: Styles.blueTheme),
        child: BottomNavigationBar(
            // showSelectedLabels: false,
            // showUnselectedLabels: true,
            selectedItemColor: Styles.purpleTheme,
            unselectedItemColor: Colors.white,
            backgroundColor: Styles.blueTheme,
            selectedLabelStyle: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: Styles.darkPinkTheme),
            onTap: (int index) {
              setState(() {
                _selectedIndex = index;
                profileSelected = false;
                openPage(index);
              });
            }, // rebuild this widget
            currentIndex: selectedIndex,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Dashboard',
              ),
              BottomNavigationBarItem(
                icon: Icon(IconData(
                  62421,
                  fontFamily: 'MaterialIcons',
                )),
                label: 'Guidelines',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.event_note,
                ),
                label: 'Visits',
              ),
              BottomNavigationBarItem(
                icon: Icon(IconData(0xe857, fontFamily: 'MaterialIcons')),
                label: 'Find Hospitals',
              ),
              BottomNavigationBarItem(
                icon: Icon(IconData(59828, fontFamily: 'MaterialIcons')),
                label: 'Services',
              ),
            ]),
      );

  List<String> _pageTitles = [
    'Dashboard',
    'Guidelines',
    'Visits Timeline',
    'Find In-Network Hospitals',
    'Search Medical Services'
  ];
  String profileTitle = 'User Settings';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Styles.blueTheme,
        leading: IconButton(
          color: profileSelected ? Styles.blueTheme : Colors.grey,
          icon: Badge(
            // badgeColor: Colors.white,
            showBadge: !haveOpenProfile,
            badgeContent: Text(
              "1",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
            ),
            child: ClipOval(
              child: Container(
                padding: EdgeInsets.all(5),
                color: Colors.white,
                child: Icon(
                  Icons.settings,
                ),
              ),
            ),
          ),
          onPressed: () => setState(() {
            profileSelected = haveOpenProfile = true;
            _pageController.jumpToPage(5);
          }),
        ),
        title: profileSelected
            ? Text(
                profileTitle,
                style: Styles.appBar,
              )
            : Text(
                _pageTitles[_selectedIndex],
                style: Styles.appBar,
              ),
      ),
      bottomNavigationBar: _bottomNavBar(_selectedIndex),
      body: PageView(
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        children: pages,
      ),
    );
  }
}
