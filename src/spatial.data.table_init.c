#include <R.h>
#include <Rinternals.h>
#include <stdlib.h> // for NULL
#include <R_ext/Rdynload.h>

/* FIXME:
Check these declarations against the C/Fortran source code.
*/

/* .Call calls */
extern SEXP spatial_data_table_rcpp_decode_pl(SEXP);
extern SEXP spatial_data_table_rcpp_encode_pl(SEXP, SEXP, SEXP);
extern SEXP spatial_data_table_rcppAlongTrack(SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP);
extern SEXP spatial_data_table_rcppBearing(SEXP, SEXP, SEXP, SEXP, SEXP);
extern SEXP spatial_data_table_rcppClosePolygon(SEXP);
extern SEXP spatial_data_table_rcppDestination(SEXP, SEXP, SEXP, SEXP, SEXP);
extern SEXP spatial_data_table_rcppDist2gc(SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP);
extern SEXP spatial_data_table_rcppDistanceCosine(SEXP, SEXP, SEXP, SEXP, SEXP);
extern SEXP spatial_data_table_rcppDistanceEuclidean(SEXP, SEXP, SEXP, SEXP);
extern SEXP spatial_data_table_rcppDistanceHaversine(SEXP, SEXP, SEXP, SEXP, SEXP, SEXP);
extern SEXP spatial_data_table_rcppDouglasPeucker(SEXP, SEXP);
extern SEXP spatial_data_table_rcppIsPolygonClosed(SEXP, SEXP, SEXP, SEXP);
extern SEXP spatial_data_table_rcppMidpoint(SEXP, SEXP, SEXP, SEXP);
extern SEXP spatial_data_table_rcppPointsInPolygon(SEXP, SEXP, SEXP, SEXP, SEXP);
extern SEXP spatial_data_table_rcppSimplifyPolyline(SEXP, SEXP, SEXP, SEXP);
extern SEXP spatial_data_table_rcppWindingNumber(SEXP, SEXP, SEXP, SEXP);

static const R_CallMethodDef CallEntries[] = {
	{"spatial_data_table_rcpp_decode_pl",        (DL_FUNC) &spatial_data_table_rcpp_decode_pl,        1},
	{"spatial_data_table_rcpp_encode_pl",        (DL_FUNC) &spatial_data_table_rcpp_encode_pl,        3},
	{"spatial_data_table_rcppAlongTrack",        (DL_FUNC) &spatial_data_table_rcppAlongTrack,        8},
	{"spatial_data_table_rcppBearing",           (DL_FUNC) &spatial_data_table_rcppBearing,           5},
	{"spatial_data_table_rcppClosePolygon",      (DL_FUNC) &spatial_data_table_rcppClosePolygon,      1},
	{"spatial_data_table_rcppDestination",       (DL_FUNC) &spatial_data_table_rcppDestination,       5},
	{"spatial_data_table_rcppDist2gc",           (DL_FUNC) &spatial_data_table_rcppDist2gc,           8},
	{"spatial_data_table_rcppDistanceCosine",    (DL_FUNC) &spatial_data_table_rcppDistanceCosine,    5},
	{"spatial_data_table_rcppDistanceEuclidean", (DL_FUNC) &spatial_data_table_rcppDistanceEuclidean, 4},
	{"spatial_data_table_rcppDistanceHaversine", (DL_FUNC) &spatial_data_table_rcppDistanceHaversine, 6},
	{"spatial_data_table_rcppDouglasPeucker",    (DL_FUNC) &spatial_data_table_rcppDouglasPeucker,    2},
	{"spatial_data_table_rcppIsPolygonClosed",   (DL_FUNC) &spatial_data_table_rcppIsPolygonClosed,   4},
	{"spatial_data_table_rcppMidpoint",          (DL_FUNC) &spatial_data_table_rcppMidpoint,          4},
	{"spatial_data_table_rcppPointsInPolygon",   (DL_FUNC) &spatial_data_table_rcppPointsInPolygon,   5},
	{"spatial_data_table_rcppSimplifyPolyline",  (DL_FUNC) &spatial_data_table_rcppSimplifyPolyline,  4},
	{"spatial_data_table_rcppWindingNumber",     (DL_FUNC) &spatial_data_table_rcppWindingNumber,     4},
	{NULL, NULL, 0}
};

void R_init_spatial_data_table(DllInfo *dll)
{
	R_registerRoutines(dll, NULL, CallEntries, NULL, NULL);
	R_useDynamicSymbols(dll, FALSE);
}
