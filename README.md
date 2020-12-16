
![](docs/00.jpg)

[![Build Status](https://travis-ci.org/patriciogonzalezvivo/mary.svg?branch=master)](https://travis-ci.org/patriciogonzalezvivo/mary)


DESCRIPTION

Dependencies:

* CMake, Swig and Python3
* [GLM](https://github.com/g-truc/glm) required

## Compile and install Mary

1. Before compiling install dependencies:

```bash
// In linux
sudo apt install libglm-dev cmake swig python3-numpy

// In MacOS
brew install glm cmake swig
```

2. Then compile

```bash
mkdir build
cd build
cmake ..
make
sudo make install 
```

**Note**: to install inside anaconda do:
```bash
swig -c++ -python mary.i
/anaconda3/bin/./python3.7 setup.py build_ext --inplace
/anaconda3/bin/./python3.7 setup.py install 
```

## Mary as C++ lib

Alternatively to installing mary on your system you can easily copy the content of `include/` and `src/` folder to your project, just make sure you 


```cpp

```

## Mary as Python module

First you need to create the package and install it

```bash
sudo apt install swig
make install
```

Then you can use it as follow:

```python

```


# License

Mery is open source. You may use, extend, and redistribute without charge under the terms of the [BSD license](LICENSE).

```
Copyright (c) 2020, Patricio Gonzalez Vivo
All rights reserved.

Redistribution and use in source and binary forms, with or without modification, 
are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice, this
list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright notice, this
list of conditions and the following disclaimer in the documentation and/or other
materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND 
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED 
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. 
IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, 
INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, 
BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, 
DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF 
LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE 
OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF
THE POSSIBILITY OF SUCH DAMAGE.
```
