## ----include=FALSE-------------------------------------------------------
knitr::opts_chunk$set(warning = FALSE,
                      message = TRUE)

library(grid)
library(ggplot2)
library(ggimage)
library(meme)
library(cowplot)

## ------------------------------------------------------------------------
if (.Platform$OS.type == "windows") {
    windowsFonts(
        Impact = windowsFont("Impact"),
        Courier = windowsFont("Courier"),
        STHeiti = windowsFont("STHeiti"))
}

## ----fig.width=7, fig.height=3.9375--------------------------------------
library(meme)
u <- system.file("angry8.jpg", package="meme")
meme(u, "code", "all the things!")

## ----fig.width=7, fig.height=3.9375--------------------------------------
mmplot(u) + mm_caption("calm down", "and RTFM",
                       color="purple")

## ----message=TRUE--------------------------------------------------------
u2 <- system.file("success.jpg", package="meme")
x <- meme(u2, "please", "tell me more")

## ----eval=FALSE----------------------------------------------------------
#  outfile <- tempfile(fileext=".png")
#  meme_save(x, file=outfile)

## ----fig.width=7, fig.height = 3.94--------------------------------------
plot(x, size = 2, "happy friday!", "wait, sorry, it's monday", color = "firebrick", font = "Courier")

## ----fig.width=7, fig.height = 3.94--------------------------------------
x + aes(upper = "#barbarplots",
        lower = "friends don't let friends make bar plots",
        color = firebrick, font = Courier, size=1.5)

## ----fig.width=7, fig.height = 3.94, eval=FALSE--------------------------
#  x + list(upper = "#barbarplots",
#          lower = "friends don't let friends make bar plots",
#          color = "firebrick", font = "Courier", size=1.5)

## ----fig.width=7, fig.height=3.9375--------------------------------------
y <- meme(u, "卧槽", "听说你想用中文", font="STHeiti")
y

## ----fig.width=7---------------------------------------------------------
library(grid)
mm <- meme(u, "code", "all the things!", size=.3, color='firebrick', bgcolor=NULL)

grid.newpage()
pushViewport(viewport(width=.9, height=.9))
grid.rect(gp = gpar(lty="dashed"))

xx <- seq(0, 2*pi , length.out=10)
yy <- sin(xx)

for (i in seq_along(xx)) {
    vp <- viewport(x = xx[i]/(2*pi), y = (yy[i]-min(yy))/2, width=.05, height=.05)
    print(mm, vp = vp)
}

## ----fig.width=7, fig.height=4.06----------------------------------------
library(ggplot2)
library(ggimage)

d <- data.frame(x = xx, y = yy)
ggplot(d, aes(x, y)) + geom_line() +
    geom_subview(mm, x = xx, y = yy, width=.3, height=.15)

ggplot(d, aes(x, y)) +
    geom_subview(mm+aes(size=3), x=0, y=0, width=Inf, height=Inf) +
    geom_point() + geom_line()

## ----fig.width=7, fig.height=7.88----------------------------------------
cowplot::plot_grid(x, y, ncol=1, labels = c("A", "B"))
