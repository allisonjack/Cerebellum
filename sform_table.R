
#usage:
#Rscript --vanilla sform.R ID

args <- commandArgs(trailingOnly = TRUE)

coords <- read.csv("desired_origin_coordinates_mm.csv")
ID <- as.character(args[1])

SFORM <- paste(ID, "_orig_sform.txt", sep = "")
sform.orig <- read.delim(SFORM, sep = " ", header = FALSE)

new.mm.x <- coords$new.mm.x[coords$ID == ID]
new.mm.y <- coords$new.mm.y[coords$ID == ID]
new.mm.z <- coords$new.mm.z[coords$ID == ID]

sform.new <- sform.orig

sform.new[1,4] <- as.numeric(sform.new[1,4]) - as.numeric(new.mm.x)
sform.new[2,4] <- as.numeric(sform.new[2,4]) - as.numeric(new.mm.y)
sform.new[3,4] <- as.numeric(sform.new[3,4]) - as.numeric(new.mm.z)

sform.print <- as.data.frame(c(t(sform.new)))

OUT <- paste(ID, "_sform_new.txt", sep = "")
write.table(t(sform.print), OUT, quote = FALSE, row.names = FALSE, col.names = FALSE)
