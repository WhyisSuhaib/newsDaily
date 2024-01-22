import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class NewsDetailScreen extends StatefulWidget {
  final String newsImage,
      newsTitle,
      newsDate,
      author,
      description,
      content,
      source;
  const NewsDetailScreen(
      { Key? key,
      required this.newsImage,
      required this.newsTitle,
      required this.newsDate,
      required this.author,
      required this.description,
      required this.source,
      required this.content});

  @override
  State<NewsDetailScreen> createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<NewsDetailScreen> {

  final format = DateFormat("MMM dd, yy");
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).width * 1;
    DateTime dateTime = DateTime.parse(widget.newsDate);
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
      body: Stack(
        children: [
          SizedBox(
            height: height * 0.45,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              child: CachedNetworkImage(
                imageUrl: widget.newsImage,
                fit: BoxFit.cover,
                placeholder: (context, ulr) => const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
          ),
          Container(
            height: height * 0.6,
            margin: EdgeInsets.only(top: height * 0.4),
            padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
            decoration: const BoxDecoration(color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            ),
            child: ListView(
              children: [
                Text(widget.newsTitle,
                    style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w700)),
                SizedBox(
                  height: height * 0.02,
                ),
                Row(
                  children: [
                    Text(widget.source,
                        style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w700)),
                    Text(format.format(dateTime),
                        style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w500)),

                  ],
                ),
                SizedBox(height: height * 0.03,),
                Text(widget.description,
                    style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w700)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
