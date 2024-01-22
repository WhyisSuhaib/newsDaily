import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:newsdaily/models/categories_news_model.dart';
import 'package:newsdaily/view_model/news_view_model.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  NewsViewModel newsViewModel = NewsViewModel();
  final format = DateFormat("MM/ dd/ yyyy");

  String CategoryName = "general";

  List<String> categoriesList = [
    "General",
    "Entertainment",
    "Health",
    "Sports",
    "Business",
    "Technology"
  ];

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).width * 1;
    return Scaffold(


      appBar: AppBar(backgroundColor: Colors.white,),


      body: Padding(
        padding: const EdgeInsets.only(left: 20, top: 20),
        child: Column(
          children: [

            // Category List
            SizedBox(
              height: height * 0.1,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categoriesList.length,
                  itemBuilder: (context, index) {


            // Category Button Design
                    return InkWell(
                      onTap: () {
                        CategoryName = categoriesList[index];
                        setState(() {});
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: Container(
                          decoration: BoxDecoration(
                              color: CategoryName == categoriesList[index]
                                  ? Colors.blue
                                  : Colors.grey,
                              borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Center(
                                child: Text(categoriesList[index].toString(),
                                    style: GoogleFonts.pacifico(fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white
                                    )
                                  ,)
                            ),
                          ),
                        ),
                      ),
                    );

                  }),



            ),
            const SizedBox(height: 20,),


            Expanded(
              child: FutureBuilder<CategoriesNewsModel>(
                future: newsViewModel.fetchCategoriesNewsApi(CategoryName),
                builder: (BuildContext context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {

                    // Loading Animation
                    return const Center(
                      child: SpinKitCircle(size: 50, color: Colors.blueAccent,
                      ),
                    );

                  } else {

                    //Category News Tiles
                    return ListView.builder(
                        itemCount: snapshot.data!.articles!.length,
                        itemBuilder: (context, index) {

                          DateTime dateTime = DateTime.parse(
                              snapshot.data!.articles![index].publishedAt.toString());

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: Row(
                              children: [

                                //Category Image
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: CachedNetworkImage(
                                    imageUrl: snapshot.data!.articles![index].urlToImage.toString(),
                                    fit: BoxFit.cover,
                                    height :height * 0.18,
                                    width: width *0.3,
                                    placeholder: (context, url) => Container(
                                      child: const Center(
                                        child: SpinKitCircle(size: 50, color: Colors.blueAccent,),
                                      ),
                                    ),
                                    errorWidget: (context, url, error) => const Icon(
                                      Icons.error_outline, color: Colors.red,
                                    ),

                                  ),
                                ),


                                //Category Written Part
                                Expanded(
                                      child: Container(
                                    height: height* 0.18,
                                    padding: const EdgeInsets.only(left: 15,right: 5),
                                    child: Column(
                                      children: [

                                        //Category Title
                                        Text(snapshot
                                            .data!.articles![index].title
                                            .toString(),
                                        maxLines: 3,
                                        style: GoogleFonts.poppins(fontSize: 15, color: Colors.black54, fontWeight: FontWeight.w700
                                        ),
                                        ),
                                        const Spacer(),

                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            //Category Source
                                            Text(snapshot
                                                .data!.articles![index].source!
                                                .name
                                                .toString(),
                                              style: GoogleFonts.poppins(fontSize: 12, color: Colors.black54, fontWeight: FontWeight.w600
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only
                                                (right: 5),

                                              //Category Date
                                              child: Text(format.format(dateTime),
                                                style: GoogleFonts.poppins(fontSize: 10, color: Colors.black54, fontWeight: FontWeight.w700
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  )
                                )


                              ],
                            ),
                          );
                        });
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
