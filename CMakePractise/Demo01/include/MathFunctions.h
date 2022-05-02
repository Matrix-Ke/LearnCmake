
#if defined(EXPORTING_MYMATH)
#    define DECLSPEC __declspec(dllexport)
#else
#    define DECLSPEC __declspec(dllimport)
#endif

namespace mathfunctions
{
	double DECLSPEC sqrt(double x);
}