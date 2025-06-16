// import 'package:flutter/material.dart';

// class ProfilePage extends StatelessWidget {
//   const ProfilePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         backgroundColor: Colors.black,
//         leading: IconButton(
//           icon: const Icon(
//             Icons.arrow_back_ios,
//             color: Colors.white,
//             size: 20,
//           ),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//       ),
//       body: Padding(
//         padding: EdgeInsets.symmetric(
//           horizontal: MediaQuery.of(context).size.width * 0.055,
//           vertical: MediaQuery.of(context).size.height * 0.02,
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const CircleAvatar(
//                   radius: 50,
//                   backgroundImage: AssetImage('assets/images/profile.jpg'),
//                 ),
//                 const RotatedBox(
//                   quarterTurns: 1,
//                   child: Divider(
//                     color: Colors.white,
//                     thickness: 2,
//                   ),
//                 ),
//                 Container(
//                   height: 90,
//                   width: 130,
//                   padding: const EdgeInsets.all(10),
//                   child: const Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Joined',
//                         style: TextStyle(
//                           color: Colors.grey,
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       Text(
//                         'June 2025',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             const Text(
//               'Chimsom \nDivine Elue',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 25,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             _buildDivider(),
//             IconRow(
//               text: 'Edit profile',
//               onTap: () {
//                 Navigator.pushNamed(context, '/edit');
//               },
//             ),
//             const SizedBox(
//               height: 8,
//             ),
//             _buildDivider(),
//             const SizedBox(
//               height: 8,
//             ),
//             IconRow(
//               text: 'Privacy Policy',
//               onTap: () {
//                 Navigator.pushNamed(context, '/privacyPolicy');
//               },
//             ),
//             const SizedBox(
//               height: 8,
//             ),
//             _buildDivider(),
//             const SizedBox(
//               height: 8,
//             ),
//             IconRow(
//               text: 'Settings',
//               onTap: () {
//                 Navigator.pushNamed(context, '/settings');
//               },
//             ),
//             _buildDivider(),
//             const SizedBox(
//               height: 8,
//             ),
//             const Spacer(),
//             GestureDetector(
//               onTap: () async {},
//               child: SizedBox(
//                 height: 90,
//                 width: double.infinity,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Container(
//                           padding: const EdgeInsets.symmetric(
//                             horizontal: 6,
//                             vertical: 2,
//                           ),
//                           decoration: BoxDecoration(
//                             color: Colors.red,
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           child: const Text(
//                             'Pro',
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 15,
//                             ),
//                           ),
//                         ),
//                         const Text(
//                           'Upgrade to Pro',
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 18,
//                           ),
//                         ),
//                         const Text(
//                           'This subscription will auto-renew',
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 14,
//                           ),
//                         ),
//                       ],
//                     ),
//                     const Padding(
//                       padding: EdgeInsets.all(10.0),
//                       child: Icon(
//                         Icons.arrow_forward_ios,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             const Spacer(),
//             _buildDivider(),
//             TextButton(
//               onPressed: () {
//                 Navigator.pushNamed(context, '/login');
//               },
//               child: const Text(
//                 'Sign Out',
//                 style: TextStyle(
//                   color: Colors.red,
//                   fontSize: 20,
//                 ),
//               ),
//             ),
//             _buildDivider(),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildDivider() {
//     return Divider(
//       color: Colors.grey.withOpacity(0.15),
//       thickness: 2,
//       height: 16,
//     );
//   }
// }

// class IconRow extends StatelessWidget {
//   const IconRow({
//     super.key,
//     required this.text,
//     required this.onTap,
//   });

//   final String text;
//   final Function onTap;

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         onTap();
//       },
//       child: SizedBox(
//         height: 30,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               text,
//               style: const TextStyle(
//                 color: Colors.white,
//                 fontSize: 20,
//               ),
//             ),
//             const Padding(
//               padding: EdgeInsets.all(8.0),
//               child: Icon(
//                 Icons.arrow_forward_ios,
//                 color: Colors.white,
//                 size: 18,
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

// ignore_for_file: file_names

import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 400;
    final isLargeScreen = screenSize.width > 600;
    final isPortrait = screenSize.height > screenSize.width;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: 20,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenSize.width * 0.05,
            vertical: screenSize.height * 0.02,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Header Section
              _buildProfileHeader(
                  context, isSmallScreen, isLargeScreen, isPortrait),

              SizedBox(height: isSmallScreen ? 16 : 20),

              // Name Text
              Text(
                'Chimsom \nDivine Elue',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: isSmallScreen
                      ? 22
                      : isLargeScreen
                          ? 28
                          : 25,
                  fontWeight: FontWeight.bold,
                  height: 1.2,
                ),
              ),

              SizedBox(height: isSmallScreen ? 16 : 20),

              _buildDivider(),

              // Menu Items
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      _buildMenuItem(
                        context: context,
                        text: 'Edit profile',
                        route: '/edit',
                        isSmallScreen: isSmallScreen,
                      ),
                      _buildDivider(),
                      _buildMenuItem(
                        context: context,
                        text: 'Privacy Policy',
                        route: '/privacyPolicy',
                        isSmallScreen: isSmallScreen,
                      ),
                      _buildDivider(),
                      _buildMenuItem(
                        context: context,
                        text: 'Settings',
                        route: '/settings',
                        isSmallScreen: isSmallScreen,
                      ),
                      _buildDivider(),
                    ],
                  ),
                ),
              ),

              // Pro Upgrade Section
              _buildProUpgradeSection(isSmallScreen, isLargeScreen),

              SizedBox(height: isSmallScreen ? 8 : 12),

              _buildDivider(),

              // Sign Out Button
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      vertical: isSmallScreen ? 12 : 16,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/login');
                  },
                  child: Text(
                    'Sign Out',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: isSmallScreen
                          ? 18
                          : isLargeScreen
                              ? 22
                              : 20,
                    ),
                  ),
                ),
              ),

              _buildDivider(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader(
    BuildContext context,
    bool isSmallScreen,
    bool isLargeScreen,
    bool isPortrait,
  ) {
    final avatarRadius = isLargeScreen
        ? (isPortrait ? 60.0 : 50.0)
        : isSmallScreen
            ? 40.0
            : 50.0;

    if (isSmallScreen) {
      return Column(
        children: [
          CircleAvatar(
            radius: avatarRadius,
            backgroundColor: Colors.grey[800],
            backgroundImage: const AssetImage(
              'assets/images/profile.jpg',
              package: 'your_package_name',
            ),
            onBackgroundImageError: (exception, stackTrace) =>
                const Icon(Icons.person, size: 50, color: Colors.white),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.calendar_today, color: Colors.grey, size: 16),
              const SizedBox(width: 8),
              Text(
                'Joined June 2025',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: isPortrait ? 16 : 14,
                ),
              ),
            ],
          ),
        ],
      );
    } else if (isLargeScreen) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: avatarRadius,
            backgroundColor: Colors.grey[800],
            backgroundImage: const AssetImage(
              'assets/images/profile.jpg',
              package: 'your_package_name',
            ),
            onBackgroundImageError: (exception, stackTrace) =>
                const Icon(Icons.person, size: 70, color: Colors.white),
          ),
          const SizedBox(width: 30),
          const VerticalDivider(
            color: Colors.white,
            thickness: 2,
            indent: 10,
            endIndent: 10,
          ),
          const SizedBox(width: 30),
          Container(
            padding: const EdgeInsets.all(10),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Joined',
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  'June 2025',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    } else {
      var screenSize = MediaQuery.of(context).size;
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
            radius: avatarRadius,
            backgroundColor: Colors.grey[800],
            backgroundImage: const AssetImage(
              'assets/images/profile.jpg',
              package: 'your_package_name',
            ),
            onBackgroundImageError: (exception, stackTrace) =>
                const Icon(Icons.person, size: 50, color: Colors.white),
          ),
          const RotatedBox(
            quarterTurns: 1,
            child: Divider(
              color: Colors.white,
              thickness: 2,
            ),
          ),
          Container(
            constraints: BoxConstraints(maxWidth: screenSize.width * 0.35),
            padding: const EdgeInsets.all(10),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Joined',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'June 2025',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }
  }

  Widget _buildMenuItem({
    required BuildContext context,
    required String text,
    required String route,
    required bool isSmallScreen,
  }) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        Navigator.pushNamed(context, route);
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: isSmallScreen ? 12 : 16,
          horizontal: 8,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontSize: isSmallScreen ? 18 : 20,
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
              size: 18,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProUpgradeSection(bool isSmallScreen, bool isLargeScreen) {
    return GestureDetector(
      onTap: () async {},
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: isSmallScreen ? 12 : 16,
          horizontal: 8,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    'Pro',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ),
                SizedBox(height: isSmallScreen ? 6 : 8),
                Text(
                  'Upgrade to Pro',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: isSmallScreen
                        ? 16
                        : isLargeScreen
                            ? 20
                            : 18,
                  ),
                ),
                Text(
                  'This subscription will auto-renew',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: isSmallScreen ? 12 : 14,
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(
      color: Colors.grey.withOpacity(0.15),
      thickness: 2,
      height: 1,
    );
  }
}
