import 'dart:js';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:minimal/components/color.dart';
import 'package:minimal/components/spacing.dart';
import 'package:minimal/components/text.dart';
import 'package:minimal/components/typography.dart';
import 'package:minimal/models/header_model.dart';
import 'package:minimal/routes.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../utils/globals.dart';

class ImageWrapper extends StatelessWidget {
  const ImageWrapper({Key? key, required this.image}) : super(key: key);

  final String image;

  @override
  Widget build(BuildContext context) {
    //TODO Listen to inherited widget width updates.
    double width = MediaQuery.of(context).size.width;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 24),
      child: Image.asset(
        image,
        width: width,
        height: width / 1.618,
        fit: BoxFit.cover,
      ),
    );
  }
}

class TagWrapper extends StatelessWidget {
  const TagWrapper({Key? key, this.tags = const []}) : super(key: key);

  final List<Tag> tags;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: paddingBottom24,
        child: Wrap(
          spacing: 8,
          runSpacing: 0,
          children: <Widget>[...tags],
        ));
  }
}

class Tag extends StatelessWidget {
  const Tag({Key? key, required this.tag}) : super(key: key);

  final String tag;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: () {},
      fillColor: const Color(0xFF242424),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      elevation: 0,
      hoverElevation: 0,
      hoverColor: const Color(0xFFC7C7C7),
      highlightElevation: 0,
      focusElevation: 0,
      child: Text(
        tag,
        style: GoogleFonts.openSans(color: Colors.white, fontSize: 14),
      ),
    );
  }
}

class ReadMoreButton extends StatelessWidget {
  const ReadMoreButton({Key? key, required this.onPressed}) : super(key: key);

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.all<Color>(textPrimary),
        side: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.focused) ||
              states.contains(MaterialState.hovered) ||
              states.contains(MaterialState.pressed)) {
            return const BorderSide(color: textPrimary, width: 2);
          }

          return const BorderSide(color: textPrimary, width: 2);
        }),
        foregroundColor: MaterialStateProperty.resolveWith<Color>((states) {
          if (states.contains(MaterialState.focused) ||
              states.contains(MaterialState.hovered) ||
              states.contains(MaterialState.pressed)) {
            return Colors.white;
          }

          return textPrimary;
        }),
        textStyle: MaterialStateProperty.resolveWith<TextStyle>((states) {
          if (states.contains(MaterialState.focused) ||
              states.contains(MaterialState.hovered) ||
              states.contains(MaterialState.pressed)) {
            return GoogleFonts.montserrat(
              textStyle: const TextStyle(
                fontSize: 14,
                color: Colors.white,
                letterSpacing: 1,
              ),
            );
          }

          return GoogleFonts.montserrat(
            textStyle: const TextStyle(
                fontSize: 14, color: textPrimary, letterSpacing: 1),
          );
        }),
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
          const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        ),
      ),
      child: const Text(
        "READ MORE",
      ),
    );
  }
}

const Widget divider = Divider(
  color: Color(0xFFEEEEEE),
  thickness: 1,
);

Widget dividerSmall = Container(
  width: 40,
  decoration: const BoxDecoration(
    border: Border(
      bottom: BorderSide(
        color: Color(0xFFA0A0A0),
        width: 1,
      ),
    ),
  ),
);

List<Widget> authorSection({
  String? imageUrl,
  String? name,
  String? bio,
}) {
  return [
    divider,
    Container(
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: Row(
        children: <Widget>[
          if (imageUrl != null)
            Container(
              margin: const EdgeInsets.only(right: 25),
              child: Material(
                shape: const CircleBorder(),
                clipBehavior: Clip.hardEdge,
                color: Colors.transparent,
                child: Image.asset(
                  imageUrl,
                  width: 100,
                  height: 100,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          Expanded(
            child: Column(
              children: <Widget>[
                if (name != null)
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextHeadlineSecondary(text: name),
                  ),
                if (bio != null)
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      bio,
                      style: bodyTextStyle,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    ),
    divider,
  ];
}

class PostNavigation extends StatelessWidget {
  const PostNavigation({Key? key}) : super(key: key);

  // TODO Get PostID from Global Routing Singleton.
  // Example: String currentPage = RouteController.of(context).currentPage;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          children: <Widget>[
            const Icon(
              Icons.keyboard_arrow_left,
              size: 25,
              color: textSecondary,
            ),
            Text("PREVIOUS POST", style: buttonTextStyle),
          ],
        ),
        const Spacer(),
        Row(
          children: <Widget>[
            Text("NEXT POST", style: buttonTextStyle),
            const Icon(
              Icons.keyboard_arrow_right,
              size: 25,
              color: textSecondary,
            ),
          ],
        )
      ],
    );
  }
}

class ListNavigation extends StatelessWidget {
  const ListNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          children: <Widget>[
            const Icon(
              Icons.keyboard_arrow_left,
              size: 25,
              color: textSecondary,
            ),
            Text("NEWER POSTS", style: buttonTextStyle),
          ],
        ),
        const Spacer(),
        Row(
          children: <Widget>[
            Text("OLDER POSTS", style: buttonTextStyle),
            const Icon(
              Icons.keyboard_arrow_right,
              size: 25,
              color: textSecondary,
            ),
          ],
        )
      ],
    );
  }
}

class Footer extends StatelessWidget {
  const Footer({Key? key}) : super(key: key);

  // TODO Add additional footer components (i.e. about, links, logos).
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: const Align(
        alignment: Alignment.centerRight,
        child: TextBody(text: "Copyright © 2022"),
      ),
    );
  }
}

