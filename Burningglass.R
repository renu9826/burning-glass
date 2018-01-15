
conBGT3 <-dbConnect(MySQL(), user = 'root', password = 'AAmmrg11!!', host = 'localhost', dbname= 'BGT3')
CLEANR.df<-dbReadTable(conn = conBGT3, name = 'CLEANR')
colnames(title.df)[1] <- "Occupation_Title"
title.df<-dbReadTable(conn = conBGT3, name = 'title')
TitleClean.df<- left_join (CLEANR.df, title.df,by= 'Occupation_Title')
colnames(TitleClean.df)
colnames(TitleClean.df)[25] <- "titleid"

TitleClean.d <- TitleClean.df[,-c(20:23)]
COUNTY.df<-dbReadTable(conn = conBGT3, name = 'COUNTY')
colnames(COUNTY.df)[1] <- "County"

TitleCleanCounty.df<- left_join (TitleClean.d, COUNTY.df,by= 'County')
colnames(TitleCleanCounty.df)
colnames(TitleCleanCounty.df)[22] <- "Countyid"

experience.df<-dbReadTable(conn = conBGT3, name = 'experience')
colnames(experience.df)
colnames(experience.df)[1] <- "Experience_Level"
TitleCleanCountyex.df<- left_join (TitleCleanCounty.df, experience.df,by= 'Experience_Level')

degree.df<-dbReadTable(conn = conBGT3, name = 'degree')
colnames(degree.df)
colnames(degree.df)[1] <- "Degree_Level"
TitleCleanCountyexDe.df<- left_join (TitleCleanCountyex.df, degree.df,by= 'Degree_Level')
unique(TitleCleanCountyexDe.df)
CLEANBGT3<- TitleCleanCountyexDe.df[!duplicated(TitleCleanCountyexDe.df), ]

CLEANBGT3$JobID<- gsub('\n','' , CLEANBGT3$JobID, ignore.case = FALSE, perl = FALSE,
     fixed = FALSE, useBytes = FALSE)
boxplot(CLEANBGT3$Posting_Duration, col= 'green')
write.csv(CLEANBGT3, file = "CLEANR.csv")
summary(CLEANBGT3$Posting_Duration)

colnames(CLEANBGT3)
write.table(CLEANBGT3, "/Users/rkelapure/Desktop/CLEANR.txt", sep="\t")
head(CLEANBGT3)
str(CLEANBGT3$JobID)

toSQL = data.frame(CLEANBGT3);
write.table(toSQL,"/Users/rkelapure/CLEANR1.txt",quote=FALSE,sep=",",row.names=FALSE,col.names=FALSE,append=FALSE);
sqlQuery(channel,"BULK
         INSERT into table BGT3.CLEANR
         FROM '\\\\<server-that-SQL-server-can-see>\\export\\filename.txt'
         WITH
         (FIELDTERMINATOR = ',',
         ROWTERMINATOR = '\n')");
dbWriteTable(conBGT3, value =CLEANBGT3, name = "CLEANR",quote=FALSE,sep=",",row.names=FALSE,col.names=FALSE, append = TRUE ) 
Skill_title<- dbReadTable(conn = conBGT3, name = 'Skill_job_Type_Title_occup')
length(unique ( Skill_title$Occupation_code ));
Skill_title2 <- unique(Skill_title$occupation_title, Skill_title$Skill_name)
UniSkilloccp<- dbReadTable(conn = conBGT3, name = 'uniSkilloccup ')
