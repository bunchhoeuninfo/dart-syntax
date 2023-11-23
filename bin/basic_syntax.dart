import 'dart:math' show Random;

void main() async {
  print('compute II using the Monte Carlo method.');
  await for (final estimate in computePi().take(100)) {
    print('pi =~ $estimate');

  }
}

//Generate a stream of increasingly accurate esitmates of II...
Stream<double> computePi({int batch = 10000}) async* {
  var total = 0; //Inferred to be of type int
  var count = 0;

  while (true) {
    final points = generateRandom().take(batch);
    final inside = points.where((p) => p.isInsideUnitCircle);

    total += batch;
    count += inside.length;
    final ratio = count / total;

    yield ratio * 4;

  }
}

Iterable<Point> generateRandom([int? seed]) sync* {
  final random = Random(seed);
  while (true) {
    yield Point(random.nextDouble(), random.nextDouble());
  }
}

class Point {
  final double x;
  final double y;

  const Point(this.x, this.y);

  bool get isInsideUnitCircle => x * x + y * y <= 1;
}
