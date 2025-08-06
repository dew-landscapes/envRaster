
<!-- README.md is generated from README.Rmd. Please edit that file -->

# `envRaster`: Create and interact with environmental rasters

<!-- badges: start -->

<!-- badges: end -->

The goal of `envRaster` is to simplify the making of environmental
rasters for use in other workflows. This includes making:

- a simple base raster to use as extent, resolution and crs when making
  environmental rasters
- regular cubes of earth observation data and climate data
  - capture meta data in paths
  - extract meta data from paths
- landform classification from digital terrain models (old code not
  updated recently)
- tibbles of environmental data extracted to points

There are better packages for doing most of this, particularly
[sits](https://cran.r-project.org/web/packages/sits/index.html), but
also [stars](https://cran.r-project.org/web/packages/stars/index.html),
[terra](https://cran.r-project.org/web/packages/terra/index.html) and
[gdalcubes](https://cran.r-project.org/web/packages/gdalcubes/index.html).

Key packages used in `envRaster` are terra (Hijmans 2024), rstac
(Simoes, Carvalho, and Brazil Data Cube Team 2024; Simoes et al. 2021)
and gdalcubes (Appel 2024; Appel and Pebesma 2019; Appel, Pebesma, and
Mohr 2021).

Default settings in `envRaster` tend to favour South Australian settings
(e.g. the output epsg for `make_base_grid()`).

## Installation

`envFunc` is not on [CRAN](https://CRAN.R-project.org).

You can install the development version from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("Acanthiza/envRaster")
```

Load `envRaster`

``` r
library("envRaster")
```

# References

<div id="refs" class="references csl-bib-body hanging-indent"
entry-spacing="0">

<div id="ref-R-gdalcubes" class="csl-entry">

Appel, Marius. 2024. *Gdalcubes: Earth Observation Data Cubes from
Satellite Image Collections*. <https://github.com/appelmar/gdalcubes>.

</div>

<div id="ref-gdalcubes2019" class="csl-entry">

Appel, Marius, and Edzer Pebesma. 2019. “On-Demand Processing of Data
Cubes from Satellite Image Collections with the Gdalcubes Library.”
*Data* 4 (3). <https://www.mdpi.com/2306-5729/4/3/92>.

</div>

<div id="ref-gdalcubes2021" class="csl-entry">

Appel, Marius, Edzer Pebesma, and Matthias Mohr. 2021. “Cloud-Based
Processing of Satellite Image Collections in r Using STAC, COGs, and
on-Demand Data Cubes.”
<https://r-spatial.org/r/2021/04/23/cloud-based-cubes.html>.

</div>

<div id="ref-R-terra" class="csl-entry">

Hijmans, Robert J. 2024. *Terra: Spatial Data Analysis*.
<https://rspatial.org/>.

</div>

<div id="ref-R-rstac" class="csl-entry">

Simoes, Rolf, Felipe Carvalho, and Brazil Data Cube Team. 2024. *Rstac:
Client Library for SpatioTemporal Asset Catalog*.
<https://brazil-data-cube.github.io/rstac/>.

</div>

<div id="ref-rstac2021" class="csl-entry">

Simoes, Rolf, Felipe Souza, Matheus Zaglia, Gilberto Ribeiro Queiroz,
Rafael Santos, and Karine Ferreira. 2021. “Rstac: An r Package to Access
Spatiotemporal Asset Catalog Satellite Imagery.” In *2021 IEEE
International Geoscience and Remote Sensing Symposium IGARSS*, 7674–77.
<https://doi.org/10.1109/IGARSS47720.2021.9553518>.

</div>

</div>
