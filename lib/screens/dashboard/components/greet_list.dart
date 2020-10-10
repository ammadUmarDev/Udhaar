import 'package:flutter/material.dart';
import 'package:flutter_page_indicator/flutter_page_indicator.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:udhaar/components/greet_card.dart';
import 'package:udhaar/components/h3.dart';
import 'package:udhaar/constants.dart';

// ignore: must_be_immutable
class GreetList extends StatelessWidget {
  List<GreetCard> products;

  final SwiperController swiperController = SwiperController();

  GreetList({Key key, this.products}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double cardHeight = 140;
    double cardWidth = 200;
    if (products == null) products = [];

    return SizedBox(
      height: cardHeight,
      child: Swiper(
        itemCount: products.length,
        itemBuilder: (_, index) {
          return ProductCard(
              height: cardHeight, width: cardWidth, product: products[index]);
        },
        scale: 0.6,
        controller: swiperController,
        viewportFraction: 0.6,
        loop: false,
        fade: 0.4,
        pagination: SwiperCustomPagination(
          builder: (context, config) {
            if (config.itemCount > 20) {
              print(
                  "The itemCount is too big, we suggest use FractionPaginationBuilder instead of DotSwiperPaginationBuilder in this sitituation");
            }
            Color activeColor = kPrimaryAccentColor;
            Color color = Colors.grey[300];
            double size = 10.0;
            double space = 5.0;

            if (config.indicatorLayout != PageIndicatorLayout.NONE &&
                config.layout == SwiperLayout.DEFAULT) {
              return new PageIndicator(
                count: config.itemCount,
                controller: config.pageController,
                layout: config.indicatorLayout,
                size: size,
                activeColor: activeColor,
                color: color,
                space: space,
              );
            }

            List<Widget> dots = [];

            int itemCount = config.itemCount;
            int activeIndex = config.activeIndex;

            for (int i = 0; i < itemCount; ++i) {
              bool active = i == activeIndex;
              dots.add(Container(
                key: Key("pagination_$i"),
                margin: EdgeInsets.all(space),
                child: ClipOval(
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: active ? activeColor : color,
                    ),
                    width: size,
                    height: size,
                  ),
                ),
              ));
            }

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: dots,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final GreetCard product;
  final double height;
  final double width;

  const ProductCard({Key key, this.product, this.height, this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
//      onTap: () => Navigator.of(context).push(MaterialPageRoute(
//        builder: (_) => ProductPage(product: product),
//      )),
      child: Stack(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(left: 0),
            height: height,
            width: width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(25)),
              color: kPrimaryAccentColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.local_florist),
                  onPressed: () {},
                  color: Colors.white,
                ),
                Align(
                    alignment: Alignment.center,
                    child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 20),
                        child: H3(
                          textBody: product.name ?? '',
                          color: Colors.white,
                        )))
              ],
            ),
          ),
          Positioned(
            left: 50,
            top: 10,
            child: Hero(
              tag: product.image,
              child: Image.asset(
                product.image ?? '',
                height: height / 2,
                width: width / 2,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
