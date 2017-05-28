#include <Rcpp.h>
using namespace Rcpp;

// -------------------------------------------
//
// utility functions for spatial.data.table
//
// -------------------------------------------

double toRadians(double deg){
	return deg * (M_PI / 180);
}


double toDegrees(double rad){
	return rad / (M_PI / 180);
}


double normaliseLonDeg(double deg){
	return fmod(deg - 180.0, 360.0) + 180.0;
}


double isLeft(double p0x, double p0y, double p1x, double p1y, double p2x, double p2y){
	return ((p1x - p0x) * (p2y - p0y) - (p2x - p0x) * (p1y - p0y));
}

bool isPolygonClosed(double startX, double endX, double startY, double endY){
	return (startX == endX && startY == endY);
}

Rcpp::NumericVector ClosePolygon(Rcpp::NumericVector polyVector){
	//double addToEnd = polyVector[0];
	polyVector.push_back(polyVector[0]);
	return polyVector;
}


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






