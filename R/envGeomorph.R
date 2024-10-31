
#' Landform Classification after Jasiewicz and Stepinkski (2013)
#'
#' from https://github.com/m-saenger/geomorphon/blob/master/geomorphon.R
#'
#'  M. Sänger  10/2019
#'
#' Raster data to be on equally spaced grid (e.g. km)
#' Output very sensitive to flatness threshold
#' Function not optmised for performance - run time very long for large data sets
#'
#' @param ras input DTM (RasterLayer class).
#' @param outfile Name of output file. This string will have '_geomorph'
#' appended. Passed to writeRaster.
#' @param windowSize size (in terms of cells per side) of the neighborhood
#' (moving window) to be used; it must be an odd integer.
#' @param flatnessThresh If slope < flatnessThresh then flat.
#' @param doNew Logical. If outfile already exists, redo anyway.
#'
#' @return raster.
#' @export
#'
#' @examples
  geomorph_ras <- function(ras, outfile = NULL, windowSize = 11, flatnessThresh = 1, doNew = TRUE) {

    #-------Definitions---------
    geomorph.def <- data.frame(
      num_lf = 1:10,
      id_lf = c("PK", "RI", "SH", "SP", "SL", "FS", "FL", "HL", "VL", "PT"),
      name_en = c("Peak", "Ridge", "Shoulder", "Spur", "Slope", "Footslope", "Flat", "Hollow", "Valley", "Pit"),
      colour = c("magenta", "red", "orange", "yellow", "grey40",  "grey70", "grey90", "skyblue1", "dodgerblue", "royalblue3"),
      stringsAsFactors = F
    )

    geomorph.lut <- data.frame(
      V0 = c("FL", "FL", "FL", "SH", "SH", "RI", "RI", "RI", "PK"),
      V1 = c("FL", "FL", "SH", "SH", "SH", "RI", "RI", "RI", NA),
      V2 = c("FL", "FS", "SL", "SL", "SP", "SP", "RI", NA, NA),
      V3 = c("FS", "FS", "SL", "SL", "SL", "SP", NA, NA, NA),
      V4 = c("FS", "FS", "HL", "SL", "SL", NA, NA, NA, NA),
      V5 = c("VL", "VL", "HL", "HL", NA, NA, NA, NA, NA),
      V6 = c("VL", "VL", "VL", NA, NA, NA, NA, NA, NA),
      V7 = c("VL", "VL", NA, NA, NA, NA, NA, NA, NA),
      V8 = c("PT", NA, NA, NA, NA, NA, NA, NA, NA)
    )

    geomorph.lut <- as.matrix(geomorph.lut)
    geomorph.lut.num <- matrix(match(geomorph.lut, geomorph.def$id_lf), nrow = nrow(geomorph.lut))

    #---------Moving window function---------
    geomorph <- function(x, flatness.thresh = flatnessThresh, res = NA, geomorph.lut.num, verbose = F){

      # Breaks for flatness threshold
      brks <- c(-Inf, -flatness.thresh, flatness.thresh, Inf)
      brks.ind <- c(-1, 0, 1)

      # Create matrix from incoming vector x
      size = sqrt(length(x))
      m <- matrix(x, nrow = size)

      # Distance from central point to edge (number of cells)
      mid <- ceiling(size/2)

      # Matrix of all vectors from the central point to the octants
      oct <- rbind(
        ne = cbind(mid:size, mid:size),
        e = cbind(mid:size, mid),
        se = cbind(mid:size, mid:1),
        s = cbind(mid, mid:1),
        sw = cbind(mid:1, mid:1),
        w = cbind(mid:1, mid),
        nw = cbind(mid:1, mid:size),
        n = cbind(mid, mid:size)
      )

      # Coordinates and cell distance (sqrt(2) for diagonals)
      oct.vector <- m[oct]
      cell.scaling <- rep(c(sqrt(2), 1), 4) # Horizontal cell distance in all 8 directions
      cell.size <- res * cell.scaling

      # Matrix octants vs. cell values
      m1 <- matrix(oct.vector, nrow = 8, byrow = T)

      # z diff from central point
      m.diff <-  m1[, -1] - m1[, 1]

      # Calculate slope angle and transform to degrees
      m.slope <- atan(m.diff/(cell.size * 1:ncol(m.diff)))
      m.angle <- m.slope * 180/pi

      # Calculate zenith and nadir angles for each octant
      nadir <- 90 + apply(m.angle, 1, min, na.rm = T)
      zenith <- 90 - apply(m.angle, 1, max, na.rm = T)

      # Derive ternary pattern
      ternary.pattern <- brks.ind[findInterval(nadir - zenith, brks)]

      plus.ind <- length(which(ternary.pattern == 1))
      neg.ind <- length(which(ternary.pattern == -1))

      # Look up ternarity pattern and assign landform class
      geomorph.lut.num[neg.ind + 1, plus.ind + 1]

    }

    #---------Apply to raster---------
    focalWindow <- matrix(1, nrow = windowSize, ncol = windowSize)

    saveFile <- if(!is.null(outfile)) {

      dir.create(dirname(outfile), showWarnings = FALSE)

      gsub("\\.","_geomorph.",outfile)

    } else paste0(tempfile(),"_geomorph.tif")

    if(!doNew) {

      if(!file.exists(saveFile)) doNew <- TRUE

    }

    if(doNew) {

      ras <- terra::focal(ras
                           , w = focalWindow
                           , fun = function(x) geomorph(x
                                                        , flatness.thresh = flatnessThresh
                                                        , res = terra::res(ras)
                                                        , geomorph.lut.num
                                                        )
                           , pad = T
                           , padValue = NA
                           )

      coltab(ras) <- geomorph.def$colour
      levels(ras) <- geomorph.def$name_en

      terra::writeRaster(ras
                         , saveFile
                         )

    }

    terra::rast(saveFile)

  }



