# From https://www.r-bloggers.com/how-to-upgrade-r-without-losing-your-packages/
# USAGE:
# R --no-save --args 1 < upgradeR.R &> log.1
# R --no-save --args 3 < upgradeR.R &> log.3
# R --no-save --args 4 < upgradeR.R &> log.4
#
#1. Before you upgrade, build a temp file with all of your old packages.
task <- commandArgs(trailingOnly=T)

if (task == 1 ) {
	tmp <- installed.packages()
	installedpkgs <- as.vector(tmp[is.na(tmp[,"Priority"]), 1])
	save(installedpkgs, file="installed_old.rda")
}

#2. Install the new version of R and let it do it’s thing.

#3. Once you’ve got the new version up and running, reload the saved packages and re-install them from CRAN.
if (task == 3) {
	system("module load gcc curl")
	load("installed_old.rda")
	sessionInfo()
	tmp <- installed.packages()
	installedpkgs.new <- as.vector(tmp[is.na(tmp[,"Priority"]), 1])
	missing <- setdiff(installedpkgs, installedpkgs.new)
	install.packages(missing)
	update.packages()
}

#4. Note: If you had any packages from BioConductor, you can update those too!
if (task == 4) {
	system("module load gcc curl")
	load("installed_old.rda")

	source("https://bioconductor.org/biocLite.R")
	#chooseBioCmirror()
	biocLite()
	load("installed_old.rda")
	tmp <- installed.packages()
	installedpkgs.new <- as.vector(tmp[is.na(tmp[,"Priority"]), 1])
	missing <- setdiff(installedpkgs, installedpkgs.new)
	for (i in 1:length(missing)) biocLite(missing[i], ask=F)
	installed.packages()
}


if (task == 5) {
	install.packages("devtools")
	devtools::install_github("jalvesaq/colorout") 
}
