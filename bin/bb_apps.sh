function_test() {
	cd $PI_HOME 
	mkdir -p Downloads Applications
	chmod 770 Downloads Applications; chmod o+t Downloads Applications
	pushd Downloads

	eval $1

	popd
}
function_install_IPO() {
	Rscript -e "library(devtools); install_github('glibiseller/IPO')"
}

function_install_ggthemes() {
	Rscript -e "install.packages('ggthemes', dependencies = TRUE)"
}

function_install_ggfortify() {
	Rscript -e "library(devtools); install_github('sinhrks/ggfortify')"
}

function_install_quasiseq() {
	lnk=http://cran.fhcrc.org/src/contrib/Archive/QuasiSeq/QuasiSeq_1.0-4.tar.gz
	wget -nv $lnk
	fle=`echo $lnk | awk -F "/" '{ print $NF}'`
	R CMD INSTALL  $fle
}

function_install_subread() {
	lnk=http://sourceforge.net/projects/subread/files/subread-1.4.6-p4/subread-1.4.6-p4-source.tar.gz
	lnk=https://sourceforge.net/projects/subread/files/subread-1.5.1/subread-1.5.1-source.tar.gz
	fle=`echo $lnk | awk -F "/" '{ print $NF}'`
	wget -nv $lnk
	tar -zxf $fle
	ad=$PI_HOME/Applications/`tar -zxvf $fle | head -n 1 | awk -F "/" '{ print $1}'`
	mkdir -p $ad/bin
	pushd `basename $ad`/src
	make -j 4 -f Makefile.Linux
	cp -rf ../bin/* $ad/bin/
	popd
}

function_install_PIQ() {
	#git clone https://biterbilen@bitbucket.org/thashim/piq.git ; got the old version
	lnk=https://bitbucket.org/thashim/piq-single/get/master.zip
	wget -nv $lnk
	fles=`echo $lnk | awk -F "/" '{ print $NF}'`
	fle=PIQ-`echo $lnk | awk -F "/" '{ print $NF}'`
	mv $fles $fle
	unzip -q $fle
	ad=$PI_HOME/Applications/`unzip -l $fle | head -n 5 | tail -n 1 | awk '{ print $NF}' | awk -F '/' '{ print $1}'`
	mkdir -p $ad/bin
	pushd `basename $ad`
	# TODO continue to make it system wide accessible
	popd
}

function_install_cutadapt() {

	#1.
	#2.
	lnk=https://pypi.python.org/packages/source/c/cutadapt/cutadapt-1.8.3.tar.gz
	lnk=https://pypi.python.org/packages/source/c/cutadapt/cutadapt-1.9.1.tar.gz

	fle=`echo $lnk | awk -F "/" '{ print $NF}'`
	wget -nv $lnk
	tar -zxf $fle
	ad=$PI_HOME/Applications/`tar -zxvf $fle | head -n 1 | awk -F "/" '{ print $1}'`
	mkdir -p $ad/bin
	pushd `basename $ad`
	module load python/3.3.2
	#module load python/2.7.5 # TODO check if this works
	python setup.py install --home=$ad 
	#python setup.py build_ext -i --home=$ad 
	popd
}

function_install_JAMM() {
	lnk=https://github.com/mahmoudibrahim/JAMM/archive/v1.0.7.2.zip
	wget -nv $lnk
	fles=`echo $lnk | awk -F "/" '{ print $NF}'`
	fle=JAMM-`echo $lnk | awk -F "/" '{ print $NF}'`
	mv $fles $fle
	unzip -q $fle
	ad=$PI_HOME/Applications/`unzip -l $fle | head -n 5 | tail -n 1 | awk '{ print $NF}' | awk -F '/' '{ print $1}'`
	mkdir -p $ad/bin
	pushd `basename $ad`
	chmod 755 *sh
	cp JAMM.sh SignalGenerator.sh $ad/bin
	popd
}

function_install_tabtk() {
	lnk=https://github.com/lh3/tabtk.git
	git clone $lnk
	mv tabtk tabtk-r13
	ad=$PI_HOME/Applications/tabtk-r13
	mkdir -p $ad/bin
	pushd `basename $ad`
	make
	cp tabtk $ad/bin
	popd
}


function_install_seqtk() {
	lnk=https://github.com/lh3/seqtk.git
	git clone $lnk
	mv seqtk seqtk-1.0-r82-dirty
	ad=$PI_HOME/Applications/seqtk-1.0-r82-dirty
	mkdir -p $ad/bin
	pushd `basename $ad`
	make
	cp seqtk trimadap $ad/bin
	popd
}

function_install_bison() {
	lnk=http://ftp.gnu.org/gnu/bison/bison-3.0.4.tar.gz
	wget -nv $lnk
	fle=`echo $lnk | awk -F "/" '{ print $NF}'`
	tar -zxf $fle
	ad=$PI_HOME/Applications/`tar -zxvf $fle | head -n 1 | awk -F "/" '{ print $1}'`
	mkdir -p $ad/bin
	pushd `basename $ad`
	./configure --prefix=$ad
	make -j 16
	make install
	popd
}

function_install_bioawk() {
	lnk=https://github.com/lh3/bioawk/archive/v1.0.tar.gz
	wget -nv $lnk
	fles=`echo $lnk | awk -F "/" '{ print $NF}'`
	fle=bioawk-$fles
	mv $fles $fle
	tar -zxf $fle
	ad=$PI_HOME/Applications/`tar -zxvf $fle | head -n 1 | awk -F "/" '{ print $1}'`
	mkdir -p $ad/bin
	pushd `basename $ad`
	make 
	cp bioawk maketab $ad/bin/.
	popd
}

# TODO 
function_install_cuda() {
	lnk=https://developer.nvidia.com/compute/cuda/8.0/prod/local_installers/cuda_8.0.44_linux-run
	wget -nv $lnk
	fle=`echo $lnk | awk -F "/" '{ print $NF}'`
	unzip -q $fle
	ad=$PI_HOME/Applications/`unzip -l $fle | head -n 5 | tail -n 1 | awk '{ print $NF}' | awk -F '/' '{ print $1}'`
	mkdir -p $ad/bin
	pushd `basename $ad`
	gmake
	cp hisat2 hisat2-build* hisat2-align* hisat2-inspect* hisat2*py $ad/bin
	popd

}

function_install_cuDNN() {
	lnk=TODO

}


function_install_HISAT2() {
	lnk=ftp://ftp.ccb.jhu.edu/pub/infphilo/hisat2/downloads/hisat2-2.0.1-beta-source.zip
	lnk=ftp://ftp.ccb.jhu.edu/pub/infphilo/hisat2/downloads/hisat2-2.0.3-beta-source.zip
	lnk=ftp://ftp.ccb.jhu.edu/pub/infphilo/hisat2/downloads/hisat2-2.0.4-source.zip
	lnk=ftp://ftp.ccb.jhu.edu/pub/infphilo/hisat2/downloads/hisat2-2.0.5-source.zip
	wget -nv $lnk
	fle=`echo $lnk | awk -F "/" '{ print $NF}'`
	unzip -q $fle
	ad=$PI_HOME/Applications/`unzip -l $fle | head -n 5 | tail -n 1 | awk '{ print $NF}' | awk -F '/' '{ print $1}'`
	mkdir -p $ad/bin
	pushd `basename $ad`
	gmake
	cp hisat2 hisat2-build* hisat2-align* hisat2-inspect* hisat2*py $ad/bin
	popd
}

function_install_HISAT() {
	lnk=https://github.com/infphilo/hisat/archive/master.zip
	wget -nv $lnk
	fles=`echo $lnk | awk -F "/" '{ print $NF}'`
	fle=HISAT-`echo $lnk | awk -F "/" '{ print $NF}'`
	mv $fles $fle
	unzip -q $fle
	ad=$PI_HOME/Applications/`unzip -l $fle | head -n 5 | tail -n 1 | awk '{ print $NF}' | awk -F '/' '{ print $1}'`
	mkdir -p $ad/bin
	pushd `basename $ad`
	gmake -j
	cp hisat hisat-build* hisat-align* hisat-inspect* $ad/bin
	popd
}

function_install_STAR() {
	lnk=https://github.com/alexdobin/STAR/archive/STAR_2.4.0k.tar.gz
	fle=`echo $lnk | awk -F "/" '{ print $NF}'`
	wget -nv $lnk
	tar -zxf $fle
	ad=$PI_HOME/Applications/`tar -zxvf $fle | head -n 1 | awk -F "/" '{ print $1}'`
	mkdir -p $ad/bin
	pushd `basename $ad`
	pushd source
	make STAR
	cp STAR $ad/bin
	popd
}

function_install_weblogo() {
	lnk=http://weblogo.berkeley.edu/release/weblogo.2.8.2.tar.gz
	fle=`echo $lnk | awk -F "/" '{ print $NF}'`
	wget -nv $lnk
	tar -zxf $fle
	ad=$PI_HOME/Applications/`tar -zxvf $fle | head -n 1 | awk -F "/" '{ print $1}'`
	mkdir -p $ad/bin
	pushd `basename $ad`
	cp seqlogo $ad/bin
	popd
}

function_install_homer() {
	odir=Homer; mkdir -p $odir; pushd $odir

	lnk=http://homer.salk.edu/homer/configureHomer.pl
	fle=`echo $lnk | awk -F "/" '{ print $NF}' | awk -F "." '{ print $1}'`
	wget -nv $lnk
	ad=$PI_HOME/Applications/$fle
	mkdir -p $ad/bin
	perl configureHomer.pl -install
	cp bin/* /share/PI/casco/Applications/configureHomer/bin/.
	popd
}

function_install_RegulatorInference() {
	lnk=http://cbio.mskcc.org/leslielab/RegulatorInference/RegulatorInference_1.0.tar.gz
	fle=`echo $lnk | awk -F "/" '{ print $NF}'`
	wget -nv $lnk
	tar -zxf $fle
	pushd RegulatorInference
	wget http://cbio.mskcc.org/leslielab/RegulatorInference/Readme.pdf
	popd
}

function_install_emacs() {
	lnk=http://ftp.gnu.org/gnu/emacs/emacs-24.4.tar.gz
	fle=`echo $lnk | awk -F "/" '{ print $NF}'`
	wget -nv $lnk
	tar -zxf $fle
	ad=$PI_HOME/Applications/`tar -zxvf $fle | head -n 1 | awk -F "/" '{ print $1}'`
	mkdir -p $ad/bin
	pushd `basename $ad`
	./configure --prefix=$ad --with-xpm=no --with-gif=no --with-tiff=no
	make -j 8
	make install
	popd
}




function_install_pcre() {
	lnk=ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-8.36.tar.gz
	wget -nv $lnk
	fle=`echo $lnk | awk -F "/" '{ print $NF}'`
	tar -zxf $fle
	ad=$PI_HOME/Applications/`tar -zxvf $fle | head -n 1 | awk -F "/" '{ print $1}'`
	mkdir -p $ad
	pushd `basename $ad`
	./configure --prefix=$ad
	make
	make install
	popd

}

function_install_sratoolkit() {
	lnk=http://ftp-trace.ncbi.nlm.nih.gov/sra/sdk/2.4.4/sratoolkit.2.4.4-centos_linux64.tar.gz
	wget -nv $lnk
	fle=`echo $lnk | awk -F "/" '{ print $NF}'`
	tar -zxf $fle
	ad=$PI_HOME/Applications/`tar -zxvf $fle | head -n 1 | awk -F "/" '{ print $1}'`
	mkdir -p $ad/bin
	./configure --prefix=$ad
	pushd `basename $ad`
	cp -rf bin/* $ad/bin/
	popd
}


function_install_armadillo() {
	lnk=http://sourceforge.net/projects/arma/files/armadillo-4.550.2.tar.gz
	wget -nv $lnk
	fle=`echo $lnk | awk -F "/" '{ print $NF}'`
	tar -zxf $fle
	ad=$PI_HOME/Applications/`tar -zxvf $fle | head -n 1 | awk -F "/" '{ print $1}'`
	mkdir -p $ad
	pushd `basename $ad`
	export CMAKE_ROOT=/share/PI/casco/Applications/cmake-3.1.0-rc3/share/cmake-3.1/
	export CMAKE_ROOT=/share/PI/casco/Downloads/cmake-3.1.0-rc3
	~/bin/cmake .
	make
	make install DESTDIR=$ad
	popd
}

#exit



function_install_cmake() {
	lnk=http://www.cmake.org/files/v3.1/cmake-3.1.0-rc3.tar.gz
	wget -nv $lnk
	fle=`echo $lnk | awk -F "/" '{ print $NF}'`
	tar -zxf $fle
	ad=$PI_HOME/Applications/`tar -zxvf $fle | head -n 1 | awk -F "/" '{ print $1}'`
	mkdir -p $ad/bin
	pushd `basename $ad`
	./bootstrap --prefix=$ad 
	make -j 8
	make install
	popd
}

function_install_MEME() {
	lnk=http://ebi.edu.au/ftp/software/MEME/4.10.0/meme_4.10.0_1.tar.gz
	wget -nv $lnk
	fle=`echo $lnk | awk -F "/" '{ print $NF}'`
	tar -zxf $fle
	ad=$PI_HOME/Applications/`tar -zxvf $fle | head -n 1 | awk -F "/" '{ print $1}'`
	mkdir -p $ad/bin
	pushd `basename $ad`
	./configure --prefix=$ad --with-url=http://meme.nbcr.net/meme --enable-build-libxml2 --enable-build-libxslt 
	make -j 16
	make test
	make install
	popd
}

function_install_IGV() {
	lnk=https://github.com/broadinstitute/IGV/archive/v2.3.34.tar.gz
	wget -nv $lnk
	fle=`echo $lnk | awk -F "/" '{ print $NF}'`
	tar -zxf $fle
	ad=$PI_HOME/Applications/`tar -zxvf $fle | head -n 1 | awk -F "/" '{ print $1}'`
	mkdir -p $ad/bin
	pushd `basename $ad`
	ant -Dinclude.libs=true
	# NOTE test skipped
	#FIXME
	#cp scripts/* *jar $ad/bin
	# ran igv.sh from tests folder after copying igv.jar there
	popd
}



function_install_eigen() {
	lnk=http://bitbucket.org/eigen/eigen/get/3.2.2.tar.gz
	wget -nv $lnk
	fle=`echo $lnk | awk -F "/" '{ print $NF}'`
	tar -zxf $fle
	ad=$PI_HOME/Applications/`tar -zxvf $fle | head -n 1 | awk -F "/" '{ print $1}'`
	mkdir -p $ad/bin
	pushd `basename $ad`
	mkdir build; pushd build
	#TODO cmake is old; get to use easyBuild
	cmake -DCMAKE_INSTALL_PREFIX=$ad ..
	make install
	popd
}

function_install_cufflinks() {
	#0.
	lnk=http://cufflinks.cbcb.umd.edu/downloads/cufflinks-2.2.1.Linux_x86_64.tar.gz
	wget -nv $lnk
	fle=`echo $lnk | awk -F "/" '{ print $NF}'`
	tar -zxf $fle
	ad=$PI_HOME/Applications/`tar -zxvf $fle | head -n 1 | awk -F "/" '{ print $1}'`
	mkdir -p $ad/bin
	pushd `basename $ad`
	popd

	return

	
	#1.
	eb SAMtools.0.1.19-ictce-5.5.0 --robot
	eb Eigen-3.2.0-ictce-5.5.0.eb --robot
	eb Cufflinks-2.0.2-goolf-1.4.10.eb --robot
#	eb Cufflinks-2.1.1-ictce-5.5.0.eb --robot
	#2.
	lnk=http://cufflinks.cbcb.umd.edu/downloads/cufflinks-2.2.1.tar.gz
	wget -nv $lnk
	fle=`echo $lnk | awk -F "/" '{ print $NF}'`
	tar -zxf $fle
	ad=$PI_HOME/Applications/`tar -zxvf $fle | head -n 1 | awk -F "/" '{ print $1}'`
	mkdir -p $ad/bin
	pushd `basename $ad`
	./configure --prefix=$ad --with-boost=$PI_HOME/Applications/boost_1_56_0 \
		--with-bam=$PI_HOME/Applications/samtools-0.1.19 --with-eigen=/path/to/eigen
	make -j 16
	make install
	popd
}

function_install_trim_galore() {

	lnk=http://www.bioinformatics.babraham.ac.uk/projects/trim_galore/trim_galore_v0.3.7.zip
	wget -nv $lnk
	fle=`echo $lnk | awk -F "/" '{ print $NF}'`
	unzip -q $fle
	ad=$PI_HOME/Applications/`unzip -l $fle | head -n 4 | tail -n 1 | awk '{ print $NF}' | awk -F '/' '{ print $1}'`
	mkdir -p $ad/bin
	pushd `basename $ad`
	cp trim_galore $ad/bin
	popd

}

function_install_easyBuild() { #NOT used
	#1
	wget --no-check-certificate https://raw.github.com/hpcugent/easybuild-framework/develop/easybuild/scripts/bootstrap_eb.py
	#export EASYBUILD_PREFIX=$PI_HOME
	python bootstrap_eb.py $EASYBUILD_PREFIX
	#export MODULEPATH=$EASYBUILD_PREFIX/modules/all:$MODULEPATH
	module load EasyBuild
	eb HPL-2.0-goalf-1.1.0-no-OFED.eb --robot
	return
	#2.
	pip install --root=$PI_HOME easybuild
}

function_install_MACS2() {
	#https://pypi.python.org/pypi/MACS2
	lnk=https://pypi.python.org/packages/source/M/MACS2/MACS2-2.1.0.20151222.tar.gz
	lnk=https://pypi.python.org/packages/source/M/MACS2/MACS2-2.1.1.20160226.tar.gz
	wget -nv $lnk
	fle=`echo $lnk | awk -F "/" '{ print $NF}'`
	tar -zxf $fle
	ad=$PI_HOME/Applications/`tar -zxvf $fle | head -n 1 | awk -F "/" '{ print $1}'`
	mkdir -p $ad/bin
	pushd `basename $ad`
	#perl -pi -e 's/Ofast/O3/g' setup.py # path for gcc error for -Ofast option
	#python setup.py install
	#./configure --build=x86_64-unknown-linux-gnu --prefix=$ad --with-pydebug
	python setup.py install
	chmod 755 bin/macs2
	cp bin/* $ad/bin/.
	popd

}

function_install_chromHMM() {
	lnk=http://compbio.mit.edu/ChromHMM/ChromHMM.zip
	wget -nv $lnk
	fle=`echo $lnk | awk -F "/" '{ print $NF}'`
	unzip -q $fle
	ad=$PI_HOME/Applications/`unzip -l $fle | head -n 4 | tail -n 1 | awk '{ print $NF}' | awk -F '/' '{ print $1}'`
	mkdir -p $ad/bin
	pushd `basename $ad`
	cp ChromHMM.jar $ad/bin/.
	popd

}

function_install_parallel() {
	lnk=http://ftp.gnu.org/gnu/parallel/parallel-20160122.tar.bz2
	fle=`echo $lnk | awk -F "/" '{ print $NF}'`
	wget -nv $lnk
	tar -xjf $fle
	ad=$PI_HOME/Applications/parallel-20160122
	pushd `basename $ad`
	./configure --prefix=$ad
	make -j 16
	make install
	popd
}

function_install_pysqlite() {
	#TODO install it
	lnk=https://github.com/ghaering/pysqlite/archive/2.8.2.tar.gz
	wget -nv $lnk
	fle=`echo $lnk | awk -F "/" '{ print $NF}'`
	mv $fle pysqlite-$fle
	fle=pysqlite-$fle
	tar -zxf $fle
	ad=$PI_HOME/Applications/`tar -zxvf $fle | head -n 1 | awk -F "/" '{ print $1}'`
	mkdir -p $ad/bin
	pushd `basename $ad`
	python setup.py install
	popd
}

# TODO
# install HOWTO http://kornesh92.blogspot.com/
function_install_cuda() {
# root permissions are required for CUDA installer:
# http://stackoverflow.com/questions/39379792/install-cuda-without-root
	lnk=https://developer.nvidia.com/compute/cuda/8.0/prod/local_installers/cuda_8.0.44_linux-run
	fle=cuda_8.0.44_linux.run
	wget -O $fle $lnk
	ad=$PI_HOME/Applications/${fle/.run/}
	#TODO
	sh $fle --tmpdir=${ad##*/} --driver --toolkit --toolkitpath
}