#' R function for landform classification on the basis on Topographic Position Index
#'
#' from https://rdrr.io/github/gianmarcoalberti/GmAMisc/src/R/landfClass.R. Function seemed to disappear from GmAMisc package between 1.1.0 and 1.1.1
#'
#' The function allows to perform landform classification on the basis of the Topographic Position Index calculated from an input Digital Terrain Model (RasterLayer class).
#'
#' The TPI is the difference between the elevation of a given cell and the average elevation of the surrounding cells in a user defined moving window.
#' For landform classification, the TPI is first standardized and then thresholded; to isolate certain classes, a slope raster (which is internally worked out) is also needed.\cr
#' For details about the implemented classification, see: http://www.jennessent.com/downloads/tpi_documentation_online.pdf.\cr
#'
#' Two methods are available:\cr
#' - the first (devised by Weiss) produces a 6-class landform classification comprising
#' -- valley\cr
#' -- lower slope\cr
#' -- flat slope\cr
#' -- middle slope\cr
#' -- upper clope\cr
#' -- ridge\cr
#' -the second (devised by Jennes) produces a 10-class classification comprising
#' -- canyons, deeply incised streams\cr
#' -- midslope drainages, shallow valleys\cr
#' -- upland drainages, headwaters\cr
#' -- u-shaped valleys\cr
#' -- plains\cr
#' -- open slopes\cr
#' -- upper slopes, mesas\cr
#' -- local ridges, hills in valleys\cr
#' -- midslope ridges, small hills\cr
#' -- mountain tops, high ridges\cr
#' The second classification is based on two TPI that make use of two neighborhoods (moving windows) of different size: a s(mall) n(eighborhood) and a l(arge) n(eighborhood),
#' defined by the parameters sn and ln.\cr
#'
#'
#' @param ras input DTM (RasterLayer class).
#' @param outfile character. Optional path filename passed to writeRaster.
#' @param doNew logical. If FALSE, will only process x if outfile does not exist.
#' @param sn size (in terms of cells per side) of the neighborhood (moving
#' window) to be used; it must be an odd integer. s(mall) n(eighbourhood).
#' @param ln if the 10-class classification is selected, this paramenter sets
#' the l(arge) n(eighborhood) to be used.
#' @param n.classes "six" or "ten" for a six- or ten-class landform
#' classification.
#' @param win character. Shape of the moving window used by spatialEco::tpi.
#' @keywords landform
#' @export
#' @examples
  land_class <- function(ras, outfile = NULL, doNew = TRUE, sn = 3
                         , ln = 7, n.classes="six", win = "rectangle"
                         ) {

    #calculate the slope from the input DTM, to be used for either the six or ten class slope position
    slp <- terra::terrain(ras, v = "slope", unit = "degrees", neighbors = sn * sn - 1)

    #calculate the tpi using spatialEco::tpi function
    tp <- spatialEco::tpi(ras, scale = sn, win = win)

    saveFile <- if(!is.null(outfile)) {

      dir.create(dirname(outfile), showWarnings = FALSE)

      outfile

      } else paste0(tempfile(),".tif")

    if(n.classes == "six") saveFile <- gsub("\\.tif","_six.tif",saveFile)
    if(n.classes == "ten") saveFile <- gsub("\\.tif","_ten.tif",saveFile)


    if(!doNew) {

      if(!file.exists(saveFile)) doNew <- TRUE

    }

    if(doNew) {

      if(n.classes == "six") {

        topo_six_class <- function(tp, slp) {

          ifelse(tp <= -1
                 , 1
                 , ifelse(tp > -1 & tp <= -0.5
                          , 2
                          , ifelse(tp > -0.5 & tp < 0.5 & slp <= 5
                                   , 3
                                   , ifelse(tp > -0.5 & tp < 0.5 & slp > 5
                                            , 4
                                            , ifelse(tp > 0.5 & tp <= 1
                                                     , 5
                                                     , ifelse(tp > 1
                                                              , 6
                                                              , NA
                                                     )
                                            )
                                   )
                          )
                 )
          )

        }

        s <- c(tp,slp)

        res <- terra::lapp(s, fun = topo_six_class)

        lscCol <- data.frame(id = 1:6
                             , category = c("valley","lower slope","flat slope","middle slope","upper slope","ridge")
                             , colour = grDevices::terrain.colors(6)
                             )

      } else if(n.classes == "ten") {

        topo_ten_class <- function(sn,ln,slp) {

          ifelse(sn <= -1 & ln <= -1
                 , 1
                 , ifelse(sn <= -1 & ln > -1 & ln < 1
                          , 2
                          , ifelse(sn <= -1 & ln >= 1
                                   , 3
                                   , ifelse(sn > -1 & sn < 1 & ln <=-1
                                            , 4
                                            , ifelse(sn > -1 & sn < 1 & ln > -1 & ln < 1 & slp <= 5
                                                     , 5
                                                     , ifelse(sn > -1 & sn < 1 & ln > -1 & ln < 1 & slp > 5
                                                              , 6
                                                              , ifelse(sn > -1 & sn < 1 & ln >= 1
                                                                       , 7
                                                                       , ifelse(sn >= 1 & ln <= -1
                                                                                , 8
                                                                                , ifelse(sn >= 1 & ln > -1 & ln < 1
                                                                                         , 9
                                                                                         , ifelse(sn >= 1 & ln >=1
                                                                                                  , 10
                                                                                                  , NA
                                                                                         )
                                                                                )
                                                                       )
                                                              )
                                                     )
                                            )
                                   )
                          )
                 )
          )

        }

        #calculate two standardized tpi, one with small neighbour, one with large neighbour
        sn <- spatialEco::tpi(ras, scale = sn, win = win, normalize = TRUE)
        ln <- spatialEco::tpi(ras, scale = ln, win = win, normalize = TRUE)

        s <- c(sn,ln,slp)

        res <- terra::lapp(s, fun = topo_ten_class)

        lscCol <- data.frame(id = 1:10
                             , category = c("canyon","midslope drainage","upland drainage","u-shaped valley","plains"
                                            , "open slopes", "upper slopes", "local ridges", "midslopes ridges", "mountain tops"
                                            )
                             , colour = grDevices::terrain.colors(10)
                             )


      }


      levels(res) <- lscCol

      terra::writeRaster(res
                         , saveFile
                         )

    }

    terra::rast(saveFile)

  }