class ListItem extends StatelessWidget {
  const ListItem({
    Key? key,
    required this.title,
    this.imageUrl,
    this.description,
  }) : super(key: key);

  final String? description;
  final String? imageUrl;
  // TODO replace with Post item model.
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        if (imageUrl != null)
          ImageWrapper(
            image: imageUrl!,
          ),
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            margin: marginBottom12,
            child: Text(
              title,
              style: headlineTextStyle,
            ),
          ),
        ),
        if (description != null)
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              margin: marginBottom12,
              child: Text(
                description!,
                style: bodyTextStyle,
              ),
            ),
          ),
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            margin: marginBottom24,
            child: ReadMoreButton(
              onPressed: () => Navigator.pushNamed(context, Routes.post),
            ),
          ),
        ),
      ],
    );
  }
}

// ignore: slash_for_doc_comments
/**
 * Menu/Navigation Bar
 *
 * A top menu bar with a text or image logo and
 * navigation links. Navigation links collapse into
 * a hamburger menu on screens smaller than 400px.
 */

List<HeaderItem> headerItems = [
  HeaderItem(title: 'HOME', onTap: () {}),
  HeaderItem(title: 'PORTFOLIO', onTap: () {}),
  HeaderItem(title: 'STYLE', onTap: () {}),
  HeaderItem(title: 'ABOUT', onTap: () {}),
  HeaderItem(title: 'CONTACT', onTap: () {}),
];

Widget headerLogo(BuildContext context) {
  return SizedBox(
    child: MouseRegion(
      cursor: SystemMouseCursors.click,
      child: InkWell(
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        onTap: () => Navigator.popUntil(
          context,
          ModalRoute.withName(Navigator.defaultRouteName),
        ),
        child: Text(
          "MINIMAL",
          style: GoogleFonts.montserrat(
            color: textPrimary,
            fontSize: ResponsiveValue(
              context,
              defaultValue: 30,
              valueWhen: [
                const Condition.equals(name: TABLET, value: 20.0),
                const Condition.largerThan(name: TABLET, value: 35)
              ],
            ).value!.toDouble(),
            letterSpacing: 3,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    ),
  );
}

Widget headerRow(BuildContext context) {
  return ResponsiveVisibility(
    visible: false,
    visibleWhen: const [
      Condition.largerThan(name: MOBILE),
    ],
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: headerItems.map(
        (headerItem) {
          return MouseRegion(
            cursor: SystemMouseCursors.click,
            child: Container(
              margin: const EdgeInsets.only(right: 30.0),
              child: GestureDetector(
                onTap: headerItem.title == 'HOME'
                    ? () => Navigator.popUntil(
                          context,
                          ModalRoute.withName(Navigator.defaultRouteName),
                        )
                    : headerItem.title == 'STYLE'
                        ? () => Navigator.pushNamed(context, Routes.style)
                        : headerItem.onTap,
                child: Text(
                  headerItem.title,
                  style: GoogleFonts.montserrat(
                    color: textPrimary,
                    fontSize: ResponsiveValue(
                      context,
                      defaultValue: 10,
                      valueWhen: [
                        const Condition.largerThan(name: MOBILE, value: 13),
                        const Condition.largerThan(name: TABLET, value: 17)
                      ],
                    ).value!.toDouble(),
                    letterSpacing: 3,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          );
        },
      ).toList(),
    ),
  );
}

class MenuBar extends StatelessWidget {
  const MenuBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.symmetric(vertical: 30),
          child: Row(
            children: <Widget>[
              headerLogo(context),
              const Spacer(),
              const HeaderMenuTile(),
              headerRow(context),

              //   visible: false,
              //   visibleWhen: const [
              //     Condition.largerThan(name: MOBILE),
              //     Condition.largerThan(name: TABLET),
              //     Condition.largerThan(name: DESKTOP),
              //   ],
              //   child: Flexible(
              //     child: Container(
              //       alignment: Alignment.centerRight,
              //       child: Wrap(
              //         children: <Widget>[
              //           TextButton(
              //             onPressed: () => Navigator.popUntil(
              //
              //             ),
              //             style: menuButtonStyle,
              //             child: const Text(
              //               "HOME",
              //             ),
              //           ),
              //           TextButton(
              //             onPressed: () {},
              //             style: menuButtonStyle,
              //             child: const Text(
              //               "PORTFOLIO",
              //             ),
              //           ),
              //           TextButton(
              //             onPressed: ,
              //             style: menuButtonStyle,
              //             child: const Text(
              //               "STYLE",
              //             ),
              //           ),
              //           TextButton(
              //             onPressed: () {},
              //             style: menuButtonStyle,
              //             child: const Text(
              //               "ABOUT",
              //             ),
              //           ),
              //           TextButton(
              //             onPressed: () {},
              //             style: menuButtonStyle,
              //             child: const Text(
              //               "CONTACT",
              //             ),
              //           ),
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
        Container(
          height: 1,
          margin: const EdgeInsets.only(bottom: 30),
          color: const Color(0xFFEEEEEE),
        ),
      ],
    );
  }
}

class HeaderMenuTile extends StatelessWidget {
  const HeaderMenuTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveVisibility(
      hiddenWhen: const [
        Condition.largerThan(name: MOBILE),
      ],
      child: IconButton(
        onPressed: () {
          Globals.scaffoldKey.currentState!.openEndDrawer();
        },
        icon: const Icon(Icons.menu),
      ),
    );
  }
}
