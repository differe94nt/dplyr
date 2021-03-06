% Generated by roxygen2 (4.0.0): do not edit by hand
\name{manip_grouped_dt}
\alias{arrange.grouped_dt}
\alias{filter.grouped_dt}
\alias{manip_grouped_dt}
\alias{mutate.grouped_dt}
\alias{select.grouped_dt}
\alias{summarise.grouped_dt}
\title{Data manipulation for grouped data tables.}
\usage{
\method{filter}{grouped_dt}(.data, ...)

\method{summarise}{grouped_dt}(.data, ...)

\method{mutate}{grouped_dt}(.data, ..., inplace = FALSE)

\method{arrange}{grouped_dt}(.data, ...)

\method{select}{grouped_dt}(.data, ...)
}
\arguments{
  \item{.data}{a data table}

  \item{...}{variables interpreted in the context of
  \code{.data}}

  \item{inplace}{if \code{FALSE} (the default) the data
  frame will be copied prior to modification to avoid
  changes propagating via reference.}
}
\description{
Data manipulation for grouped data tables.
}
\examples{
if (require("data.table") && require("hflights")) {
hflights2 <- tbl_dt(hflights)
by_dest <- group_by(hflights2, Dest)
filter(by_dest, ArrDelay == max(ArrDelay, na.rm = TRUE))
summarise(by_dest, arr = mean(ArrDelay, na.rm = TRUE))

# Normalise arrival and departure delays by airport
scaled <- mutate(by_dest, arr_z = scale(ArrDelay), dep_z = scale(DepDelay))
select(scaled, Year:DayOfWeek, Dest, arr_z:dep_z)

arrange(by_dest, desc(ArrDelay))
select(by_dest, -(DayOfWeek:TailNum))

# All manip functions preserve grouping structure, except for summarise
# which removes a grouping level
by_day <- group_by(hflights, Year, Month, DayofMonth)
by_month <- summarise(by_day, delayed = sum(ArrDelay > 0, na.rm = TRUE))
by_month
summarise(by_month, delayed = sum(delayed))

# You can also manually ungroup:
ungroup(by_day)
}
}

