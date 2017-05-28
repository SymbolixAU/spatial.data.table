#include <Rcpp.h>
using namespace Rcpp;

/**
 * To Radians
 *
 * Converts degrees to radians
 *
 * @param deg
 *     degree to convert to radians
 */
double toRadians(double deg);

/**
 * To Degrees
 *
 * Converts radians to degrees
 *
 * @param rad
 *    radian to convert to degrees
 */
double toDegrees(double rad);

/**
 * Normalise Lon Deg
 *
 * Normalises longitudinal values to be between -180:180
 *
 * @param double deg
 *     degree value to normalise
 */
double normaliseLonDeg(double deg);

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
double isLeft(double p0x, double p0y, double p1x, double p1y, double p2x, double p2y);

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
bool isPolygonClosed(double startX, double endX, double startY, double endY);

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
Rcpp::NumericVector ClosePolygon(Rcpp::NumericVector polyVector);

