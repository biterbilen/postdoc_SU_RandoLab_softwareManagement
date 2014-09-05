mkdir -p $PI_HOME/Data
chmod 770 $PI_HOME/Data; chmod o+t $PI_HOME/Data
pushd $PI_HOME/Data 

# -----test
# -----test END

function_getData_jbrett_epigenetics

# function_install_vim
# function_install R

popd

function_getData_jbrett_epigenetics() {
	dd=$PI_HOME/Data/jbrett/WGBS/compiledCov 
	mkdir -p $dd; chmod -R 750 $dd
	pushd $dd
	rsync -rqt biter@corn.stanford.edu:/farmshare/user_data/randolab1/data/Jamie/WGBS/compiledCov/* . 2> rsync.err
#	gzip $dd/*
	popd
}
