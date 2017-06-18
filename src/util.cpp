#include <Rcpp.h>
#include "spdt.h"

using namespace Rcpp;


void vectorCheck(NumericVector v1, NumericVector v2){
	if(v1.size() != v2.size()){
		stop("Vector lengths differ");
	}
}

double toRadians(double deg){
	return deg * 0.01745329;
}

double toDegrees(double rad){
	return rad * 57.29578;
}

double normaliseLonDeg(double deg){
	return fmod(deg - 180.0, 360.0) + 180.0;
}

