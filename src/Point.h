#ifndef POINT_H
#define POINT_H
#endif

class Point {

private:
	double xval, yval;

public:
	// Constructor uses default arguments to allow calling with zero, one,
	// or two values.
	Point(double x = 0.0, double y = 0.0) {
		xval = x;
		yval = y;
	}

	// Extractors.
	double x() { return xval; }
	double y() { return yval; }


};
