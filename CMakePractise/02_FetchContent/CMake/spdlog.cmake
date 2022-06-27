#example
# 添加第三方依赖包
function(FetchContent_ForTarget)
    set(option TEST_Option)
    set(oneValueArgs TargetName Git_Url Output_Dir)
    set(multiValueArgs Other)
    cmake_parse_arguments(ArgPrefix "${option}" "${oneValueArgs}"  "${multiValueArgs}" ${ARGN})
    # 通过 prefix_参数名: 例如 ArgPrefix_TEST_Option
    message("TEST_Option = ${ArgPrefix_TEST_Option};")
    message("TargetName = ${ArgPrefix_TargetName};")
    message("Git_Url = ${ArgPrefix_Git_Url};")
    message("Other  = ${ArgPrefix_Other};")
    message("Output_Dir  = ${ArgPrefix_Output_Dir};")
    # Fetchcontent_declare(
    # ${ArgPrefix_TargetName}	#库名字
    # GIT_REPOSITORY   ${ArgPrefix_Git_Url}	# 仓库地址
    # # GIT_TAG v1.x # 库版本
    # SOURCE_DIR ${ArgPrefix_Output_Dir} # 指定库下载地址
    # )
FetchContent_MakeAvailable(spdlog)
endfunction(FetchContent_ForTarget)

Fetchcontent_declare(
    spdlog	#库名字
    GIT_REPOSITORY  git@github.com:gabime/spdlog.git	# 仓库地址
    GIT_TAG v1.x # 库版本
    SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/spdlog # 指定库下载地址
    )
FetchContent_MakeAvailable(spdlog)

if(TARGET spdlog)
    option(SPDLOG_BUILD_EXAMPLE "" OFF)
    option(SPDLOG_INSTALL "" OFF)
    option(spdlog-utests  OFF)
    # add_subdirectory(_deps/spdlog)
    set_target_properties(spdlog PROPERTIES FOLDER BasicTool)
    message(STATUS  spdlog:" spdlog target add successfully")
endif()


