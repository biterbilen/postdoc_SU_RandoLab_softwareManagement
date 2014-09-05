cd $PI_HOME 
mkdir -p Downloads Applications
chmod 770 Downloads Applications; chmod o+t Downloads Applications
pushd Downloads

# -----test

# -----test END

# function_install_easyBuild
# function_install_python3
# function_install_boost
# function_install_tophat
# function_install_bowtie2
# function_install_ruby
# function_install_vim
# function_install R
# function_install_bilebi00
# function_install_samtools
# function_install_bedtools
# function_install_texlive

popd

exit

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


function_install_cutadapt() {
	pip install --root=$PI_HOME cutadapt
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

function_install_python3() {
	lnk=https://www.python.org/ftp/python/3.4.1/Python-3.4.1.tgz
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


function_install_bowtie2() {

	lnk=http://sourceforge.net/projects/bowtie-bio/files/bowtie2/2.2.3/bowtie2-2.2.3-source.zip
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
	wget -nv https://github.com/arq5x/bedtools2/archive/v2.20.1.tar.gz -O bedtools2.v2.20.1.tar.gz
	tar -zxf bedtools2.v2.20.1.tar.gz 
	ad=$PI_HOME/Applications/`tar -zxvf bedtools2.v2.20.1.tar.gz | head -n 1 | awk -F "/" '{ print $1}'`
	mkdir -p $ad/bin
	pushd `basename $ad`
	make -j 8
	cp -rf bin/bedtools $ad/bin/.

	popd
}


function_install_samtools() {
	wget -nv http://sourceforge.net/projects/samtools/files/samtools/0.1.19/samtools-0.1.19.tar.bz2
	tar -xjf samtools-0.1.19.tar.bz2
	ad=$PI_HOME/Applications/samtools-0.1.19
	mkdir -p $ad/bin
	pushd `basename $ad`
	make
	make razip
	cp samtools bcftools/bcftools `ls -l misc/* | grep "\-rwxr-x" | awk '{ print $NF; }' ` $ad/bin/.
	popd
}

function_install_libevent() {
	curl -0 https://github.com/downloads/libevent/libevent/libevent-2.0.21-stable.tar.gz > libevent-2.0.21-stable.tar.gz
	tar -xzf libevent-2.0.21-stable.tar.gz
	ad=$PI_HOME/Applications/libevent-2.0.21-stable
	mkdir -p $ad
	pushd `basename $ad`
	./configure --prefix=$ad
	make -j 8
	make install
	popd
}

function_install_tmux() {
	wget -nv http://downloads.sourceforge.net/project/tmux/tmux/tmux-1.9/tmux-1.9a.tar.gz
	tar -xzf tmux-1.9a.tar.gz
	ad=$PI_HOME/Applications/tmux-1.9a
	mkdir -p $ad
	pushd `basename $ad`
	./configure --prefix=$ad
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
	wget -nv ftp://ftp.vim.org/pub/vim/unix/vim-7.4.tar.bz2
	tar -xjf vim-7.4.tar.bz2 
	ad=$PI_HOME/Applications/vim74
	mkdir -p $ad
	pushd `basename $ad`
	./configure --prefix=$ad
	make -j 8
	make install
	popd
}

function_install_R() {
	get -nv http://cran.r-project.org/src/base/R-3/R-3.1.1.tar.gz
	tar -xzf R-3.1.1.tar.gz
	ad=$PI_HOME/Applications/R-3.1.1
	mkdir -p $ad
	pushd `basename $ad`
	./configure --prefix=$ad
	make -j 8
	make install
	popd
}
