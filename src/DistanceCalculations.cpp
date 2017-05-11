#include <Rcpp.h>
using namespace Rcpp;

double toRadians(double deg);
double toDegrees(double rad);

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