function_install_cudnn() {
	# moved a locally downloaded file here
	fle=cudnn-8.0-linux-x64-v5.1.tgz
	ad=$PI_HOME/Applications/${fle/.tgz/}
	tar -zxf $fle; #extracts into a directory called cuda
	mkdir -p $ad/lib64
	mkdir -p $ad/include
	#pushd `basename $ad`
	cp cuda/lib64/* $ad/lib64/. 
	cp cuda/include/* $ad/include/. 
}

# TODO did not work
# current tensorflow version does not compile with this LMOD bazel version
function_install_bazel() {
	lnk=https://github.com/bazelbuild/bazel/releases/download/0.4.3/bazel-0.4.3-dist.zip
	fle=${lnk##*/}
	wget $lnk -O $fle
	ad=$PI_HOME/Applications/${fle/.zip}
	mkdir -p ${ad##*/}; pushd ${ad##*/};
	unzip -q ../$fle
	tmpdir=$TMPDIR
	mkdir -p $HOME/TMP
	export TMPDIR=$HOME/TMP
	ml load java/8u91
	#export JAVA_HOME=/share/sw/free/java/8u91/
	#ml load protobuf/2.6.1rc1 java/8u91
	./compile.sh compile
	export TMPDIR=$tmpdir
	popd
}

