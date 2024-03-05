library(RColorBrewer)

display.brewer.pal(11,"Dark2")

display.brewer.all()

brewer.pal(11,"Dark2")

#Test 1

scale_fill_manual(values = c("#1B9E77", "coral3", "#7570B3", "#E6AB02",
                             "blue", "#D95F02", "#66A61E", "#E7298A",
                             "#A6761D","purple","#CAFF70","red",
                             "#666666","#4682B4","#D2B48C", "#7CCD7C",
                             "brown"))

#Test 2

scale_fill_manual(values = c("black", "coral3", "#7570B3", "#1B9E77",
                             "#E6AB02", "#E7298A", "#CAFF70", "blue",
                             "#A6761D","#666666","#66A61E","red",
                             "#4682B4","orange","#D2B48C", "#7CCD7C",
                             "brown"))

