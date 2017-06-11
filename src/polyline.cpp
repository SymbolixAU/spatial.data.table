#include <Rcpp.h>
#include "util.h"
using namespace Rcpp;


// [[Rcpp::export]]
DataFrame rcppSimplifyPolyline(DataFrame df, double distanceTolerance,
                           double tolerance, double earthRadius){
	// vertex cluster reduction

	// TODO:
	// - at least keep the first and last points

	int keepCounter = 0;
	int n = df.nrows() - 1;
	bool allGone = false;

	NumericVector lats = df["lat"];
	NumericVector lons = df["lon"];

	// I'm pre-allocating the length - then will only return those that are kept
	NumericVector keepLat(n);
	NumericVector keepLon(n);

	// loop over the data.frame points
	// only 'keep' those that are outside the tolerance range
	for (int i = 0; i < n; i++){

		if(distanceHaversine(lats[i], lons[i], lats[i + 1], lons[i + 1], tolerance, earthRadius) > distanceTolerance){
			keepLat[keepCounter] = lats[i];
			keepLon[keepCounter] = lons[i];
			keepCounter++;
		}
	}

	// if nothing has been kept; at least keep the first and last
	if(keepCounter == 0){
		allGone = true;
		keepCounter = 2;
	}

	NumericVector outLat(keepCounter);
	NumericVector outLon(keepCounter);

	//Rcpp::Rcout << keepCounter << std::endl;

	if(allGone){
		IntegerVector idx = IntegerVector::create(0, 1);
		outLat = lats[idx];
		outLon = lons[idx];
	}else{

		for (int i = 0; i < keepCounter; i++) {
			outLat[i] = keepLat[i];
			outLon[i] = keepLon[i];
			//Rcpp::Rcout << outLat[i] << std::endl;
		}
	}

	return DataFrame::create(Named("lat") = outLat, Named("lon") = outLon);
}





