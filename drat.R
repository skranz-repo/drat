#install.packages("drat")
  library(drat)
  library(restorepoint)
  repodir = "D:/libraries/drat/drat"; download.dir = "D:/libraries/drat"
  libdir = "D:/libraries"
 
example.drat = function() {
  
  library(devtools)
assignInNamespace("version_info", c(devtools:::version_info, list("3.5" = list(version_min = "3.3.0", version_max = "99.99.99", path = "bin"))), "devtools")
  find_rtools()
  
  #github.to.drat("felsti/RTutorECars",download.dir, repodir, skip.download = FALSE)
  
  insert.drat("stringtools", repodir,libdir)
  insert.drat("codeUtils", repodir, libdir)
  insert.drat("dbmisc", repodir, libdir)

  #install.packages("RelationalContractsCpp",repos = c("https://skranz-repo.github.io/drat/",getOption("repos")))
  insert.drat("RelationalContracts", repodir,libdir, R.versions = "3.6",add.source = FALSE)

  insert.drat("RelationalContracts", repodir,libdir)
  insert.drat("RelationalContractsCpp", repodir,libdir, pkg.dir="D:/libraries/RelationalContracts/RelationalContractsCpp",R.versions = "3.6")

  
  insert.drat("gtree", repodir,libdir)
  insert.drat("gtreeWebPlay", repodir,libdir, pkg.dir="D:/libraries/gtree/gtreeWebPlay")

  insert.drat("rmdtools", repodir,libdir)
  insert.drat("shinyEvents", repodir,libdir)
  insert.drat("dplyrExtras", repodir,libdir)
  insert.drat("regtools", repodir,libdir)
  insert.drat("RTutorSAGI", repodir,libdir, pkg.dir="D:/libraries/RTutor/RTutorSAGI")
  insert.drat("RTutor", repodir,libdir, add.source = FALSE)
  drat::insertPackage("D:/libraries/drat/RTutor_2019.11.22.tar.gz", repodir)
  #
  #insert.drat("RTutorIncentiveContracts", repodir, pkg.dir="D:/libraries/RTutor/examples/IncentiveContracts/RTutorIncentiveContracts", add.binary=FALSE)
  #drat::insertPackage("D:/libraries/drat/RTutorIncentiveContracts_0.1.tar.gz", repodir)
  
  
  
  insert.drat("repgame", repodir, libdir)
  insert.drat("rowmins", repodir, libdir)
  
  insert.drat("shinyEventsUI", repodir, libdir)
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
  
  install.packages("rowmins")
  install.packages("skUtils")
  
  install.packages("restorepoint")
  install.packages("restorepoint")
  
  install.packages("repgame", repos = c("https://skranz-repo.github.io/drat/",getOption("repos")))
  
  install.packages("dyngame")

  install.packages("RTutor")  
}

insert.drat = function(pkg,repodir=getwd(),libdir, pkg.dir=file.path(libdir, pkg, pkg), add.binary=TRUE, add.source=TRUE, R.versions=c("3.5","3.6")) {
  library(drat)
  restore.point("insert.drat")
  if (add.source) {
    src = devtools::build(pkg.dir)
    drat::insertPackage(src, repodir)
  }
  if (add.binary) {
    #bin = devtools::build(pkg.dir, binary = TRUE, args = c('--preclean'))
    #drat::insertPackage(bin, repodir)
    writeLines(pkg.dir, "D:/libraries/drat/pkgdir.txt")
    if ("3.5" %in% R.versions) {
      cat("\nR 3.5.3")
      system("D:/Programs/R/bin/Rscript D:/libraries/drat/build_script.R")
    }
    if ("3.6" %in% R.versions) {
      cat("\nR 3.6.1")
      system("D:/Programs/R-3.6.1/bin/Rscript D:/libraries/drat/build_script.R")
    }
    
  }
}

github.to.drat = function(rep,download.dir = getwd(),repodir=getwd(),libdir, pkg.dir=file.path(libdir, pkg, pkg), add.binary=FALSE, add.source=TRUE, skip.download=FALSE) {
  library(stringtools)
  pkg = str.right.of(rep, "/")

  pkg.dir = download.github.package(rep, download.dir, skip.download=skip.download)
  insert.drat(pkg,repodir=repodir, pkg.dir=pkg.dir, add.binary = add.binary, add.source=add.source)
  
}

download.github.package = function(rep,   download.dir = getwd(), skip.download=FALSE) {

  library(stringtools)
  pkg = str.right.of(rep, "/")
  if (!skip.download) {
    zip.url = paste0("https://github.com/", rep, "/archive/master.zip")
    zip.file = file.path(download.dir,paste0(pkg,".zip"))
    download.file(zip.url,destfile = zip.file)
    unzip(zip.file, exdir=download.dir)
  } else {
    cat("\nskip github download of ", rep)
  }
  pkg.dir = paste0(download.dir, "/", pkg,"-Master")
  return(pkg.dir)
}
