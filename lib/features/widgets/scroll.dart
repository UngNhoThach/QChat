import 'package:flutter/cupertino.dart';

class BouncingAndAlwaysScrollPhysics extends ScrollPhysics {
  const BouncingAndAlwaysScrollPhysics({ScrollPhysics? parent})
      : super(parent: parent);

  @override
  BouncingAndAlwaysScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return BouncingAndAlwaysScrollPhysics(parent: buildParent(ancestor));
  }

  @override
  double applyBoundaryConditions(ScrollMetrics position, double value) {
    if (value <= position.pixels &&
        position.pixels <=
            position
                .minScrollExtent) // Điều kiện cuộn lên trên khi ở đầu danh sách
      return value - position.pixels;
    if (value >= position.pixels &&
        position.pixels >=
            position
                .maxScrollExtent) // Điều kiện cuộn xuống dưới khi ở cuối danh sách
      return value - position.pixels;
    if (position.pixels > position.maxScrollExtent &&
        value >
            position
                .maxScrollExtent) // Điều kiện cuộn khi đã cuộn xuống dưới cùng và vẫn muốn cuộn xuống hơn
      return value - position.maxScrollExtent;
    if (position.pixels < position.minScrollExtent &&
        value <
            position
                .minScrollExtent) // Điều kiện cuộn khi đã cuộn lên trên cùng và vẫn muốn cuộn lên trên hơn
      return value - position.minScrollExtent;
    return 0.0;
  }
}
