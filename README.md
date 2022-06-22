# Cmake学习
* 由于在平时的demo学习过程中经常遇到需要配置开发环境， 各种依赖实在麻烦，于是学习了一下cmake，用于管理自己的项目

## cmake使用方式
* 当使用者将你的库作为第三方库来使用的时候，CMAKE_SOURCE_DIR 以及 CMAKE_BINARY_DIR 就会变成使用者所在项目的变量了。那么，在你的库中，CMake 获取的 CMAKE_SOURCE_DIR 就会是 project-root，而不是你可能想要的 project-root/extern/your-lib-root CMAKE_BINARY_DIR 同理。因此，正确的做法是使用 PROJECT_SOURCE_DIR 以及 PROJECT_BINARY_DIR，他们的获取是 CMake 根据遇到的最近的 project() 命令来决定的。
## CMake理解
* cmake是构建系统生成器，主要功能是描述项目结构，表达模块依赖， 从而项目友好的方式表达构建过程
* Cmake 围绕构建目标声明，一切围绕着target