function_install_python_tensorflow() {
	virtualenv --system-site-packages ~/PI_HOME/PythonSandbox/tensorflow
	source ~/PI_HOME/PythonSandbox/tensorflow/bin/activate
	#pip install -U pyDNase pysam numpy sklearn scipy utils cython pyBigWig
	pip install -U pyDNase pysam numpy sklearn scipy utils cython pyBigWig
	ml load bazel/0.2.0 cuda/8.0 
	export LD_LIBRARY_PATH=/share/sw/free/cuda/8.0/lib64:/share/sw/free/cuda/8.0/extras/CUPTI/lib64:$LD_LIBRARY_PATH
	export CUDA_HOME=/share/sw/free/cuda/8.0/
	export CUDNN_HOME=/share/PI/casco/Applications/cudnn-8.0-linux-x64-v5.1/
	mkdir -p tmp
	wget https://github.com/bazelbuild/bazel/releases/download/0.4.3/bazel-0.4.3-installer-linux-x86_64.sh
	bazel build --local_resources 2048,.5,1.0 -c opt --config=cuda //tensorflow/tools/pip_package:build_pip_package
	bazel clean --expunge_async

	git clone https://github.com/tensorflow/tensorflow githubtensorflow
	pushd githubtensorflow
	TF_UNOFFICIAL_SETTING=1 ./configure

	popd
	# instructions from https://www.tensorflow.org/versions/master/get_started/os_setup#virtualenv_installation
	# Ubuntu/Linux 64-bit, GPU enabled, Python 2.7
	# Requires CUDA toolkit 8.0 and CuDNN v5. For other versions, see "Installing from sources" below.
	#export TF_BINARY_URL=https://storage.googleapis.com/tensorflow/linux/gpu/tensorflow_gpu-0.12.1-cp27-none-linux_x86_64.whl
	#pip install -U $TF_BINARY_URL
	##pip uninstall $TF_BINARY_URL

	deactivate

	# R package rstudio/tensorflow is installed from a gpu node
	# biter$ salloc -p gpu --gres=gpu:1
	# biter$ ssh [ALLOC_GPU_NODE] #sqbit
	# biter$ ml load python/2.7.5 tensorflow/0.9.0
	# biter$ R
	# > devtools::install_github("rstudio/tensorflow") #inside R
}

