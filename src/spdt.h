// -------------------------------------------
//
// utility functions for spatial.data.table
//
// -------------------------------------------

namespace spdt {

  struct GPS{
  	double lat;
  	double lon;
  };

  const double EARTH_RADIUS = 6378137.0;
  //const double DISTANCE_TOLERANCE = 1000000000.0;
}

/**
* To Radians
*
* Converts degrees to radians
*
* @param deg
*     degree to convert to radians
*/
//	double toRadians(double deg){
//		return deg * (M_PI / 180);
//	}

/**
* To Degrees
*
* Converts radians to degrees
*
* @param rad
*    radian to convert to degrees
*/
//	double toDegrees(double rad){
//		return rad / (M_PI / 180);
//	}

/**
* Normalise Lon Deg
*
* Normalises longitudinal values to be between -180:180
*
* @param double deg
*     degree value to normalise
*/
//	double normaliseLonDeg(double deg){
//		return fmod(deg - 180.0, 360.0) + 180.0;
//	}

/**
* Is Left
*
* Tests if a point is Left|On|Right of an infinite line
* @param p0x x coordinate of the first point in the line
* @param p0y y coordinate of the first point in the line
* @param p1x x coordinate of the last point in the line
* @param p1y y coordinate o fthe last point in the line
* @param p2x x coordinate of the point
* @param p2y y coordinate of the point
*
* @return double
* > 0 : P2 is left of the line through P0, P1
* = 0 : P2 is on the line
* < 0 : P2 is right of the line through P0, P1
*
*/
//	double isLeft(double p0x, double p0y, double p1x, double p1y, double p2x, double p2y){
//		return ((p1x - p0x) * (p2y - p0y) - (p2x - p0x) * (p1y - p0y));
//	}

/**
* Is Polygon Closed
*
* Checks if the last coordinates equal the first coordinates
*
* @param start.x
* @param start.y
* @param end.x
* @param end.y
*/
//	bool isPolygonClosed(double startX, double startY, double endX, double endY){
//		return (startX == endX && startY == endY);
//	}


/**
* Close Polygon
*
* Sets the last entry in a vector to be the same as the first
*
* @param polyVector numeric vector
*
* @return numeric vector
*
*/
//	Rcpp::NumericVector ClosePolygon(Rcpp::NumericVector polyVector){
//		polyVector.push_back(polyVector[0]);
//		return polyVector;
//	}

//}



// Copyright 2000 softSurfer, 2012 Dan Sunday
// This code may be freely used and modified for any purpose
// providing that this copyright notice is included with it.
// SoftSurfer makes no warranty for this code, and cannot be held
// liable for any real or imagined damage resulting from its use.
// Users of this code must verify correctness for their application.


// a Point is defined by its coordinates {int x, y;}
//===================================================================


// isLeft(): tests if a point is Left|On|Right of an infinite line.
//    Input:  three points P0, P1, and P2
//    Return: >0 for P2 left of the line through P0 and P1
//            =0 for P2  on the line
//            <0 for P2  right of the line
//    See: Algorithm 1 "Area of Triangles and Polygons"
//inline int
//isLeft( Point P0, Point P1, Point P2 )
//{
//	return ( (P1.x - P0.x) * (P2.y - P0.y)
//            - (P2.x -  P0.x) * (P1.y - P0.y) );
//}
//===================================================================


// cn_PnPoly(): crossing number test for a point in a polygon
//      Input:   P = a point,
//               V[] = vertex points of a polygon V[n+1] with V[n]=V[0]
//      Return:  0 = outside, 1 = inside
// This code is patterned after [Franklin, 2000]
//int
//cn_PnPoly( Point P, Point* V, int n )
//{
//	int    cn = 0;    // the  crossing number counter
//
//	// loop through all edges of the polygon
//	for (int i=0; i<n; i++) {    // edge from V[i]  to V[i+1]
//		if (((V[i].y <= P.y) && (V[i+1].y > P.y))     // an upward crossing
//        || ((V[i].y > P.y) && (V[i+1].y <=  P.y))) { // a downward crossing
//			// compute  the actual edge-ray intersect x-coordinate
//			float vt = (float)(P.y  - V[i].y) / (V[i+1].y - V[i].y);
//			if (P.x <  V[i].x + vt * (V[i+1].x - V[i].x)) // P.x < intersect
//				++cn;   // a valid crossing of y=P.y right of P.x
//		}
//	}
//	return (cn&1);    // 0 if even (out), and 1 if  odd (in)
//
//}
//===================================================================
