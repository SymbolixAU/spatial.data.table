#include <Rcpp.h>
#include <math.h>
#include "Point.h"
using namespace Rcpp;
using namespace std;


int PointInPoly(Point P, std::vector<Point> V, int n);
int	isLeft( Point P0, Point P1, Point P2 );
//int isLeft(Point P0, Point P1, Point P2);

// PointInPoly(): winding number test for a point in a polygon
//      Input:   P = a point,
//               V[] = vertex points of a polygon V[n+1] with V[n]=V[0]
//      Return:  wn = the winding number (=0 only when P is outside)

// [[Rcpp::export]]
int myPoint(double x, double y, NumericVector vx, NumericVector vy)
{
	Point point(x, y);
	int n = vx.size();
	std::vector<Point> v(n);

	for (int i = 0; i < n; i++){
		Point p(vx[i], vy[i]);
		v.push_back(p);
	}

  int r = PointInPoly(point, v,  n);
	return r;
}

//int	PointInPoly( Point P, Point* V, int n )
int PointInPoly(Point P, std::vector<Point> V, int n)
{
	int    wn = 0;    // the  winding number counter

	// loop through all edges of the polygon
	for (int i = 0; i < n; i++) {   // edge from V[i] to  V[i+1]
		if (V[i].y() <= P.y()) {          // start y <= P.y
			if (V[i+1].y()  > P.y())      // an upward crossing
				if (isLeft( V[i], V[i+1], P) > 0)  // P left of  edge
					++wn;            // have  a valid up intersect
		}
		else {                        // start y > P.y (no test needed)
			if (V[i+1].y()  <= P.y())     // a downward crossing
				if (isLeft( V[i], V[i+1], P) < 0)  // P right of  edge
					--wn;            // have  a valid down intersect
		}
	}
	return wn;
}

// a Point is defined by its coordinates {int x, y;}
//===================================================================


// isLeft(): tests if a point is Left|On|Right of an infinite line.
//    Input:  three points P0, P1, and P2
//    Return: >0 for P2 left of the line through P0 and P1
//            =0 for P2  on the line
//            <0 for P2  right of the line
inline int	isLeft( Point P0, Point P1, Point P2 )
{
	return ( (P1.x() - P0.x()) * (P2.y() - P0.y())
          - (P2.x() -  P0.x()) * (P1.y() - P0.y()) );
}
//===================================================================