# Install instaructions are for only CPU; LMOD theano does work only on CPU even in a GPU node
#http://deeplearning.net/software/theano/install.html#centos-6
# TODO gpu support http://deeplearning.net/software/theano/install.html#gpu-linux
function_install_python_theano() {
	virtualenv --system-site-packages ~/PI_HOME/PythonSandbox/theano
	source ~/PI_HOME/PythonSandbox/theano/bin/activate
	ml load cuda/8.0 cuDNN/v5.1
	pip install -U nose nose_parameterized pyDNase pysam numpy sklearn scipy cython pyBigWig sortedcontainers jupyter theano keras seaborn biopython plotly bokeh
	ml load xz/5.2.2
	pip install -U rpy2
	ml load hdf5/1.8.16; ml show hdf5 
	pip install -U tables
	#pip install -U dask[complete] # did not read a simple file
	theano-cache clear
	python -c 'import sys; print(sys.path); from sklearn import metrics'
	deactivate

	# test
	source ~/PI_HOME/PythonSandbox/theano/bin/activate
	ml load cuda/8.0 cuDNN/v5.1
	# if on a gpu node; also test gpu related tests
	python -c 'import theano; theano.test()' &> test_theano.log
	deactivate
}

function_install_python_cutadapt() {
	virtualenv --system-site-packages ~/PI_HOME/PythonSandbox/cutadapt
	source ~/PI_HOME/PythonSandbox/cutadapt/bin/activate
	pip install -U cutadapt
	deactivate
}

