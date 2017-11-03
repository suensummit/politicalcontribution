require(ggplot2)
require(data.table)

setwd("~/Documents/politicalcontribution/")
company <- fread("legislators/2016/A02_company_all_public.csv")

temp <- as.POSIXlt(as.Date(company$交易日期, "%Y/%m/%d"))
temp$year <- temp$year + 1911
company[, c("交易日期") := as.Date(temp)]
company[, c("候選人") := as.factor(company$候選人)]

str(company)
summary(company)

ggplot(company[候選人 %in% c("丁守中", "黃珊珊")], aes(交易日期, 收入金額)) + 
  geom_histogram(stat = "identity") + 
  scale_x_date(date_breaks = "2 month", date_labels = "%b %Y") + 
  facet_grid(. ~ 候選人) + 
  theme(text = element_text(size = 12, family = "STHeiti"))
