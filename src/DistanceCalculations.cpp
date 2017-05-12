#include <Rcpp.h>
using namespace Rcpp;

double toRadians(double deg);
double toDegrees(double rad);

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

		theta = atan2(sin(latf) + sin(latt), sqrt( ( (cos(latf) + Bx) * (cos(latf) + Bx) + (By*By) ) ) );
		lambda = lonf + atan2(By, cos(latf) + Bx);

//		midpoint[i, 1] = toDegrees(theta);
//		midpoint[i, 2] = toDegrees(lambda)
		midpointLat[i] = toDegrees(theta);
		midpointLon[i] = toDegrees(lambda);

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

		latf = toRadians(latFrom[i]);
		lonf = toRadians(lonFrom[i]);
		latt = toRadians(latTo[i]);
		lont = toRadians(lonTo[i]);

		y = sin(lont - lonf) * cos(latt);
		x = ( cos(latf) * sin(latt) ) - ( sin(latf) * cos(latt) * cos(lont - lonf) );

		if(compassBearing == TRUE){
			b = (toDegrees(atan2(y, x)) + 360);
			// % operator is for integers
			// fmod() is for doubles
			b = fmod(b, 360);
		}else{
			b = toDegrees(atan2(y, x));
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

		latf = toRadians(latFrom[i]);
		lonf = toRadians(lonFrom[i]);
		latt = toRadians(latTo[i]);
		lont = toRadians(lonTo[i]);

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


double toRadians(double deg){
	return deg * (M_PI / 180);
}

double toDegrees(double rad){
	return rad / (M_PI / 180);
}
