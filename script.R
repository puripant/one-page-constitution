# install.packages(c("pdftools", "png"))

library(pdftools)
library(png)

pdf_convert("constitution2560.PDF")

# Dimensions of 1 page.
imgwidth <- 595
imgheight <- 842

# Grid dimensions.
gridwidth <- 10
gridheight <- 9

# Total plot width and height.
spacing <- 1
totalwidth <- (imgwidth+spacing) * (gridwidth)
totalheight <- (imgheight+spacing) * gridheight

# Plot all the pages and save as PNG.
png("all_pages.png", round(totalwidth), round(totalheight))
par(mar=c(0,0,0,0))
plot(0, 0, type='n', xlim=c(0, totalwidth), ylim=c(0, totalheight), asp=1, bty="n", axes=FALSE)
for (i in 1:90) {
  fname <- paste("constitution2560.PDF_", i, ".png", sep="")
  img <- readPNG(fname)
  
  x <- ((i-1) %% gridwidth) * (imgwidth+spacing)
  y <- totalheight - (floor((i-1) / gridwidth)) * (imgheight+spacing)
  
  rasterImage(img, xleft=x, ybottom = y-imgheight, xright = x+imgwidth, ytop=y)
}
dev.off()
