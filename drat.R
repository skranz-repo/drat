#install.packages("drat")

example.drat = function() {
  library(drat)
  repodir = "D:/libraries/drat/drat"
  libdir = "D:/libraries"
  
  library(devtools)
assignInNamespace("version_info", c(devtools:::version_info, list("3.5" = list(version_min = "3.3.0", version_max = "99.99.99", path = "bin"))), "devtools")
  find_rtools()
  
  insert.drat("BLPestimatoR", repodir,libdir)
  insert.drat("stringtools", repodir,libdir)
  insert.drat("restorepoint", repodir,libdir)


  insert.drat("rmdtools", repodir,libdir)
  insert.drat("shinyEvents", repodir,libdir)
  insert.drat("dplyrExtras", repodir,libdir)
  insert.drat("regtools", repodir,libdir)
  insert.drat("RTutor", repodir,libdir, add.source = FALSE)
  drat::insertPackage("D:/libraries/drat/RTutor_2015.12.16.tar.gz", repodir)
  
  
  insert.drat("repgame", repodir, libdir)
  insert.drat("rowmins", repodir, libdir)
  
  insert.drat("shinyEventsUI", repodir, libdir)
  insert.drat("codeUtils", repodir, libdir)
  insert.drat("dbmisc", repodir, libdir)
  insert.drat("ddsim", repodir, libdir)
  insert.drat("symbeqs", repodir, libdir)
  insert.drat("bbsvg", repodir, libdir)
  
  insert.drat("rgmpl", repodir, libdir)
  insert.drat("rampl", repodir, libdir)
  insert.drat("sktools", repodir, libdir)
  
  insert.drat("skUtils", repodir, libdir)
  insert.drat("dyngame", repodir, libdir)
  insert.drat("RSGSolve", repodir, libdir)
  
  insert.drat("RMaxima", repodir, libdir)
  #insert.drat("LyxMaxima", repodir, libdir)
  
  
  options(repos = unique(c("https://skranz-repo.github.io/drat/",getOption("repos"))))
  
  install.packages("BLPestimatoR")
  install.packages("rowmins")
  
  install.packages("restorepoint")
  install.packages("restorepoint")
  
}

insert.drat = function(pkg,repodir=getwd(),libdir, pkg.dir=file.path(libdir, pkg, pkg), add.binary=TRUE, add.source=!TRUE) {
  library(drat)
  if (add.source) {
    src = devtools::build(pkg.dir)
    drat::insertPackage(src, repodir)
  }
  if (add.binary) {
    bin = devtools::build(pkg.dir, binary = TRUE, args = c('--preclean'))
    drat::insertPackage(bin, repodir)
  }
}
