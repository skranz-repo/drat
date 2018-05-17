#install.packages("drat")

example.drat = function() {
  library(drat)
  repodir = "D:/libraries/drat/drat"
  libdir = "D:/libraries"
  
  insert.drat("BLPestimator", repodir,libdir)
  insert.drat("stringtools", repodir,libdir)
  insert.drat("restorepoint", repodir,libdir)
  
  
  drat::addRepo("skranz")
  install.packages("stringtools")
}

insert.drat = function(pkg,repodir=getwd(),libdir, pkg.dir=file.path(libdir, pkg, pkg)) {
  
  dir = file.path(libdir, pkg, pkg)
  src = devtools::build(dir)
  insertPackage(file, repodir)
  bin = devtools::build(dir, binary = TRUE, args = c('--preclean'))
  insertPackage(bin, repodir)
 
}