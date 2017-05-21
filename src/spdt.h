

namespace spdt {

	double toRadians(double deg){
		return deg * (M_PI / 180);
	}

	double toDegrees(double rad){
		return rad / (M_PI / 180);
	}

	/**
	 * Normalise Lon Deg
	 *
	 * @param double deg
	 *     degree value to normalise to be between -180, 180
	 */
	double normaliseLonDeg(double deg){
		return fmod(deg - 180.0, 360.0) + 180.0;
	}

}
