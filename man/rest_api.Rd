% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/app.R, R/github.R
\name{rest_api}
\alias{rest_api}
\alias{rest_api_raw}
\alias{github_api}
\title{Get data from a REST API}
\usage{
rest_api(...)

rest_api_raw(root, endpoint, token = "", params = list(), headers = NULL)

github_api(
  endpoint,
  token = "",
  params = list(),
  headers = NULL,
  raw = !loadable("jsonlite")
)
}
\arguments{
\item{...}{Arguments to be passed to \code{rest_api_raw()}.}

\item{root}{The API root URL.}

\item{endpoint}{The API endpoint.}

\item{token}{A named character string (e.g., \code{c(token = "xxxx")}), which
will be used to create an authorization header of the form
\samp{Authorization: NAME TOKEN} for the API call, where \samp{NAME} is the
name of the string and \samp{TOKEN} is the string. If the string does not
have a name, \samp{Basic} will be used as the default name.}

\item{params}{A list of query parameters to be sent with the API call.}

\item{headers}{A named character vector of HTTP headers, e.g., \code{c(Accept = "application/vnd.github.v3+json")}.}

\item{raw}{Whether to return the raw response or parse the response with
\pkg{jsonlite}.}
}
\value{
A character vector (the raw JSON response) or an R object parsed from
the JSON text.
}
\description{
Read data from a REST API and optionally with an authorization token in the
request header. The function \code{rest_api_raw()} returns the raw text of
the response, and \code{rest_api()} will parse the response with
\code{jsonlite::fromJSON()} (assuming that the response is in the JSON
format).
}
\details{
These functions are simple wrappers based on \code{\link[=url]{url()}} and
\code{\link[=read_utf8]{read_utf8()}}. Specifically, the \code{headers} argument is
passed to \code{url()}, and \code{read_utf8()} will send a \samp{GET} request
to the API server. This means these functions only support the \samp{GET}
method. If you need to use other HTTP methods (such as \samp{POST}), you have
to use other packages such as \pkg{curl} and \pkg{httr}.

\code{github_api()} is a wrapper function based on
\code{rest_api_raw()} to obtain data from the GitHub API:
\url{https://docs.github.com/en/rest}. You can provide a personal access
token (PAT) via the \code{token} argument, or via one of the environment
variables \var{GITHUB_PAT}, \var{GITHUB_TOKEN}, \var{GH_TOKEN}. A PAT
allows for a much higher rate limit in API calls. Without a token, you can
only make 60 calls in an hour.
}
\examples{\dontshow{if (interactive()) (if (getRversion() >= "3.4") withAutoprint else force)(\{ # examplesIf}
# a normal GET request
xfun::rest_api("https://httpbin.org", "/get")
xfun::rest_api_raw("https://httpbin.org", "/get")

# send the request with an auth header
xfun::rest_api("https://httpbin.org", "/headers", "OPEN SESAME!")

# with query parameters
xfun::rest_api("https://httpbin.org", "/response-headers", params = list(foo = "bar"))

# get the rate limit info from GitHub
xfun::github_api("/rate_limit")
\dontshow{\}) # examplesIf}
}
