#include <Rcpp.h>
#include "util.h"
using namespace Rcpp;


// [[Rcpp::export]]
NumericVector rcppAlongTrack(NumericVector latFrom, NumericVector lonFrom,
                             NumericVector latTo, NumericVector lonTo,
                             NumericVector pointLat, NumericVector pointLon,
                             double tolerance, double earthRadius){

	int n = latFrom.size();
	NumericVector distance(n);

	double plat;
	double plon;
	double latf;
	double lonf;
	double latt;
	double lont;

	double xtrack;
	double d;
	double b1;
	double b2;

	for(int i = 0; i < n; i++){

		plat = toRadians(pointLat[i]);
		plon = toRadians(pointLon[i]);
		latf = toRadians(latFrom[i]);
		lonf = toRadians(lonFrom[i]);
		latt = toRadians(latTo[i]);
		lont = toRadians(lonTo[i]);

		// (angular) distance from start-point (on path) to the point
		d = distanceHaversine(latf, lonf, plat, plon, tolerance, earthRadius);
		d = d / earthRadius;

		// initial bearing from start-point (on path) to point
		b1 = bearingCalc(latf, lonf, plat, plon, true);
		b1 = toRadians(b1);

		// initial bearing from start-point (on path) to end-point (on path)
		b2 = bearingCalc(latf, lonf, latt, lont, true);
		b2 = toRadians(b2);

		xtrack =  crossTrack(d, b1, b2, earthRadius);

		distance[i] = alongTrack(d, xtrack, earthRadius);
	}

	return distance;

}


// [[Rcpp::export]]
NumericVector rcppDist2gc(NumericVector latFrom, NumericVector lonFrom,
                          NumericVector latTo, NumericVector lonTo,
                          NumericVector pointLat, NumericVector pointLon,
                          double tolerance, double earthRadius){

	int n = latFrom.size();
	NumericVector distance(n);

	double plat;
	double plon;
	double latf;
	double lonf;
	double latt;
	double lont;

	double d;
	double b1;
	double b2;

	for(int i = 0; i < n; i++){

		plat = toRadians(pointLat[i]);
		plon = toRadians(pointLon[i]);
		latf = toRadians(latFrom[i]);
		lonf = toRadians(lonFrom[i]);
		latt = toRadians(latTo[i]);
		lont = toRadians(lonTo[i]);

		// (angular) distance from start-point (on path) to the point
		d = distanceHaversine(latf, lonf, plat, plon, tolerance, earthRadius);
		d = d / earthRadius;

		// initial bearing from start-point (on path) to point
		b1 = bearingCalc(latf, lonf, plat, plon, true);
		b1 = toRadians(b1);

		// initial bearing from start-point (on path) to end-point (on path)
		b2 = bearingCalc(latf, lonf, latt, lont, true);
		b2 = toRadians(b2);

		//distance[i] = asin( sin(d) * sin(b1 - b2) ) * earthRadius;
		distance[i] = crossTrack(d, b1, b2, earthRadius);
	}

	return distance;
}



// [[Rcpp::export]]
Rcpp::List rcppDestination(NumericVector latFrom, NumericVector lonFrom,
                           NumericVector distance, NumericVector bearing,
                           double earthRadius){

  int n = latFrom.size();
	NumericVector destinationLat(n);
	NumericVector destinationLon(n);

	double latf;
	double lonf;

	double latt;
	double lont;

	double phi;
	double bear;

	for(int i = 0; i < n; i++){

		latf = toRadians(latFrom[i]);
		lonf = toRadians(lonFrom[i]);

		bear = toRadians(bearing[i]);
		phi = ( distance[i] / earthRadius );

		latt = asin( ( sin(latf) * cos(phi) ) + ( cos(latf) * sin(phi) * cos(bear) ) );
		lont = lonf + ( atan2( sin(bear) * sin(phi) * cos(latf), cos(phi) - ( sin(latf) * sin(latt) ) ) );

		destinationLat[i] = toDegrees(latt);
		destinationLon[i] = toDegrees(lont);
	}

	return Rcpp::List::create(destinationLat, destinationLon);
}


// [[Rcpp::export]]
Rcpp::List rcppMidpoint(NumericVector latFrom, NumericVector lonFrom,
                           NumericVector latTo, NumericVector lonTo){

	int n = latFrom.size();
//	NumericMatrix midpoint(n, 2);
	NumericVector midpointLat(n);
	NumericVector midpointLon(n);

	double latf;
	double latt;
	double lonf;
	double lont;

	double Bx;
	double By;

	double theta;
	double lambda;

	for(int i = 0; i < n; i++){

		latf = toRadians(latFrom[i]);
		lonf = toRadians(lonFrom[i]);
		latt = toRadians(latTo[i]);
		lont = toRadians(lonTo[i]);

		Bx = cos(latt) * cos(lont - lonf);
		By = cos(latt) * sin(lont - lonf);

		theta = atan2(sin(latf) + sin(latt), sqrt( ( pow(cos(latf) + Bx, 2.0) + pow(By, 2.0) ) ) );
		lambda = lonf + atan2(By, cos(latf) + Bx);

		midpointLat[i] = toDegrees(theta);
		midpointLon[i] = normaliseLonDeg(toDegrees(lambda));

	}

	return Rcpp::List::create(midpointLat, midpointLon);

}


// [[Rcpp::export]]
NumericVector rcppBearing(NumericVector latFrom, NumericVector lonFrom,
                          NumericVector latTo, NumericVector lonTo,
                          bool compassBearing){


	int n = latFrom.size();
	NumericVector bearing(n);

	double latf;
	double latt;
	double lonf;
	double lont;

	for(int i = 0; i < n; i++){

		latf = toRadians(latFrom[i]);
		lonf = toRadians(lonFrom[i]);
		latt = toRadians(latTo[i]);
		lont = toRadians(lonTo[i]);

		bearing[i] = bearingCalc(latf, lonf, latt, lont, compassBearing);
	}

	return bearing;

}


// [[Rcpp::export]]
NumericVector rcppDistanceHaversine(NumericVector latFrom, NumericVector lonFrom,
                             NumericVector latTo, NumericVector lonTo,
                         double earthRadius, double tolerance) {

	int n = latFrom.size();
	NumericVector distance(n);

	double latf;
	double latt;
	double lonf;
	double lont;

	for(int i = 0; i < n; i++){

		latf = toRadians(latFrom[i]);
		lonf = toRadians(lonFrom[i]);
		latt = toRadians(latTo[i]);
		lont = toRadians(lonTo[i]);

		distance[i] = distanceHaversine(latf, lonf, latt, lont, tolerance, earthRadius);
	}

	return distance;

}



