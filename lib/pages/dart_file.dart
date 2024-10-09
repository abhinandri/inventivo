// body: CustomScrollView(
//           slivers: [
//             SliverAppBar(
//               automaticallyImplyLeading: false,
//               backgroundColor: const Color(0xFF005d63),
//               shape: const RoundedRectangleBorder(
//                 borderRadius: BorderRadius.only(
//                   bottomRight: Radius.circular(60),
//                   bottomLeft: Radius.circular(60),
//                 ),
//               ),
//               expandedHeight: 350,
//               pinned: true,
//               flexibleSpace: FlexibleSpaceBar(
//                 title: Padding(
//                   padding: const EdgeInsets.all(4.0),
//                   child: Text(
//                     'Gestio',
//                     style: GoogleFonts.oswald(
//                       color: Colors.white,
//                       fontSize: 24,
//                     ),
//                   ),
//                 ),
//                 centerTitle: true,
//                 titlePadding: const EdgeInsets.only(bottom: 16),
//                 background: SingleChildScrollView(
//                   child: Padding(
//                     padding: const EdgeInsets.all(15.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text(
//                               'Welcome',
//                               style: GoogleFonts.alef(
//                                 color: Colors.white,
//                                 fontSize: 25,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             const Row(
//                               children: [AddMemberIcon(), SettingsButton()],
//                             )
//                           ],
//                         ),
//                         Text(
//                           userData.name.toUpperCase(),
//                           style: GoogleFonts.alef(
//                             color: Colors.white,
//                             fontSize: 20,
//                           ),
//                         ),
//                         const Center(
//                           child: SizedBox(
//                             child: EventContainer(),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             const SliverFillRemaining(
//               child: Column(
//                 children: [
//                   SizedBox(height: 35),
//                   Expanded(child: TeamList()),
//                 ],
//               ),
//             ),
//           ],
//         ),
//         floatingActionButton: FloatingActionButton(
//           backgroundColor: const Color(0xFF005d63),
//           child: const Icon(
//             Icons.group_add_rounded,
//             color: Colors.white,
//           ),
//           onPressed: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (ctx) => const AddTeam()),
//             );
//           },
//         ),
//       ),
//     );
//   }

