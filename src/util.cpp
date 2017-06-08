#include <Rcpp.h>
using namespace Rcpp;

// -------------------------------------------
//
// utility functions for spatial.data.table
//
// -------------------------------------------

// -----------------------------------------------------------------------------
double toRadians(double deg){
	return deg * (M_PI / 180);
}

// -----------------------------------------------------------------------------
double toDegrees(double rad){
	return rad / (M_PI / 180);
}

// -----------------------------------------------------------------------------
double normaliseLonDeg(double deg){
	return fmod(deg - 180.0, 360.0) + 180.0;
}

// -----------------------------------------------------------------------------
double distanceHaversine(double latf, double lonf, double latt, double lont,
                         double tolerance, double earthRadius){
	double d;
	double dlat;
	double dlon;

	dlat = latt - latf;
	dlon = lont - lonf;

	d = (sin(dlat/2) * sin(dlat/2)) + (cos(latf) * cos(latt)) * (sin(dlon/2) * sin(dlon/2));
	if(d > 1 && d <= tolerance){
		d = 1;
	}
	d = 2 * atan2(sqrt(d), sqrt(1 - d)) * earthRadius;

	return d;
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


Rcpp::NumericMatrix minPointToVec(double x, double y,
                                  NumericVector vecX, NumericVector vecY,
                                  double tolerance, double earthRadius){
	// calculates the nearest value between a point and a vector
	int n = vecX.size();
	NumericVector distances(n);
	NumericMatrix res(1, 2);

	for(int i = 0; i < n; i ++){
		distances[i] = distanceHaversine(x, y, vecX[i], vecY[i],	tolerance, earthRadius);
		//Rcpp::Rcout << distances(i) <<  std::endl;
	}
	res(0, 0) = which_min(distances) + 1;
	res(0, 1) = min(distances);

	return res;
}

