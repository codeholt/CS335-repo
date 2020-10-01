library(tidyverse)
dat <- read_csv("https://byuistats.github.io/M335/data/rcw.csv", 
                col_types = cols(Semester_Date = col_date(format = "%m/%d/%y"), Semester = col_factor(levels = c("Winter", "Spring", "Fall"))))

View(dat)

dat %>% 
  group_by(Semester_Date) %>% 
  ggplot(mapping = aes(x=Semester_Date,y=Count, fill = Department, color = Department))+
  geom_col(position = "dodge",
           color="black")+
  geom_line(show.legend = TRUE, size = 1)
ggsave("conference_attendance_by_dept.png", )

?geom_line
?geom_col
dat %>% 
  ggplot(aes(x=Semester_Date))+
  geom_histogram()
