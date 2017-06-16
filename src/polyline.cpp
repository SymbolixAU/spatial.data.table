
//#include <RcppArmadillo.h>
#include "util.h"
#include "spdt.h"

//[[Rcpp::depends(RcppArmadillo)]]
using namespace Rcpp;
using namespace spdt;

DataFrame rcpp_decode_pl( std::string encoded );
Rcpp::String rcpp_encode_pl(Rcpp::NumericVector latitude,
                            Rcpp::NumericVector longitude,
                            int num_coords);

// Douglas Peucker
// needs to operate on earth (oblate spheroid)
// the algorithm will record the indices to keep,
// then subset the original polyline by those indeces
// the index array will be created with 0s
// then can filter out quite easily those that are greater than 0

void cppDouglasPeucker(NumericVector lats, NumericVector lons, int firstIndex, int lastIndex,
                       float distanceTolerance, LogicalVector& keepIndex){

	int pathLength = lats.size();
	int thisIndex = firstIndex;
	float maxDistance = 0.0;
	float thisDistance;
	double startLat = lats[firstIndex];
	double startLon = lons[firstIndex];
	double endLat = lats[lastIndex];
	double endLon = lons[lastIndex];

	if(pathLength < 3){
		// return points
	}

	if(lastIndex < firstIndex){
		// empty
	}else if(lastIndex == firstIndex){
		keepIndex[firstIndex] = true;
	}else{
		keepIndex[firstIndex] = true;

		for(int i = firstIndex + 1; i < lastIndex; i++){

			// start & end are the coordinates of the end pionts of the track
			// lats[i]/lons[i] are the cooridnates of the POINT of interest

			// abs() called as the sign of the distance matters
			thisDistance = fabs(rcppDist2gc(startLat, startLon, endLat, endLon, lats[i], lons[i],
	                             distanceTolerance, EARTH_RADIUS));

			if(thisDistance > maxDistance){
				maxDistance = thisDistance;
				thisIndex = i;
			}
		}
		if(maxDistance > distanceTolerance){
			// we've found a point.
			// Now recurse back into the algorithm to find another
			keepIndex[thisIndex] = true;
			cppDouglasPeucker(lats, lons, firstIndex, thisIndex, distanceTolerance, keepIndex);
			cppDouglasPeucker(lats, lons, thisIndex, lastIndex, distanceTolerance, keepIndex);
		}
	}
}

// [[Rcpp::export]]
std::string rcppDouglasPeucker(std::string polyline, double distanceTolerance){
//DataFrame rcppDouglasPeucker(NumericVector lats, NumericVector lons, int firstIndex, int lastIndex,
//                      float distanceTolerance){

	DataFrame df = rcpp_decode_pl(polyline);
	NumericVector lats = df["lat"];
	NumericVector lons = df["lon"];
	int firstIndex = 1;
	int lastIndex = df.nrow();

	int n = lats.size();
	LogicalVector keepIndex(n);

	Rcpp::Rcout << "lats: " << lats.size() << std::endl;
	Rcpp::Rcout << "lons: " << lons.size() << std::endl;

	Rcpp::Rcout << "firstIndex: " << firstIndex << std::endl;
	Rcpp::Rcout << "lastIndex: " << lastIndex << std::endl;

	cppDouglasPeucker(lats, lons, firstIndex, lastIndex, distanceTolerance, keepIndex);

	// keepIndex is now a logical vector of all the indices of the lats/lons to keep
	//return DataFrame::create(Named("lat") = lats[keepIndex], Named("lon") = lons[keepIndex]);
	return rcpp_encode_pl(lats[keepIndex], lons[keepIndex], lats.size());
}


// [[Rcpp::export]]
DataFrame rcppSimplifyPolyline(std::string polyline, double distanceTolerance,
                               double tolerance, double earthRadius){
// DataFrame rcppSimplifyPolyline(DataFrame df, double distanceTolerance,
//                            double tolerance, double earthRadius){

	// vertex cluster reduction
  DataFrame df = rcpp_decode_pl(polyline);

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

	if(allGone){
    outLat[0] = lats[0];
		outLat[1] = lats[1];
		outLon[0] = lons[0];
		outLon[1] = lons[1];
	}else{

		for (int i = 0; i < keepCounter; i++) {
			outLat[i] = keepLat[i];
			outLon[i] = keepLon[i];
		}
	}

	return DataFrame::create(Named("lat") = outLat, Named("lon") = outLon);
}





