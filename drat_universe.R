universe.json.from.drat = function() {
  drat.url = "https://raw.githubusercontent.com/skranz-repo/drat/master/src/contrib/PACKAGES"
  drat.txt = readLines(drat.url)
  
  univ.txt = readLines("https://raw.githubusercontent.com/skranz/universe/main/packages.json")
  
  drat = read.repo.packages(drat.txt)
  
  ignore = c("RTutorIncentiveContracts","RTutorECars", "lfe", "BLPestimatoR","bbsvg","symbeqs","ddsim")
  drat = filter(drat, !Package %in% ignore)
  
  
  drat.json = drat %>%
    transmute(package=Package, url = paste0("https://github.com/skranz/", Package), branch="master") %>%
    jsonlite::toJSON()
  
  
  
  drat.json = gsub("{","{\n\t",drat.json,fixed=TRUE)
  drat.json = gsub("}","\n}",drat.json,fixed=TRUE)
  drat.json = gsub(",",",\n\t",drat.json,fixed=TRUE)
  drat.json = gsub("\t{","{",drat.json,fixed=TRUE)
  drat.json = gsub(':"',': "',drat.json,fixed=TRUE)
  
  
  
  writeLines(drat.json,"C:/libraries/drat/drat_packages.json")
  
  univ = jsonlite::fromJSON(univ.txt)
  
  
}

read.repo.packages = function(txt) {
  library(stringtools)
  library(dplyr)
  txt = merge.lines(txt)
  blocks = strsplit(txt, "\n\n", fixed=TRUE)[[1]]
  
  pkg.li = lapply(blocks, function(b) {
    restorepoint::restore.point("jdifjldjf")
    pkg = yaml::read_yaml(text=b)
    pkg$dep = list()
    if (!is.null(pkg$Depends)) {
      pkg$dep = list(trimws(strsplit(pkg$Depends,",",fixed=TRUE)))
    }
    if (!is.null(pkg$Imports)) {
      pkg$dep = c(pkg$dep,list(trimws(strsplit(pkg$Imp,",",fixed=TRUE))))
    }
    pkg
  })
  
  pkgs = data.table::rbindlist(pkg.li, fill=TRUE) %>% as_tibble()
  
  pkgs = pkgs %>%
    group_by(Package) %>%
    mutate(newest = 1:n() == n()) %>%
    filter(newest) %>%
    ungroup()

  pkgs
} 