if (!exists("workbookPager")) {
    workbookPager <- function(files, header, title, delete.file) {
        lines <- title
        for (path in files) {
            lines <- c(lines, header, readLines(path))
        }
        if (delete.file) file.remove(files)
        # lines <- gsub("^", "# ", lines)
        text <- paste(lines, collapse = "\n")
        text <- gsub("_\010", "", text)
        cat(text)
    }
}


invisible({options(width = 10000, pager = workbookPager)})


if (!exists("workbookComplete")) {
    workbookComplete <- function (base) {
        cs <- apropos(paste0("^", base))
        ls <- paste(cs, collapse = "\t")
        cat(ls)
        cat("\n")
    }
}


if (!exists("workbookHelp")) {
    workbookHelp <- function(name.string, ...) {
        help((name.string), try.all.packages = TRUE, ...)
    }
}


if (!exists("workbookKeyword")) {
    workbookKeyword <- function(name, name.string, ...) {
        if (name.string == '') {
            workbookHelp(name, ...)
        } else if (mode(name) == 'function') {
            workbookHelp(name.string, ...)
        } else {
            str(name)
        }
    }
}


if (!exists("workbookServer")) {
    workbookJsonDecorate <- function (fn) {
        argnames <- names(formals(fn))
        function (req, res, err) {
            pnames <- names(req$params)
            args <- req$params[pnames[pnames %in% argnames]]
            rv <- do.call(fn, args)
            res$json(rv)
        }
    }
    workbookServer <- function (id) {
        library("jug")
        jug() %>%
        get(path = "/complete//(?<base>.*)", workbookJsonDecorate(workbookComplete)) %>%
        get(path = "/eval", workbookJsonDecorate(workbookComplete)) %>%
        serve_it()
    }
}


if (!exists("workbookRserveEval")) {
    workbook.rserve.connection <- NULL
    workbookRserveEval <- function (code) {
        if (is.na(match("Rserve", .packages(all.available = TRUE, lib.loc = .libPaths())))) {
            stop("Please install Rserve first!")
        }
        if (is.na(match("RSclient", .packages(all.available = TRUE, lib.loc = .libPaths())))) {
            stop("Please install RSclient first!")
        }
        library("RSclient")
        if (is.null(workbook.rserve.connection)) {
            workbook.rserve.connection <<- tryCatch(RS.connect(), error = function (e) {
                stop("Make sure an instance of RServe is running!", e)
            })
        }
        eval(substitute(RS.eval(workbook.rserve.connection, eval({code}, envir = .GlobalEnv)),
            list(code = parse(text = code))))
    }
    on.exit({
        if (!is.null(workbook.rserve.connection)) {
            on.exit(RS.server.shutdown(workbook.rserve.connection))
            on.exit(RS.close(workbook.rserve.connection))
        }
    }, add = TRUE)
}


# cat("workbook_vim.R loaded!\n")

