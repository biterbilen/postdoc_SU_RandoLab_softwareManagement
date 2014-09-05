#!/bin/bash - 
#===============================================================================
#
#          FILE: bb_make_project_template.sh
# 
#         USAGE: source ./bb_make_project_template.sh; 
#                call function_createProject, etc
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#GIT doc: http://git-scm.com/book/en/Git-on-the-Server-Setting-Up-the-Server
#        AUTHOR: Dr. Biter Bilen (bb), biterbilen@yahoo.com
#  ORGANIZATION: Stanford, Palo Alto, USA
#       CREATED: 08/22/2014 11:45
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

# 1 TODO make them local to file
# 2 TODO config clone and push user restrictions
# 3 TODO from the above document; is it possible to add an http git interface w lighttpd webrick

GIT_HOSTNAME=sherlock.stanford.edu
GIT_LOCAL_DIR=$PI_SCRATCH/Projects #or $SCRATCH for own projects
GIT_BARE_DIR=$PI_HOME/Projects.git

function_configGitUser() {
	git config --global user.name "`finger $USER | grep Name: | awk '{ print $(NF-1), $NF}'`"
	git config --global user.email "$USER@stanford.edu"
	git config --global color.ui true
	git config --global core.autocrlf input #conversion of windows line end to linux
	#from web interface
	#git instaweb --httpd=webrick
	#git instaweb --httpd=webrick --stop
} 

function_cloneGitProject() {
	project_tag=$1
	project_user2=${2:-$USER}

	project_name=`bb_getProjectName $project_tag $project_user2`

	bare_dir=$GIT_BARE_DIR/$project_name.git
#	git clone $USER@$GIT_HOSTNAME:$bare_dir $project_name
	git clone file:///$bare_dir $project_name

}

#TODO function howto write from plugin
bb_getProjectName() {
	project_tag=$1
	project_user2=$2
	
	echo ${USER}_${project_user2}_${project_tag}
}


function_makeGitProject() {
	project_tag=$1
	project_user2=${2:-$USER}

	project_name=`bb_getProjectName $project_tag $project_user2`

	#bare repository
	bare_dir=$GIT_BARE_DIR/$project_name.git
	mkdir -p $bare_dir
	pushd $bare_dir
	git init --bare
	popd

	#local repository
	local_dir=$GIT_LOCAL_DIR/$project_name
	mkdir -p $local_dir
	pushd $local_dir
	git init
	git remote add origin $USER@$GIT_HOSTNAME:$bare_dir
	mkdir -p bin doc data results/`date -I`
	popd
}

function_setCommonDirPerms() {
	#permissions of data folder
	for folder in $GIT_LOCAL_DIR $GIT_BARE_DIR; do
		chmod 770 $folder
		chmod g+s $folder
		chmod o+t $folder
	done

}

function_deleteProject() {
	project_tag=$1
	project_user2=${2:-$USER}

	project_name=`bb_getProjectName $project_tag $project_user2`

	bare_dir=$GIT_BARE_DIR/$project_name.git
	local_dir=$GIT_LOCAL_DIR/$project_name
	rm -rf $bare_dir $local_dir

}
