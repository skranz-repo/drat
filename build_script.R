setwd("D:/libraries/drat")
repodir = "D:/libraries/drat/drat"
pkg.dir = readLines("pkgdir.txt")

cat("\nBuild binaries of ", pkg.dir)
bin = devtools::build(pkg.dir, binary = TRUE, args = c('--preclean'))
cat("\nAdd to drat... ")
drat::insertPackage(bin, repodir)

cat("\nInstall binary package...")
install.packages(bin repos=NULL)
cat("\nDone!")
