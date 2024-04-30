#!/bin/bash 
# make_cmake.sh
# Created by Robin Rowe 2019/1/11
# License MIT open source

license="MIT open source"
cmakelist=CMakeLists.txt
date=$(date +%Y-%m-%d)
project=$1

if [ -z "${project}" ]; then 
	echo 'Usage: % make_cmake Project_Name'
	exit 1
fi
if [ -z "$AUTHOR" ]; then 
	echo "In bash set your name: % export AUTHOR=\"Your Name\""
	exit 1
fi

CreateCmakeList() 
{	echo Creating ${cmakelist} for project ${project}...
	echo "# ${project}/CMakeLists.txt" > ${cmakelist}
	echo "# Created by ${AUTHOR} ${date}" >> ${cmakelist}
	echo "# License ${license}" >> ${cmakelist}
	echo '' >> ${cmakelist}
	echo 'cmake_minimum_required(VERSION 3.8)' >> ${cmakelist}
	echo 'set(CMAKE_CXX_STANDARD 17)' >> ${cmakelist}
	echo 'set(CMAKE_CXX_STANDARD_REQUIRED ON)' >> ${cmakelist}
	echo 'set(CMAKE_CXX_EXTENSIONS OFF)' >> ${cmakelist}
	echo '' >> ${cmakelist}
	echo "set(Project ${project})" >> ${cmakelist}
	echo 'project(${Project})' >> ${cmakelist}
	echo 'enable_testing()' >> ${cmakelist}
	echo 'file(STRINGS sources.cmake SOURCES)' >> ${cmakelist}
	echo '' >> ${cmakelist}
}

CreateCmakeList
cat ${cmakelist}


