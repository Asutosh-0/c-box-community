import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
class CarouseImage extends StatefulWidget {
  final List<String> imageLink;
  const CarouseImage({super.key, required this.imageLink});

  @override
  State<CarouseImage> createState() => _CarouseImageState();
}

class _CarouseImageState extends State<CarouseImage> {
  int current= 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Column(
          children: [
              CarouselSlider(
                  items: widget.imageLink.map((link) {
                    return  Container(
                        margin: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Image.network(link,fit:BoxFit.contain ,));
                  }
                  ).toList(),
                  options: CarouselOptions(
                    viewportFraction: 1,
                      enableInfiniteScroll: false,
                    onPageChanged: (index,reason){
                      setState(() {
                        current= index;
                      });

                    }

                  )
              ),
            Row(
              children: widget.imageLink.asMap().entries.map((e){

                return Container(
                  width: 12,
                  height: 12,
                  margin: EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey.withOpacity(current == e.key ? 0.9 : 0.4 )
                  ),
                );
              }).toList(),
            )


          ],

        )
      ],
    );
  }
}
