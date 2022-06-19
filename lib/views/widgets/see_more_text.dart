import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readmore/readmore.dart';

class ExpandableText extends StatefulWidget {
  const ExpandableText({
    Key? key,
    required this.data,
    this.style,
  }) : super(key: key);

  final String data;
  final TextStyle? style;

  @override
  _ExpandableTextState createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  static const defaultLines = 4;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, size) {
      final span = TextSpan(text: widget.data, style: widget.style);
      final tp = TextPainter(
          text: span, textDirection: TextDirection.ltr, maxLines: defaultLines);
      tp.layout(maxWidth: size.maxWidth);

      if (tp.didExceedMaxLines) {
        return ReadMoreText(widget.data,
            trimLines: defaultLines,
            style: GoogleFonts.heebo(
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                color: Colors.white),
            colorClickableText: Colors.pink,
            trimMode: TrimMode.Line,
            trimCollapsedText: 'Show more',
            trimExpandedText: 'Show less',
            moreStyle: GoogleFonts.heebo(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
            lessStyle: GoogleFonts.heebo(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: Colors.white));
      } else {
        return Text(
          widget.data,
          style: GoogleFonts.heebo(
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: Colors.white),
        );
      }
    });
  }
}
