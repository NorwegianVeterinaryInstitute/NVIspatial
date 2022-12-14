% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/is_it_in_Norway.R
\name{is_it_in_Norway}
\alias{is_it_in_Norway}
\title{Checks if the geo-location is within Norway}
\usage{
is_it_in_Norway(
  data,
  coordinates,
  input_projection = 4326,
  polygon = NVIspatial::Norway_with_buffer_500,
  polygon_projection = paste("PROJCS[\\"ETRS89 / UTM zone 33N\\",GEOGCS[\\"ETRS89\\",",
    "DATUM[\\"European_Terrestrial_Reference_System_1989\\",",
    "SPHEROID[\\"GRS 1980\\",6378137,298.257222101,",
    "AUTHORITY[\\"EPSG\\",\\"7019\\"]],", "TOWGS84[0,0,0,0,0,0,0],",
    "AUTHORITY[\\"EPSG\\",\\"6258\\"]],", "PRIMEM[\\"Greenwich\\",0,",
    "AUTHORITY[\\"EPSG\\",\\"8901\\"]],", "UNIT[\\"degree\\",0.0174532925199433,",
    "AUTHORITY[\\"EPSG\\",\\"9122\\"]],", "AUTHORITY[\\"EPSG\\",\\"4258\\"]],",
    "PROJECTION[\\"Transverse_Mercator\\"],", "PARAMETER[\\"latitude_of_origin\\",0],", 

        "PARAMETER[\\"central_meridian\\",15],", "PARAMETER[\\"scale_factor\\",0.9996],",
    "PARAMETER[\\"false_easting\\",500000],", "PARAMETER[\\"false_northing\\",0],",
    "UNIT[\\"metre\\",1,", "AUTHORITY[\\"EPSG\\",\\"9001\\"]],",
    "AXIS[\\"Easting\\",EAST],", "AXIS[\\"Northing\\",NORTH],",
    "AUTHORITY[\\"EPSG\\",\\"25833\\"]]"),
  valid = FALSE,
  set_to_NA = TRUE
)
}
\arguments{
\item{data}{[\code{data.frame}]\cr
Input data with location information that should be checked.}

\item{coordinates}{[\code{character}]\cr
Vector with the column names or the position numbers of the columns with the
geo coordinates in data. The order of the geo coordinates should be given
as c("longitude", "latitude").}

\item{input_projection}{the projection of the geo locations that should be checked.}

\item{polygon}{[\code{sf}]\cr
The polygon that you want to check if the geo locations are
within. The polygon must be given as a special feature object. Defaults to
\code{Norway_with_buffer_500}.}

\item{polygon_projection}{Projection of the data defining the polygon. Defaults
to the projection of \code{Norway_with_buffer_500}.}

\item{valid}{[\code{logical} or \code{character}]\cr
Should the results include a variable with information on whether the
geo location were within the polygon? Defaults to \code{FALSE}. The name of the
new column defaults to "valid_coordinate". If another name is wanted, you
can use the preferred column name as input argument.}

\item{set_to_NA}{[\code{logical}]\cr
Should the invalid geo coordinates be set to \code{NA}? Defaults to \code{TRUE}.}
}
\value{
A data frame. If \code{set_to_NA = TRUE} the geo coordinates that is
outside Norway is set to \code{NA}. If \code{valid = TRUE}, a column named
"valid_coordinate" (or the name you choose), is added and the observations
are given the value 1 if the coordinate is within Norway and 0 if not.
}
\description{
Checks if the geo location of a pair of geo coordinates, is within Norway.
}
\details{
AS default, the check is performed towards a polygon with the shape
of the Norwegian land area with buffer of 500 m. The polygon is based on
the Norwegian country borders and coastline in N500. This should be sufficient
accurate for checking farms, but will not be sufficient for checking all
kinds of buildings, in particular buildings that can be expected to be
situated on small islands.

The check is intended for geo-locations on land, not in the sea. However,
by changing the input to polygon, the check can be performed towards other
areas. The input needs to be a special features object.

To return a data frame with the invalid geo coordinates
set to NA, use \code{valid = FALSE} and \code{set_to_NA = TRUE}. If you
would like to inspect the invalid geo coordinates, use \code{valid = TRUE}
and \code{set_to_NA = FALSE}.
}
\examples{
\dontrun{
library(NVIspatial)
library(dplyr)
library(sf)

geolocations <- data.frame(
  "eier_lokalitetnr" = c("1", "2", "3"),
  "geo_eu89_o" = c("5.3105549", "0.3105549", NA),
  "geo_eu89_n" = c("60.3551767", "60.3551767", NA))

geolocations <- is_it_in_Norway(data = geolocations,
                                coordinates = c("geo_eu89_o", "geo_eu89_n"),
                                polygon = Norway_with_buffer_500,
                                valid = TRUE,
                                set_to_NA = FALSE)

geolocations <- is_it_in_Norway(data = geolocations,
                                coordinates = c("geo_eu89_o", "geo_eu89_n"),
                                polygon = Norway_with_buffer_500,
                                valid = "valid_coordinate_500",
                                set_to_NA = FALSE)
}

}
\author{
Petter Hopp Petter.Hopp@vetinst.no
}
