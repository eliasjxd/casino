#!/bin/bash 
# make_class.sh
# Created by Robin Rowe 2019/1/10
# License MIT open source

#set -x
license='MIT open source'
h_file=$0.h
test_file="$0.test.cpp"
cmakelist=CMakeLists.txt
sources=sources.cmake
date=$(date +%Y-%m-%d)

if [ -z "$AUTHOR" ]; then 
	echo "In bash set your name: % export AUTHOR=\"Your Name\""
	exit 1
fi

if [[ ! -e test ]]; then
    mkdir test
fi

Sed()
{	local arg=$1
	local file=$2
	sed "${arg}" ${file} > ${file}.tmp
	mv -f ${file}.tmp ${file}
}

CreateFile() 
{	local src=$1
	local dst=$2
	local arg=$3
	echo Creating ${dst} ...
	cp ${src} ${dst}
	Sed "s|CLASS|${arg}|g" ${dst}
	Sed "s|DATE|${date}|g" ${dst}
	Sed "s|AUTHOR|${AUTHOR}|g" ${dst}
	Sed "s|LICENSE|${license}|g" ${dst}
}

UpdateCmakeList()
{	local arg=$1
	echo "Updating ${cmakelist} with $arg..."
	echo "add_executable(test_${arg} \${SOURCES} test/test_${arg}.cpp)" >> ${cmakelist}
	echo "add_test(test_${arg} test_${arg})" >> ${cmakelist}
}

UpdateCmakeSources()
{	local arg=$1
	if [[ ! -e ${sources} ]]; then
		echo ${sources} > ${sources}
	fi
	echo "${arg}.h" >> ${sources}
}

for arg; do 
	if [[ -e ${arg}.h ]]; then
		echo "Skipping... ${arg}.h already exists!"
		continue
	fi
	CreateFile ${h_file} "./${arg}.h" ${arg}
	CreateFile ${test_file} "./test/test_${arg}.cpp" ${arg}
	UpdateCmakeList $arg
	UpdateCmakeSources $arg
done

