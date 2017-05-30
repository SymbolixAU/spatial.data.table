#include <Rcpp.h>
using namespace Rcpp;

// -------------------------------------------
//
// utility functions for spatial.data.table
//
// -------------------------------------------

// -----------------------------------------------------------------------------
double toRadians(double deg){
	//return deg * (M_PI / 180);
	return deg * 0.01745329;
}

// -----------------------------------------------------------------------------
double toDegrees(double rad){
	//return rad / (M_PI / 180);
	return rad * 57.29578;
}

// -----------------------------------------------------------------------------
double normaliseLonDeg(double deg){
	return fmod(deg - 180.0, 360.0) + 180.0;
}

// -----------------------------------------------------------------------------
double distanceHaversine(double latf, double lonf, double latt, double lont,
                         double tolerance, double earthRadius){
	double d;
	double dlat = latt - latf;
	double dlon =  lont - lonf;

	d = (sin(dlat * 0.5) * sin(dlat * 0.5)) + (cos(latf) * cos(latt)) * (sin(dlon * 0.5) * sin(dlon * 0.5));
	if(d > 1 && d <= tolerance){
		d = 1;
	}
	d = 2 * atan2(sqrt(d), sqrt(1 - d)) * earthRadius;

	return d;
}

// -----------------------------------------------------------------------------
double distanceCosine(double latf, double lonf, double latt, double lont,
                      double earthRadius){

	double dlon = lont - lonf;
	return (acos( sin(latf) * sin(latt) + cos(latf) * cos(latt) * cos(dlon) ) * earthRadius);

}

// -----------------------------------------------------------------------------
double bearingCalc(double latf, double lonf, double latt, double lont,
                   bool compassBearing){

	double b;
	double x;
	double y;

	y = sin(lont - lonf) * cos(latt);
	x = ( cos(latf) * sin(latt) ) - ( sin(latf) * cos(latt) * cos(lont - lonf) );

	if(compassBearing){
		b = (toDegrees(atan2(y, x)) + 360);
		b = fmod(b, 360);
	}else{
		b = toDegrees(atan2(y, x));
	}
	return b;
}

// -----------------------------------------------------------------------------
double crossTrack(double distance, double bearing1, double bearing2, double earthRadius){
	return (asin( sin(distance) * sin(bearing1 - bearing2)) * earthRadius);
}

// -----------------------------------------------------------------------------
double alongTrack(double distance, double xtrack, double earthRadius){
	return (acos( cos(distance) / cos(xtrack / earthRadius) ) * earthRadius);
}

// -----------------------------------------------------------------------------
double isLeft(double p0x, double p0y, double p1x, double p1y, double p2x, double p2y){
	return ((p1x - p0x) * (p2y - p0y) - (p2x - p0x) * (p1y - p0y));
}

// -----------------------------------------------------------------------------
bool isPolygonClosed(double startX, double endX, double startY, double endY){
	return (startX == endX && startY == endY);
}

// -----------------------------------------------------------------------------
Rcpp::NumericVector ClosePolygon(Rcpp::NumericVector polyVector){
	polyVector.push_back(polyVector[0]);
	return polyVector;
}



