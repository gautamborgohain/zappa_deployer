#!/bin/sh

source activate zappa_env
export VIRTUAL_ENV=/opt/conda/envs/zappa_env

if [ $cmd == "update" ] || [ $cmd == "deploy" ] || [ $cmd == "package" ]; then
	echo Copying over deployment files to app_temp
	cp -r /app/* /app_temp/
	cd /app_temp
	ls -lth
	echo Running zappa command : $cmd on stage:  $stage
	zappa $cmd $stage $arg
else
	cd /app
	echo Running zappa command : $cmd on stage:  $stage
	zappa $cmd $stage $arg
fi
