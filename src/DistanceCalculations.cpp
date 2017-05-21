#include <Rcpp.h>
#include "spdt.h"
using namespace Rcpp;



//double toRadians(double deg);
//double toDegrees(double rad);
//double normaliseLonDeg(double deg);

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

		latf = spdt::toRadians(latFrom[i]);
		lonf = spdt::toRadians(lonFrom[i]);

		bear = spdt::toRadians(bearing[i]);
		phi = ( distance[i] / earthRadius );

		latt = asin( ( sin(latf) * cos(phi) ) + ( cos(latf) * sin(phi) * cos(bear) ) );
		lont = lonf + ( atan2( sin(bear) * sin(phi) * cos(latf), cos(phi) - ( sin(latf) * sin(latt) ) ) );

		destinationLat[i] = spdt::toDegrees(latt);
		destinationLon[i] = spdt::toDegrees(lont);
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

		latf = spdt::toRadians(latFrom[i]);
		lonf = spdt::toRadians(lonFrom[i]);
		latt = spdt::toRadians(latTo[i]);
		lont = spdt::toRadians(lonTo[i]);

		Bx = cos(latt) * cos(lont - lonf);
		By = cos(latt) * sin(lont - lonf);

		theta = atan2(sin(latf) + sin(latt), sqrt( ( pow(cos(latf) + Bx, 2.0) + pow(By, 2.0) ) ) );
		lambda = lonf + atan2(By, cos(latf) + Bx);

		midpointLat[i] = spdt::toDegrees(theta);
		midpointLon[i] = spdt::normaliseLonDeg(spdt::toDegrees(lambda));

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

	double x;
	double y;

	double b;

	for(int i = 0; i < n; i++){

		latf = spdt::toRadians(latFrom[i]);
		lonf = spdt::toRadians(lonFrom[i]);
		latt = spdt::toRadians(latTo[i]);
		lont = spdt::toRadians(lonTo[i]);

		y = sin(lont - lonf) * cos(latt);
		x = ( cos(latf) * sin(latt) ) - ( sin(latf) * cos(latt) * cos(lont - lonf) );

		if(compassBearing == TRUE){
			b = (spdt::toDegrees(atan2(y, x)) + 360);
			// % operator is for integers
			// fmod() is for doubles
			b = fmod(b, 360);
		}else{
			b = spdt::toDegrees(atan2(y, x));
		}
		bearing[i] = b;
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
	double dlat;
	double dlon;

	double d;

	for(int i = 0; i < n; i++){

		latf = spdt::toRadians(latFrom[i]);
		lonf = spdt::toRadians(lonFrom[i]);
		latt = spdt::toRadians(latTo[i]);
		lont = spdt::toRadians(lonTo[i]);

		dlat = latt - latf;
		dlon = lont - lonf;

		d = (sin(dlat/2) * sin(dlat/2)) + (cos(latf) * cos(latt)) * (sin(dlon/2) * sin(dlon/2));
		if(d > 1 && d <= tolerance){
			d = 1;
		}
		d = 2 * atan2(sqrt(d), sqrt(1 - d)) * earthRadius;

		distance[i] = d;
	}

	return distance;

}