function_install_python_deeptools() {
	virtualenv --system-site-packages ~/PI_HOME/PythonSandbox/deeptools
	source ~/PI_HOME/PythonSandbox/deeptools/bin/activate
	pip install -U deeptools
	deactivate
}

function_install_python_MACS2() {
	virtualenv --system-site-packages ~/PI_HOME/PythonSandbox/MACS2
	source ~/PI_HOME/PythonSandbox/MACS2/bin/activate
	pip install -U numpy
	pip install -U MACS2
	deactivate
}

function_install_picard() {
	lnk=https://github.com/broadinstitute/picard/releases/download/2.9.4/picard.jar
	dir=picard_2.9.4
	fle=$dir/picard.jar
	mkdir -p $dir
	cd $dir
	wget -nv $lnk
	ad=$PI_HOME/Applications/$dir/bin
	mkdir -p $ad
	cp picard.jar $ad/


}

function_install_python() {
	lnk=https://www.python.org/ftp/python/2.7.11/Python-2.7.11.tgz
	lnk=https://www.python.org/ftp/python/2.7.13/Python-2.7.13.tgz
	#ml load gcc/4.9.1 # theano and CUDA are compiled with this version but got ImportError: /usr/lib64/libstdc++.so.6: version `GLIBCXX_3.4.21' not found (required by /home/biter/PI_HOME/PythonSandbox/4theano2/lib/python2.7/site-packages/scipy/sparse/_sparsetools.so); so swicthed back to gcc/5.3.0
	#ml load gcc/5.3.0  # loaded by default
	wget -nv $lnk
	fle=${lnk##*/}
	tar -zxf $fle
	ad=$PI_HOME/Applications/`tar -zxvf $fle | head -n 1 | awk -F "/" '{ print $1}'`
	mkdir -p $ad/bin
	pushd `basename $ad`
	#./configure --prefix=$ad --build=x86_64-unknown-linux-gnu --with-pydebug --enable-loadable-sqlite-extensions --with-ensurepip --enable-shared
	./configure --prefix=$ad --build=x86_64-unknown-linux-gnu --with-pydebug --with-ensurepip --enable-shared
	make -j 16
	make install
	popd

	for d in bin lib include; do
		pushd $HOME/$d
		ln -sf $ad/$d/* .
		popd
	done

	for d in lib/pkgconfig; do
		pushd $HOME/$d
		ln -sf $ad/$d/* .
		popd
	done

	pip install -U pip setuptools irc virtualenv; #upgrade pip with the current pip

	for d in bin lib include; do
		pushd $HOME/$d
		ln -sf $ad/$d/* .
		popd
	done

	for d in lib/pkgconfig; do
		pushd $HOME/$d
		ln -sf $ad/$d/* .
		popd
	done
	# END Python-2.7.13.tgz do the rest as in virtual environment

	pip install -U pip setuptools irc virtualenv; #upgrade pip with the current pip
	pip install -U MACS2 
	pip install -U cutadapt
	pip install -U pysqlite
	pip install -U scipy numpy matplotlib xlwt cython numexpr drmaa plotly rpy2

	pip install -U distribute; # skip running function_install_RSeQC
	pip install -U multiqc

	# gcc loading in .bashrc 

	pip install -U deeptools 

	pip freeze > macs2_deeptools_requirements.txt; #pip install -r macs2_deeptools_requirements.txt

	# install_mpich install_hdf5
	ml load gcc/4.9.1
	pip install -U h5py

	pip install -U pyBigWig

	pip install -U genomedata # in .bashrc: export C_INCLUDE_PATH=$HOME/include:$C_INCLUDE_PATH
	pip install -U segtools segway
	# run this for segtools R script issues
	ln -sf /share/PI/casco/Applications/R-3.2.4/lib64/R/lib/libRlapack.so $HOME/lib/libRlapack.so

}

function_install_bedops() {
	ml load gcc/4.9.1 #C++11 error
	lnk=https://github.com/bedops/bedops/archive/v2.4.16.tar.gz
	wget -nv $lnk
	fles=`echo $lnk | awk -F "/" '{ print $NF}'`
	fle=bedops-`echo $lnk | awk -F "/" '{ print $NF}'`
	mv $fles $fle
	tar -zxf $fle
	ad=$PI_HOME/Applications/`tar -zxvf $fle | head -n 1 | awk -F "/" '{ print $1}'`
	mkdir -p $ad/bin
	pushd `basename $ad`
	make
	make install
	popd


}

function_install_pytables() {
	lnk=https://github.com/PyTables/PyTables/archive/v.3.2.2.tar.gz
	wget -nv $lnk
	fles=`echo $lnk | awk -F "/" '{ print $NF}'`
	fle=PyTables-`echo $lnk | awk -F "/" '{ print $NF}'`
	mv $fles $fle
	tar -zxf $fle
	ad=$PI_HOME/Applications/`tar -zxvf $fle | head -n 1 | awk -F "/" '{ print $1}'`
	mkdir -p $ad/bin
	pushd `basename $ad`
	python setup.py install --hdf5=/share/PI/casco/Applications/hdf5-1.8.16/
	popd
}


# required for hdf5 --enable-parallel
# not required for hdf5 --enable-cxx 
function_install_mpich() {
	lnk=http://www.mpich.org/static/downloads/3.2/mpich-3.2.tar.gz
	fle=`echo $lnk | awk -F "/" '{ print $NF}'`
	wget -nv $lnk
	tar -zxf $fle
	ad=$PI_HOME/Applications/`tar -zxvf $fle | head -n 1 | awk -F "/" '{ print $1}'`
	mkdir -p $ad/bin
	pushd `basename $ad`
	./configure --prefix=$ad --enable-fast=all,O3
	make -j 16
	make install
	popd

}

function_install_hdf5() {
	ml load gcc/4.9.1
	lnk=http://www.hdfgroup.org/ftp/HDF5/current/src/hdf5-1.8.16.tar.gz
	#https://trac.macports.org/ticket/49810
	# https://www.hdfgroup.org/ftp/HDF5/current/src/unpacked/release_docs/INSTALL
	fle=`echo $lnk | awk -F "/" '{ print $NF}'`
	wget -nv $lnk
	tar -zxf $fle
	ad=$PI_HOME/Applications/`tar -zxvf $fle | head -n 1 | awk -F "/" '{ print $1}'`
	mkdir -p $ad/bin
	pushd `basename $ad`
	#./configure --prefix=$ad --enable-parallel --enable-production #--disable-hl 
	./configure --prefix=$ad --enable-cxx --enable-production #required for h5c++
	make -j 16
	make install
	popd
}

# required for segway
function_install_gmtk() {
	lnk=http://melodi.ee.washington.edu/downloads/gmtk/gmtk-1.4.4.tar.gz
	fle=`echo $lnk | awk -F "/" '{ print $NF}'`
	wget -nv $lnk
	tar -zxf $fle
	ad=$PI_HOME/Applications/`tar -zxvf $fle | head -n 1 | awk -F "/" '{ print $1}'`
	mkdir -p $ad/bin
	pushd `basename $ad`
	./configure --prefix=$ad --with-hdf5=yes
	make -j 16
	make install
	popd
}

function_install_RSeQC() {
	# The distribute version used in the program is not compatible for segtools
	lnk=http://downloads.sourceforge.net/project/rseqc/RSeQC-2.6.3.tar.gz
	wget -nv $lnk
	fle=`echo $lnk | awk -F "/" '{ print $NF}'`
	tar -zxf $fle
	ad=$PI_HOME/Applications/`tar -zxvf $fle | head -n 1 | awk -F "/" '{ print $1}'`
	mkdir -p $ad/bin
	pushd `basename $ad`
	python setup.py install
	popd
}

function_install_bowtie() {
	lnk=http://sourceforge.net/projects/bowtie-bio/files/bowtie/1.1.1/bowtie-1.1.1-src.zip
	wget -nv $lnk
	fle=`echo $lnk | awk -F "/" '{ print $NF}'`
	unzip -q $fle
	ad=$PI_HOME/Applications/`unzip -l $fle | head -n 4 | tail -n 1 | awk '{ print $NF}' | awk -F '/' '{ print $1}'`
	mkdir -p $ad/bin
	pushd `basename $ad`
	make -j 16
	cp bowtie bowtie-align-l bowtie-align-s bowtie-build bowtie-build-l \
	 	bowtie-build-s bowtie-inspect bowtie-inspect-l bowtie-inspect-s $ad/bin
	popd
}

function_install_bismark() {
	lnk=http://www.bioinformatics.babraham.ac.uk/projects/bismark/bismark_v0.16.0.tar.gz
	wget -nv $lnk
	fle=`echo $lnk | awk -F "/" '{ print $NF}'`
	tar -zxf $fle
	ad=$PI_HOME/Applications/`tar -zxvf $fle | head -n 1 | awk -F "/" '{ print $1}'`
	mkdir -p $ad/bin
	pushd `basename $ad`
	cp deduplicate_bismark coverage2cytosine bismark_methylation_extractor bismark_genome_preparation bismark2summary bismark2report bismark2bedGraph bismark bam2nuc /share/PI/casco/Applications/bismark_v0.16.0/bin/. 
	popd
}

function_install_bowtie2() {
	lnk=http://sourceforge.net/projects/bowtie-bio/files/bowtie2/2.2.3/bowtie2-2.2.3-source.zip
	lnk=http://sourceforge.net/projects/bowtie-bio/files/bowtie2/2.2.6/bowtie2-2.2.6-source.zip
	wget -nv $lnk
	fle=`echo $lnk | awk -F "/" '{ print $NF}'`
	unzip -q $fle
	ad=$PI_HOME/Applications/`unzip -l $fle | head -n 4 | tail -n 1 | awk '{ print $NF}' | awk -F '/' '{ print $1}'`
	mkdir -p $ad/bin
	pushd `basename $ad`
	make -j 16
	cp bowtie2 bowtie2-align-s bowtie2-align-l bowtie2-build bowtie2-build-s bowtie2-build-l \
		bowtie2-inspect bowtie2-inspect-s bowtie2-inspect-l $ad/bin
	popd
}

function_install_boost() {
	lnk=http://sourceforge.net/projects/boost/files/boost/1.56.0/boost_1_56_0.tar.gz
	wget -nv $lnk
	fle=`echo $lnk | awk -F "/" '{ print $NF}'`
	tar -zxf $fle
	ad=$PI_HOME/Applications/`tar -zxvf $fle | head -n 1 | awk -F "/" '{ print $1}'`
	mkdir -p $ad/bin
	pushd `basename $ad`
	./bootstrap.sh
	./bjam --prefix=$ad link=static runtime-link=static stage install
	popd

}

function_install_tophat() {
	lnk=http://ccb.jhu.edu/software/tophat/downloads/tophat-2.0.12.Linux_x86_64.tar.gz
	wget -nv $lnk
	fle=`echo $lnk | awk -F "/" '{ print $NF}'`
	tar -zxf $fle
	ad=$PI_HOME/Applications/`tar -zxvf $fle | head -n 1 | awk -F "/" '{ print $1}'`
	mkdir -p $ad/bin
	pushd `basename $ad`
	cp tophat* sra_to_solid segment_juncs sam_juncs prep_reads map2gtf long_spanning_reads \
		juncs_db gtf_* fix_map_ordering contig_to_chr_coords bed_to_juncs bam* $ad/bin/

	return;
	#TODO didn't work
	lnk=http://ccb.jhu.edu/software/tophat/downloads/tophat-2.0.12.tar.gz
	wget -nv $lnk
	fle=`echo $lnk | awk -F "/" '{ print $NF}'`
	tar -zxf $fle
	ad=$PI_HOME/Applications/`tar -zxvf $fle | head -n 1 | awk -F "/" '{ print $1}'`
	mkdir -p $ad/bin
	pushd `basename $ad`
	#TODO
	./configure --prefix=$ad --with-boost=$PI_HOME/Applications/boost_1_56_0 \
		--with-bam=$PI_HOME/Applications/samtools-0.1.19
	make -j 16
	make install
	popd

}

function_install_ruby() {

	lnk=http://cache.ruby-lang.org/pub/ruby/2.1/ruby-2.1.2.tar.gz
	wget -nv $lnk
	fle=`echo $lnk | awk -F "/" '{ print $NF}'`
	tar -zxf $fle
	ad=$PI_HOME/Applications/`tar -zxvf $fle | head -n 1 | awk -F "/" '{ print $1}'`
	mkdir -p $ad/bin
	pushd `basename $ad`
	./configure --prefix=$ad
	make -j 16
	make install
	popd

}

function_install_rubygems() { #TODO ?? is it included in ruy package?
	lnk=http://production.cf.rubygems.org/rubygems/rubygems-2.4.1.tgz
	fle=`echo $lnk | awk -F "/" '{ print $NF}'`
	wget -nv $lnk
	tar -zxf $fle
	ad=$PI_HOME/Applications/`tar -zxvf $fle | head -n 1 | awk -F "/" '{ print $1}'`
	mkdir -p $ad/bin
	pushd `basename $ad`
	./configure --prefix=$ad
	make -j 16
	make install
	popd
}

function_install_gnucoreutils() {
	lnk=http://ftp.gnu.org/gnu/coreutils/coreutils-8.25.tar.xz
	fle=`echo $lnk | awk -F "/" '{ print $NF}'`
	wget -nv $lnk
	tar -xJf $fle
	ad=$PI_HOME/Applications/`tar -xJvf $fle | head -n 1 | awk -F "/" '{ print $1}'`
	mkdir -p $ad/bin
	pushd `basename $ad`
	./configure --prefix=$ad
	make -j 16
	make install
	popd



}

function_install_texlive() { #TODO
	lnk=ftp://tug.org/historic/systems/texlive/2014/texlive-20140525-source.tar.xz
	fle=`echo $lnk | awk -F "/" '{ print $NF}'`
	wget -nv $lnk
	tar -xJf $fle
	ad=$PI_HOME/Applications/`tar -xJvf $fle | head -n 1 | awk -F "/" '{ print $1}'`
	mkdir -p $ad/bin
	pushd `basename $ad`
	./configure --prefix=$ad
	make -j 16
	make install
	popd
}


function_install_bedtools() {
	lnk=https://github.com/arq5x/bedtools2/archive/master.zip
	wget -nv $lnk
	fles=`echo $lnk | awk -F "/" '{ print $NF}'`
	fle=bedtools2-`echo $lnk | awk -F "/" '{ print $NF}'`
	ad=$PI_HOME/Applications/`unzip -l $fle | head -n 5 | tail -n 1 | awk '{ print $NF}' | awk -F '/' '{ print $1}'`
	mv $fles $fle
	unzip -q $fle
	d=`basename $fle .zip`; mkdir -p $d;
	pushd $d
	make -j 8

	mkdir -p $ad/bin $ad/aux
	cp -rf bin/bedtools $ad/bin/.
	cp -rf genomes $ad/aux/genomes
	popd
}

function_install_bedtools_checkAbove() {
	#wget -nv https://github.com/arq5x/bedtools2/archive/v2.20.1.tar.gz -O bedtools2.v2.20.1.tar.gz
	#ad=$PI_HOME/Applications/`tar -zxvf bedtools2.v2.20.1.tar.gz | head -n 1 | awk -F "/" '{ print $1}'`
	lnk=https://github.com/arq5x/bedtools2/releases/download/v2.25.0/bedtools-2.25.0.tar.gz
	fle=`echo $lnk | awk -F "/" '{ print $NF}'`
	wget -nv $lnk
	d=`basename $fle .tar.gz`; mkdir -p $d;
	tar -zxf $fle -C $d; mv $d/*/* $d/.; 
	pushd $d
	make -j 8
	less genomes/mouse.mm10.genome.txt | awk '{OFS="\t"; print $1,$2 }' > genomes/mouse.mm10.genome

	ad=$PI_HOME/Applications/$d
	mkdir -p $ad/bin $ad/aux
	cp -rf bin/bedtools $ad/bin/.
	cp -rf genomes $ad/aux/genomes

	popd
}

function_install_fastqc() {
	lnk=http://www.bioinformatics.babraham.ac.uk/projects/fastqc/fastqc_v0.11.5.zip
	wget -nv $lnk
	fle=`echo $lnk | awk -F "/" '{ print $NF}'`
	unzip -q $fle
	mv FastQC fastqc_v0.11.5
	ad=$PI_HOME/Applications/fastqc_v0.11.5
	pushd `basename $ad`
	chmod 755 fastqc
	sfle=`pwd`/fastqc
	mkdir -p $ad/bin; cd $ad/bin; ln -sf $sfle .
	popd
}


function_install_curl() {
	lnk=https://curl.haxx.se/download/curl-7.47.1.tar.bz2
	fle=`echo $lnk | awk -F "/" '{ print $NF}'`
	wget -nv $lnk
	tar -xjf $fle
	ad=$PI_HOME/Applications/curl-7.47.1
	mkdir -p $ad/bin 
	pushd `basename $ad`
	./configure --prefix=$ad 
	make -j 16
	make install
	popd

}

function_install_htslib() {
	lnk=https://github.com/samtools/htslib/releases/download/1.3/htslib-1.3.tar.bz2
	lnk=https://sourceforge.net/projects/samtools/files/samtools/1.3.1/htslib-1.3.1.tar.bz2
	fle=`echo $lnk | awk -F "/" '{ print $NF}'`
	wget -nv $lnk
	tar -xjf $fle
	ad=$PI_HOME/Applications/`tar -jxvf $fle | head -n 1 | awk -F "/" '{ print $1}'`
	pushd `basename $ad`
	make -j 8 prefix=$ad install
	popd

}
function_install_bcftools() {
	#lnk=http://sourceforge.net/projects/samtools/files/samtools/1.2/samtools-1.2.tar.bz2
	lnk=https://sourceforge.net/projects/samtools/files/samtools/1.3.1/bcftools-1.3.1.tar.bz2
	fle=`echo $lnk | awk -F "/" '{ print $NF}'`
	wget -nv $lnk
	tar -xjf $fle
	ad=$PI_HOME/Applications/`tar -jxvf $fle | head -n 1 | awk -F "/" '{ print $1}'`
	pushd `basename $ad`
	make -j 8 prefix=$ad install
	popd
}
function_install_samtools() {
	lnk=https://sourceforge.net/projects/samtools/files/samtools/1.3.1/samtools-1.3.1.tar.bz2
	fle=`echo $lnk | awk -F "/" '{ print $NF}'`
	wget -nv $lnk
	tar -xjf $fle
	ad=$PI_HOME/Applications/`tar -jxvf $fle | head -n 1 | awk -F "/" '{ print $1}'`
	pushd `basename $ad`
	make -j 8 prefix=$ad install
	popd
}

function_install_methylextract() {
	lnk=http://downloads.sourceforge.net/project/methylextract/MethylExtract_1.8.1/MethylExtract.tgz
	fle=`echo $lnk | awk -F "/" '{ print $NF}'`
	wget -nv $lnk
	tar -zxf $fle
	ad=$PI_HOME/Applications/`tar -zxvf $fle | head -n 1 | awk -F "/" -v i=2 '{ print $2}'`
	mkdir -p $ad/bin
	pushd `basename $ad`
	chmod 755 *pl
	cp *pl $ad/bin/. 
	popd
}

function_install_libevent() {
	#curl -0 https://github.com/downloads/libevent/libevent/libevent-2.0.21-stable.tar.gz > libevent-2.0.21-stable.tar.gz
	#tar -xzf libevent-2.0.21-stable.tar.gz
	#ad=$PI_HOME/Applications/libevent-2.0.21-stable
	lnk=https://github.com/libevent/libevent/releases/download/release-2.0.22-stable/libevent-2.0.22-stable.tar.gz
	wget -nv $lnk
	fle=`echo $lnk | awk -F "/" '{ print $NF}'`
	tar -zxf $fle
	ad=$PI_HOME/Applications/`tar -zxvf $fle | head -n 1 | awk -F "/" '{ print $1}'`
	mkdir -p $ad
	pushd `basename $ad`
	./configure --prefix=$ad --disable-shared
	make -j 8
	make install
	popd
}

function_install_ncurses() {
	lnk=ftp://ftp.gnu.org/gnu/ncurses/ncurses-6.0.tar.gz
	wget -nv $lnk
	fle=`echo $lnk | awk -F "/" '{ print $NF}'`
	tar -zxf $fle
	ad=$PI_HOME/Applications/`tar -zxvf $fle | head -n 1 | awk -F "/" '{ print $1}'`
	mkdir -p $ad
	pushd `basename $ad`
	./configure --prefix=$ad LDFLAGS="-static"
	make -j 8
	make install
	popd

}

function_install_tmux() {
	lnk=https://github.com/tmux/tmux/releases/download/2.2/tmux-2.2.tar.gz
	wget -nv $lnk
	fle=`echo $lnk | awk -F "/" '{ print $NF}'`
	tar -zxf $fle
	ad=$PI_HOME/Applications/`tar -zxvf $fle | head -n 1 | awk -F "/" '{ print $1}'`
	mkdir -p $ad
	pushd `basename $ad`
	# Comment out as below or set PKG_CONFIG in the command line
	# #PKG_CONFIG="pkg-config --static"
	./configure --prefix=$ad PKG_CONFIG=/bin/false  CFLAGS="-I$HOME/include" LDFLAGS="-L$HOME/lib -L$HOME/include" \
		CPPFLAGS="-I$HOME/include" LDFLAGS="-static -L$HOME/include -L$HOME/lib" 
	make -j 8
	make install
	popd
}


function_install_bilebi00() {
	ad=$PI_HOME/Applications/bilebi00
	mkdir $ad; 
	pushd $ad
	rsync -rqt bilebi00@login.bc2.unibas.ch:/import/bc2/home/zavolan/GROUP/bilebi00/* . 2> rsync.err
	popd
}

function_install_vim() {
	#wget -nv ftp://ftp.vim.org/pub/vim/unix/vim-7.4.tar.bz2
	#tar -xjf vim-7.4.tar.bz2 
	#ad=$PI_HOME/Applications/vim74
	lnk=https://github.com/vim/vim/archive/v7.4.2294.tar.gz
	wget -nv $lnk
	fle=`echo $lnk | awk -F "/" '{ print $NF}'`
	tar -zxf $fle
	ad=$PI_HOME/Applications/`tar -zxvf $fle | head -n 1 | awk -F "/" '{ print $1}'`
	mkdir -p $ad
	pushd `basename $ad`
	# with-features and enable-gui since Nvim-R requires +channel +job +conceal 
	# enable-rubyinterp added since command-t.git requires ruby+
	./configure --prefix=$ad --with-features=huge --enable-gui=gtk2 --enable-rubyinterp=yes
	make -j 8
	make install
	popd
}

