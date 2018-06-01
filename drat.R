#install.packages("drat")

example.drat = function() {
  library(drat)
  repodir = "D:/libraries/drat/drat"
  libdir = "D:/libraries"
  
  insert.drat("BLPestimatoR", repodir,libdir)
  insert.drat("stringtools", repodir,libdir)
  insert.drat("restorepoint", repodir,libdir)


  insert.drat("rmdtools", repodir,libdir)
  insert.drat("shinyEvents", repodir,libdir)
  insert.drat("dplyrExtras", repodir,libdir)
  insert.drat("regtools", repodir,libdir)
  insert.drat("RTutor", repodir,libdir, add.source = FALSE)
  drat::insertPackage("D:/libraries/drat/RTutor_2015.12.16.tar.gz", repodir)
  
  
  options(repos = unique(c("https://skranz-repo.github.io/drat/",getOption("repos"))))
  
  install.packages("BLPestimatoR")
  
  install.packages("restorepoint")
  install.packages("restorepoint")
  
}

insert.drat = function(pkg,repodir=getwd(),libdir, pkg.dir=file.path(libdir, pkg, pkg), add.binary=TRUE, add.source=TRUE) {
  
  dir = file.path(libdir, pkg, pkg)
  if (add.source) {
    src = devtools::build(dir)
    drat::insertPackage(src, repodir)
  }
  if (add.binary) {
    bin = devtools::build(dir, binary = TRUE, args = c('--preclean'))
    drat::insertPackage(bin, repodir)
  }
}
