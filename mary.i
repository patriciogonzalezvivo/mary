%begin %{
#if defined( __WIN32__ ) || defined( _WIN32 )
	#include <cmath>
#endif
%}

%module mary

%include <typemaps.i>
%include <std_vector.i>
%include <std_string.i>

%ignore *::operator[];
%ignore *::operator=;
%ignore *::operator==;
%ignore *::operator!=;
%ignore *::operator<;
%ignore *::operator<=;
%ignore *::operator>;
%ignore *::operator>=;
%ignore operator<<;

%{
    #define SWIG_FILE_WITH_INIT
    #include "mary/drivers/Driver.h"
%}

%include "glm.i"
%include "numpy.i"
%init %{
    import_array();
%}

%typemap(in) size_t {
    $1 = PyInt_AsLong($input);
}

%typemap(in) uint16_t {
    $1 = PyInt_AsLong($input);
}

%typemap(in) uint32_t {
    $1 = PyInt_AsLong($input);
}

%apply (int* IN_ARRAY1, int DIM1 ) {(const int* _array1D, int _n )};
%apply (int* IN_ARRAY2, int DIM1, int DIM2 ) {(const int* _array2D, int _m, int _n )};

%apply (uint16_t* IN_ARRAY1, int DIM1 ) {(const uint16_t* _array1D, int _n )};
%apply (uint16_t* IN_ARRAY2, int DIM1, int DIM2 ) {(const uint16_t* _array2D, int _m, int _n )};

%apply (uint32_t* IN_ARRAY1, int DIM1 ) {(const uint32_t* _array1D, int _n )};
%apply (uint32_t* IN_ARRAY2, int DIM1, int DIM2 ) {(const uint32_t* _array2D, int _m, int _n )};

%apply (float* IN_ARRAY1, int DIM1 ) {(const float* _array1D, int _n )};
%apply (float* IN_ARRAY2, int DIM1, int DIM2 ) {(const float* _array2D, int _m, int _n )};

%apply (uint8_t* IN_ARRAY3, int DIM1, int DIM2, int DIM3) { (const uint8_t* _array3D, int _height, int _width, int _channels) }
%apply (uint8_t** ARGOUTVIEWM_ARRAY3, int* DIM1, int* DIM2, int* DIM3) { (uint8_t **_array3D, int *_height, int *_width, int *_channels) }

namespace std {
    %template(Vector4DVector)   vector<glm::vec4>;
    %template(Vector3DVector)   vector<glm::vec3>;
    %template(Vector2DVector)   vector<glm::vec2>;

    %template(PolylinesVector)  vector<mary::Polyline>;

    %template(FacesVector)      vector<glm::ivec3>;
    %template(EdgesVector)      vector<glm::ivec2>;
    %template(TrianglesVector)  vector<mary::Triangle>;
    %template(LinesVector)      vector<mary::Line>;
    %template(MeshesVector)     vector<mary::Mesh>;

    %template(ImagesVector)     vector<mary::Image>;

    %template(StringVector)     vector<string>;
    %template(FloatVector)      vector<float>;
};


%include "mary/drivers/Driver.h"


