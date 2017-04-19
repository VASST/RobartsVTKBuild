# Robarts VTKBuild

RobartsVTKBuild is a CMake project that downloads dependencies for the RobartsVTKLib project and builds everything.

## Download RobartsVTKBuild

Using a [git](https://en.wikipedia.org/wiki/Git_(software)) client, clone the repo link above.
* Windows? Try [TortoiseGit](https://tortoisegit.org/download/)
* Ubuntu? Try [RabbitVCS](http://rabbitvcs.org/), [SmartGit](http://www.syntevo.com/smartgit/) or [git-cola](http://git-cola.github.io/downloads.html)
* Mac? Try [GitHub](https://desktop.github.com/)

### Known Configurations
RobartsVTK has been built on the following configurations:
* Windows 10 x64, Visual Studio 2013 & 2015, 32/64bit builds
* Ubuntu 15.10, Unix Makefiles/Eclipse CDT (see [Ubuntu build tips](ubuntu.md))
* Ubuntu 15.04, Unix Makefiles/Eclipse CDT

### Tools
* Visual Studio [2013](https://www.visualstudio.com/en-us/news/releasenotes/vs2013-community-vs)/[2015](https://www.visualstudio.com/downloads/)

### Dependencies
The superbuild will download and build needed dependencies. Only two items must be installed and one built:
* [CMake 3.7+](https://cmake.org/download/)
* [CUDA](https://developer.nvidia.com/cuda-downloads) (optional)
* [Qt](https://www.qt.io/download-open-source/?hsCtaTracking=f977210e-de67-475f-a32b-65cec207fd03%7Cd62710cd-e1db-46aa-8d4d-2f1c1ffdacea#section-2/) - installed (optional)

### CMake Configuration
The following variables should be set when configuring RobartsVTK
* ITK_DIR:PATH = `<path/to/your/itk-bin/dir>` (optional, if built elsewhere)
* PlusLib_DIR:PATH = `<path/to/your/plus-bin/dir>` (optional, if built elsewhere)
* QT5 - as above OR - Qt5_DIR:PATH = `<path/to/your/qtInstall>/lib/cmake/Qt5`
* VTK_DIR:PATH = `<path/to/your/vtk-bin/dir>` (optional, if built elsewhere)

## License
Please see the [license](LICENSE.md) file.

## Acknowledgments
The Robarts Research Institute VASST Lab would like to thank the creator and maintainers of [GitLab](https://about.gitlab.com/).
