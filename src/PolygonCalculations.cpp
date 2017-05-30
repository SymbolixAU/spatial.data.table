#include <Rcpp.h>
#include "util.h"
using namespace Rcpp;

// [[Rcpp::export]]
Rcpp::NumericVector rcppClosePolygon(Rcpp::NumericVector polyVector){
	double addToEnd = polyVector[0];
	polyVector.push_back(addToEnd);
	return polyVector;
}

// [[Rcpp::export]]
bool rcppIsPolygonClosed(double startX, double endX, double startY, double endY){
	return (startX == endX && startY == endY);
}

double rcppWindingNumber(double pointX, double pointY,
                         NumericVector vectorX, NumericVector vectorY);

// Comparing a data.table of points and a data.table of polygons
// - whcih points fall in which polygons
// - RETURN: a data.table of the pointIds and the associated polygonId that they'r ein

// METHOD:
// - for each polygon, check all points
// - the polygon data.table will have an "ID", and "lineId"
// - where does the loop get called?
// - send whole vector of data.table polyIds and lineIds;
// - need to find the unique IDs of the polygons,
// - then in cpp, need to subset the polygons....

// - using data.table, dt[, WindingNumber(lat, lon, dt_points), by = .(polyId, lineId)]
// - this will internally loop over each polygon, and call 'windingNumber'
// - for all the points


/**
 * rcpp Point In Polygon
 *
 * determins if a set of points are in a polygon
 */
// [[Rcpp::export]]
NumericVector rcppPointsInPolygon(NumericVector pointsId,
                                  NumericVector pointsX, NumericVector pointsY,
                                  NumericVector vectorX, NumericVector vectorY){

	int nPoints = pointsId.size();

	NumericVector pointsInPolygon;
//	NumericVector polygonId;
//	NumericVector lineId;

	//Rcpp::Rcout << "nPoints: " << nPoints << std::endl;

	for (int iPoint = 0; iPoint < nPoints; iPoint++){

		//Rcpp::Rcout << "testing " << pointsId[iPoint] << std::endl;

		if (rcppWindingNumber(pointsX[iPoint], pointsY[iPoint],
                        vectorX, vectorY) != 0 ){

			//Rcpp::Rcout << "result: true " << pointsId[iPoint] << std::endl;
			pointsInPolygon.push_back(pointsId[iPoint]);

			}
	}

	return pointsInPolygon;
	//return DataFrame::create(Named("polygonId") = polygonId,
  //                        Named("lineId") = lineId,
  //                        Named("pointId") = pointsInPolygon);
}

/**
 * Winding Number
 *
 * Calculates the winding number for a point and polygon
 *
 * @param pointX
 * @param pointY
 * @param vectorX numeric vector representing the x coordinates of a polygon
 * @param vectorY numeric vector representing the y coordinates of a polygon
 *
 */
// [[Rcpp::export]]
double rcppWindingNumber(double pointX, double pointY,
                     NumericVector vectorX, NumericVector vectorY){

	int windingNumber = 0;  // winding number counter
	int nVectorSize = vectorX.size() - 1;

	// check if the polygon is closed
	if(!isPolygonClosed(vectorX[0], vectorX[nVectorSize],
                       vectorY[0], vectorY[nVectorSize])){

		// close polygon
		vectorX = ClosePolygon(vectorX);
		vectorY = ClosePolygon(vectorY);
	}


	int n = vectorX.size() - 1; // number of rows of the polygon vector
	// compute winding number

	// loop all points in the polygon vector
	for (int i = 0; i < n; i++){
		if (vectorY[i] <= pointY){
			if (vectorY[i + 1] > pointY){
				if (isLeft(vectorX[i], vectorY[i], vectorX[i + 1], vectorY[i + 1], pointX, pointY) > 0){
					++windingNumber;
				}
			}
		}else{
			if (vectorY[i + 1] <= pointY){
				if (isLeft(vectorX[i], vectorY[i], vectorX[i + 1], vectorY[i + 1], pointX, pointY) < 0){
					--windingNumber;
				}
			}
		}
	}
	return windingNumber;
}


// wn_PnPoly(): winding number test for a point in a polygon
//      Input:   P = a point,
//               V[] = vertex points of a polygon V[n+1] with V[n]=V[0]
//      Return:  wn = the winding number (=0 only when P is outside)
//int
//	wn_PnPoly( Point P, Point* V, int n )
//	{
//		int    wn = 0;    // the  winding number counter
//
//		// loop through all edges of the polygon
//		for (int i=0; i<n; i++) {   // edge from V[i] to  V[i+1]
//			if (V[i].y <= P.y) {          // start y <= P.y
//				if (V[i+1].y  > P.y)      // an upward crossing
//					if (isLeft( V[i], V[i+1], P) > 0)  // P left of  edge
//						++wn;            // have  a valid up intersect
//			}
//			else {                        // start y > P.y (no test needed)
//				if (V[i+1].y  <= P.y)     // a downward crossing
//					if (isLeft( V[i], V[i+1], P) < 0)  // P right of  edge
//						--wn;            // have  a valid down intersect
//			}
//		}
//		return wn;
//	}
//===================================================================