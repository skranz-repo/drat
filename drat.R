#install.packages("drat")

example.drat = function() {
  library(drat)
  repodir = "D:/libraries/drat/drat"
  libdir = "D:/libraries"
  
  insert.drat("BLPestimator", repodir,libdir)
  insert.drat("stringtools", repodir,libdir)
  insert.drat("restorepoint", repodir,libdir)
  
  
  drat::addRepo("skranz-repo")
  install.packages("restorepoint")
  
  install.packages("restorepoint",repos = "https://skranz-repo.github.io/drat/")
  
  install.packages("restorepoint",repos = "file:D:/libraries/drat/drat")
}

insert.drat = function(pkg,repodir=getwd(),libdir, pkg.dir=file.path(libdir, pkg, pkg)) {
  
  dir = file.path(libdir, pkg, pkg)
  src = devtools::build(dir)
  insertPackage(src, repodir)
  bin = devtools::build(dir, binary = TRUE, args = c('--preclean'))
  insertPackage(bin, repodir)
 
}