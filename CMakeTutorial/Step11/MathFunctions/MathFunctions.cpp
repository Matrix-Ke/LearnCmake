
#include "MathFunctions.h"

#include <cmath>

#ifdef USE_MYMATH
#  include "mysqrt.h"
#endif

namespace mathfunctions
{
	double DECLSPEC sqrt(double x)
	{
#ifdef USE_MYMATH
		return detail::mysqrt(x);
#else
		return std::sqrt(x);
#endif
	}
}