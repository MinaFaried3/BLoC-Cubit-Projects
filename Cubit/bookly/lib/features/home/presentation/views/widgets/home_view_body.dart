import 'package:bookly/core/utils/assets.dart';
import 'package:bookly/core/utils/styles.dart';
import 'package:bookly/features/home/presentation/views/widgets/featured_list_view.dart';
import 'package:flutter/material.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const FeaturedBooksListView(),
        SizedBox(
          height: height * 0.07,
        ),
        const Text(
          'Best Seller',
          style: Styles.textStyle18,
        ),
        BestSellerItem()
      ],
    );
  }
}

class BestSellerItem extends StatelessWidget {
  const BestSellerItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * 0.009,
          horizontal: MediaQuery.of(context).size.width * 0.07),
      child: Row(
        children: [
          Expanded(
              flex: 1,
              child: Image.asset(
                AssetsData.testImage,
                fit: BoxFit.cover,
              )),
          SizedBox(
            width: 10,
          ),
          Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Harry Potter and the Goblet of Fire",
                    style: Styles.textStyle20,
                    maxLines: 2,
                  ),
                  Text(
                    "J.K Rowling",
                    style: Styles.textStyle20.copyWith(color: Colors.white54),
                  ),
                  Row(
                    children: [
                      const Text(
                        "19.99 \$",
                        style: Styles.textStyle24,
                      ),
                      const Spacer(),
                      const Icon(
                        Icons.star,
                        color: Colors.yellow,
                      ),
                      RichText(
                          text: TextSpan(children: [
                        const TextSpan(text: '4.8 ', style: Styles.textStyle20),
                        TextSpan(
                          text: '(2569)',
                          style: Styles.textStyle20
                              .copyWith(color: Colors.white54),
                        ),
                      ]))
                    ],
                  )
                ],
              )),
        ],
      ),
    );
  }
}
