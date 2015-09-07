setwd("C:/Users/Stephane/Desktop/Coursera/Geocoding/Datos")
dir()
install.packages("RJSONIO")
library(stringr)
library(RJSONIO)
library(httr)
uncleanaddress <- read.csv("Linio_Direcciones_Originales.csv",colClasses = c("character","character","character","character","character"))
#str(uncleanaddress)
uncleanaddress$Country <- NULL

result1 <- strsplit(uncleanaddress$mailing_address,",")
#uncleanaddress[(which(sapply(result1,length) < 4)),]
##Hay 4310 direcciones de 296,533 con problemas de comas
#length(which(sapply(result1,length) != 4))
eliminate <- which(sapply(result1,length) != 4)
#write.csv(uncleanaddress[eliminate,],"direcciones_malformadas.csv")
#head(uncleanaddress)


uncleanaddress_noinvalid <- uncleanaddress[-eliminate,]
rm(uncleanaddress)
rm(result1)
rm(eliminate)
#uncleanaddress_noinvalid[which(!(uncleanaddress_noinvalid$CustomerNum_OrderNum %in% workingset$CustomerNum)),]
     
296533-4310
nrow(uncleanaddress_noinvalid)
#head(uncleanaddress_noinvalid,5)
uncleanaddress_noinvalid[sample(1:nrow(uncleanaddress_noinvalid),20),]

result <- strsplit(uncleanaddress_noinvalid$mailing_address,",")
#uncleanaddress_noinvalid[which(sapply(result,length) != 4),]


parsed <- do.call(rbind,result)
#head(parsed,10)
#str(parsed)
#str(uncleanaddress_noinvalid)
workingset <- cbind(uncleanaddress_noinvalid,as.character(parsed[,1]),as.character(parsed[,2]),as.character(parsed[,3]),as.character(parsed[,4]))
rm(parsed)
rm(uncleanaddress_noinvalid)
rm(result)

workingset[sample(1:nrow(workingset),20),]
names(workingset) <- c("CustomerNum","mailing_address","city","state","PostCode","streetno","colonia","municipio","ZIP")
workingset$streetno <- as.character(workingset$streetno)
workingset$colonia <- as.character(workingset$colonia)
workingset$municipio <- as.character(workingset$municipio)
workingset$ZIP <- as.character(workingset$ZIP)


workingset[which(workingset$municipio == "|"),]
workingset[which(workingset$municipio == "|"),8] <- "Salamanca"
sapply(workingset,class)

for(i in seq_along(workingset)){
  workingset[[i]] <- gsub("é","e",workingset[[i]])
  workingset[[i]] <-gsub("á","a",workingset[[i]])
  workingset[[i]] <-gsub("í","i",workingset[[i]])
  workingset[[i]] <-gsub("ó","o",workingset[[i]])
  workingset[[i]] <-gsub("ú","u",workingset[[i]])
  workingset[[i]] <- gsub("É","E",workingset[[i]])
  workingset[[i]] <-gsub("Á","A",workingset[[i]])
  workingset[[i]] <-gsub("Í","I",workingset[[i]])
  workingset[[i]] <-gsub("Ó","O",workingset[[i]])
  workingset[[i]] <-gsub("Ú","U",workingset[[i]])
  workingset[[i]] <-gsub("|"," ",workingset[[i]],fixed = TRUE)
  workingset[[i]] <-gsub("/","-",workingset[[i]],fixed = TRUE)
  workingset[[i]] <-gsub("\"","-",workingset[[i]],fixed = TRUE)
}


# head(workingset)
names(workingset) <- c("CustomerNum","mailing_address","city","state","PostCode","streetno","colonia","municipio","ZIP")
class(workingset$ZIP)
table(nchar(as.character(workingset$ZIP)))
length(unique(workingset$state))


workingset[which(workingset$CustomerNum == "557731_208469446"),]
workingset[which(workingset$municipio == "-"),]
workingset[which(workingset$municipio == "-"),8] <- "Celaya"

workingset[which(workingset$municipio == "020"),]
workingset[which(workingset$municipio == "020"),8] <- "Leon"

workingset[which(workingset$municipio == "|"),]
workingset[which(workingset$municipio == "|"),8] <- "Salamanca"

workingset[which(workingset$municipio == "115"),]
workingset[which(workingset$municipio == "115"),8] <- "Puebla"

workingset[which(workingset$municipio == "251"),]
workingset[which(workingset$municipio == "251"),8] <- "Colima"

workingset[which(workingset$municipio == "302"),]
workingset[which(workingset$municipio == "302"),8] <- "Miguel Hidalgo"

workingset[which(workingset$municipio == ""),]$municipio <- workingset[which(workingset$municipio == ""),]$city
unique(workingset$municipio)[order(unique(workingset$municipio))]
#write.csv(unique(workingset$municipio)[order(unique(workingset$municipio))],"municipios.csv")
municipios_limpios <- read.csv("municipios_limpios.csv")
workingset <- merge(workingset,municipios_limpios, by.x = "municipio", by.y = "MunicipioOriginal")
rm(municipios_limpios)
names(workingset)
#write.csv(unique(workingset$MunicipioCorregido)[order(unique(workingset$MunicipioCorregido))],"municipios_temp.csv")
head(workingset)
workingset$municipio <- NULL 
workingset <- workingset[,c(1,2,3,4,5,6,7,9,8)]

nrow(workingset)

# workingset[which(workingset$CustomerNum == 224),]
# sapply(workingset,class)
#rm(workingset)
names(workingset) <- c("CustomerNum","mailing_address","city","state","PostCode","streetno","colonia","municipio","ZIP")
workingset$mailing_address <- NULL
workingset$PostCode <- NULL
#states <- paste(levels(workingset$state))
#write.csv(states,file = "states.csv")
states <- read.csv("states.csv")
workingset[223,]
workingset[which(workingset$State == "Chihuahua"),] 
workingset <- merge(workingset,states, by.x = "state", by.y = "State_SHRT")
rm(states)

workingset$state <- NULL
workingset <- workingset[order(workingset$CustomerNum),]
head(workingset)
nrow(workingset)


geocoderfile <- paste(names(workingset),collapse="|")
geocodercontent <- apply(workingset,MARGIN = 1,FUN = paste,collapse="|")
str(geocodercontent)
class(geocodercontent)
head(geocodercontent)
geocodercontent2 <- rbind(geocodercontent)

write.table(geocoderfile,"togeocode.txt",quote = FALSE,row.names=FALSE,col.names=FALSE)
write.table(geocodercontent2,"togeocode.txt",quote = FALSE,row.names=FALSE,col.names=FALSE,append= TRUE,sep="\n")

write.csv(workingset,file = "geocodetestclean.csv",row.names = FALSE)
workingset[grep("Interior",workingset$streetno),]
workingset[grep("Fracc",workingset$colonia),]





geocodeHERE_simple <- function(search, App_id="", App_code=""){
  if(!is.character(search)){stop("'search' must be a character string")}
  if(!is.character(App_id)){stop("'App_id' must be a character string")}
  if(!is.character(App_code)){stop("'App_code' must be a character string")}
  
  if(App_id=="" & App_code==""){
    App_id <- "DemoAppId01082013GAL"
    App_code <- "AJKnXv84fjrb0KIHawS0Tg"
    base_url <- "http://geocoder.cit.api.here.com/6.2/geocode."
  }else{
    base_url <- "http://geocoder.api.here.com/6.2/geocode."
  }
 
  search <- RCurl::curlEscape(search)
  format<- "json"
  final_url <- paste0(base_url, format, "?app_id=", App_id, "&app_code=",
                      App_code, "&searchtext=", search)
  
  response <- RCurl::getURL(final_url)
  response_parsed <- RJSONIO::fromJSON(response)
  if(length(response_parsed$Response$View) > 0){
    ret <- response_parsed$Response$View[[1]]$Result[[1]]$Location$DisplayPosition
  }else{
    ret <- NA
  }
  return(ret)
}

geocodeHERE_simple("coyoacan")


##Upload a request
head(workingset)

# addresses_df <- read.table("prueba1.txt",sep = "|")
header <- "recID|searchText|country"
testworkingset <- workingset[250001:292223,]
rm(testworkingset)
rm(workingset)
therest <- paste(paste(testworkingset$CustomerNum,paste(testworkingset$streetno,testworkingset$colonia,testworkingset$municipio,testworkingset$State,testworkingset$ZIP,sep=" "),"MEX",sep="|"), collapse="\n") 
# head(therest) <- paste(paste(addresses_df[,1], addresses_df[,2],addresses_df[,3], sep="|"), collapse="\n") 
address_string <- paste(header, therest, sep="\n") 
rm(therest)
rm(address_string)



email_address <- "stephanekeil@gmail.com"
App_id <- "ReSO6JzFpl5RMpCrCW19"
App_code <- "lNSnXp94CS9jG5-KpMAt7A"

if(App_id=="" & App_code==""){ 
    App_id <- "DemoAppId01082013GAL" 
    App_code <- "AJKnXv84fjrb0KIHawS0Tg" 
    base_url <- "http://batch.geocoder.cit.api.here.com/6.2/jobs" 
 }else{ 
    base_url <- "http://batch.geocoder.api.here.com/6.2/jobs" 
  } 

a <- httr::POST(base_url, encode="multipart", 
              body=address_string, 
              query=list( 
              action="run", 
              mailto=email_address,
              gen = "7",
              header="true", 
              indelim="|", 
              outdelim="|", 
              outcols="displayLatitude,displayLongitude,houseNumber,street,district,city,postalCode,county,state,country,relevance,matchCode,matchType,matchLevel,matchQualityStreet,matchQualityHouseNumber,matchQualityBuilding,matchQualityDistrict,matchQualityCity,matchQualityPostalCode,matchQualityCounty,matchQualityState,matchQualityCountry", 
              outputCombined="false", 
              app_id=App_id, 
              app_code=App_code), 
              httr::verbose()) 
response <- httr::content(a) 
request_id <- response$Response$MetaInfo$RequestId
#request_id <- "nKcBko9mVN29ncIdEOpEnWNHDog4bA5N" 0-100,000
#request_id <- "xGaHJsgAACuGSCpSsWxCECXTayh8uAzD" 100001-200000
#request_id <- "HV5AzRMtgH1bGeKmdAaPX9XfVHEbVvCm" 200000-250000
#request_id <- "SwvrbRDffsH6vEF0oPzPpnuYNhzubFcb" 250000-300000

rm(a)
rm(response)
##Check the status of a request
status_url <- paste0(base_url,"/",
                     request_id,
                     "?action=status",
                     "&app_id=", App_id,
                     "&app_code=", App_code)
a2 <- httr::GET(status_url,httr::verbose())
response2 <- httr::content(a2)
status <- response2$Response$Status
rm("status_url","a2","response2","status")



##Get data results
download_url <- paste0(base_url, "/",
                       request_id,
                       "/result",
                       "?app_id=", App_id,
                       "&app_code=", App_code)
file_path <- tempfile()
a3 <- httr::GET(download_url, httr::write_disk(file_path, overwrite=TRUE),httr::verbose())
response3 <- httr::content(a3)
con <- unzip(file_path, exdir=paste0(file_path, "tmp"))
df <- read.delim(con, stringsAsFactors=F, sep="|")
unlink(file_path)

download_url1 <- paste0(base_url, "/",
                       request_id,
                       "/all",
                       "?app_id=", App_id,
                       "&app_code=", App_code)
file_path1 <- "zipfile"
a4 <- httr::GET(download_url1, httr::write_disk(file_path1, overwrite=TRUE),httr::verbose())
response4 <- httr::content(a4)
con1 <- unzip(file_path1, exdir=".")
df.results <- read.delim(con1[grep("out",con1)], stringsAsFactors=F, sep="|")
df.errors <- read.delim(con1[grep("err",con1)], stringsAsFactors=F, sep="|")
df.no_match <- read.delim(con1[grep("inv",con1)], stringsAsFactors=F, sep="|")
df.summary <- read.delim(con1[grep("rpt",con1)], stringsAsFactors=F, sep="|")
unlink(file_path1)
dir()
df.results <- read.delim("result_20150113-23-11_out.txt", stringsAsFactors=F, sep="|")
df.errors <- read.delim("result_20150113-23-11_err.txt", stringsAsFactors=F, sep="|")
df.no_match <- read.delim("result_20150113-23-11_inv.txt", stringsAsFactors=F, sep="|")
df.summary <- read.delim("result_20150113-23-11_rpt.txt", stringsAsFactors=F, sep="|")



str(df.results)
head(unique(df.results$recId))
length(unique(df.results$recId))
length(unique(df.errors$recId))
df.no_match
97962+2015+23
97786+2214
48821+1179
41199+1024
tail(df.results,10)
head(df.errors)
head(df.no_match)
df.no_match
workingset[which(workingset$CustomerNum == "722047_205159386"),]
df.results[which(df.results$recId == "100023_200472393"),]

no_match <- c("112881_208967112","114353_204571942","131489_205444246","146156_200976973","146803_200419283","147576_209976152","158082_201939512","165680_205264842","172986_205585856","175255_202244246","18582_203966216","20745_204919312","300609_209937222","316769_207898262","323538_203955382","333226_200234783","34064_205728236","347416_205799442","365592_209375542","379809_202239392","380179_207428922","380942_204637922","387860_208246522")
length(no_match)
workingset[which(workingset$CustomerNum %in% c("112881_208967112","114353_204571942","131489_205444246","146156_200976973","146803_200419283","147576_209976152","158082_201939512","165680_205264842","172986_205585856","175255_202244246","18582_203966216","20745_204919312","300609_209937222","316769_207898262","323538_203955382","333226_200234783","34064_205728236","347416_205799442","365592_209375542","379809_202239392","380179_207428922","380942_204637922","387860_208246522")),][1:10,]
workingset[which(workingset$CustomerNum %in% c("112881_208967112","114353_204571942","131489_205444246","146156_200976973","146803_200419283","147576_209976152","158082_201939512","165680_205264842","172986_205585856","175255_202244246","18582_203966216","20745_204919312","300609_209937222","316769_207898262","323538_203955382","333226_200234783","34064_205728236","347416_205799442","365592_209375542","379809_202239392","380179_207428922","380942_204637922","387860_208246522")),][11:23,]


workingset[which(workingset$CustomerNum %in% no_match),]

write.csv(workingset[which(workingset$CustomerNum %in% no_match),],"direcciones_sinempatel.csv",append = TRUE, row.names = FALSE)
write.csv(workingset[which(workingset$CustomerNum %in% unique(df.errors$recId)),],"direcciones_sinempate2.csv",append = TRUE, row.names = FALSE)

head(workingset,10)

head(workingset[which(workingset$CustomerNum  %in% df.errors$recId),])
therest



head(workingset[which(workingset$CustomerNum %in% unique(df.results[which(df.results$matchQualityState < 0.8),]$recId)),])
head(df.results[which(df.results$matchQualityState < 0.8),])


head(workingset[which(workingset$CustomerNum %in% unique(df.results[which(df.results$matchQualityCity < 1.0),]$recId)),])
head(df.results[which(df.results$matchQualityCity < 1.0),])

final.df <- df.results[which(df.results$seqLength==1),]
duplicatedindices <- df.results[which(duplicated(df.results$recId)),]$recId
duplicated.results <- df.results[which(df.results$recId %in% duplicatedindices),]
head(duplicated.results,5)
head(workingset[which(workingset$CustomerNum %in% duplicated.results$recId),],1)
testworkingset[which(testworkingset$CustomerNum %in% duplicated.results$recId),] 
head(duplicated.results[order(duplicated.results$recId,duplicated.results$relevance),])
final.df<-rbind(final.df,do.call(rbind,lapply(split(duplicated.results,duplicated.results$recId),function(x) {x[1,]})))

nrow(final.df)
final.df[which(final.df$recId == "722047_205159386"),]

head(testworkingset)
head(final.df)
final.df.ids <- unique(final.df$recId)
nrow(workingset[which(workingset$CustomerNum %in% final.df.ids),])
thefinalfile <- merge(workingset[which(workingset$CustomerNum %in% final.df.ids),],final.df, by.x = "CustomerNum", by.y = "recId")
head(thefinalfile)

write.csv(thefinalfile,"direcciones_empatadas3.csv",row.names=FALSE)
write.csv(final.df[,c(1,4,5,14)],"direcciones_empatadas_lat_lon3.csv",row.names=FALSE)
delete <- ls()
delete <- delete[c(1,2,3,7,8,,9,10,11,12,13,14,16,17,18,20,21,22,23,24,25,26)]
print(paste(delete,sep = "",collapse = "\",\""))
rm("a","a2","a4","App_code","App_id","base_url","con1","df.errors","df.results","df.summary","download_url1","duplicated.results","duplicatedindices","email_address","file_path1","final.df","final.df.ids","header","request_id","response","response2","response4","status","status_url","thefinalfile","workingset")
rm(delete)

direcciones.empatadas <- read.csv("direcciones_empatadas.csv", stringsAsFactors = FALSE, colClasses = rep("character",32))
head(direcciones.empatadas)
nrow(direcciones.empatadas)
sapply(direcciones.empatadas,class)
str(direcciones.empatadas)
table(nchar(direcciones.empatadas$postalCode))
direcciones.empatadas[which(nchar(direcciones.empatadas$postalCode)==4),]$postalCode <- paste("0",direcciones.empatadas[which(nchar(direcciones.empatadas$postalCode)==4),]$postalCode,sep="")
table(nchar(direcciones.empatadas$ZIP))
direcciones.empatadas[which(nchar(direcciones.empatadas$ZIP)==4),]$ZIP <- paste("0",direcciones.empatadas[which(nchar(direcciones.empatadas$ZIP)==4),]$ZIP,sep="")
dir()
custnum.AGEB <- read.csv("direcciones_empatadas_AGEB.csv", stringsAsFactors = FALSE, colClasses = rep("character",4))
head(custnum.AGEB)
nrow(custnum.AGEB)
sapply(custnum.AGEB,class)
str(custnum.AGEB)

direcciones.empatadas.AGEB <- merge(direcciones.empatadas,custnum.AGEB, by.x = "CustomerNum", by.y = "RECID")
nrow(direcciones.empatadas.AGEB)
head(direcciones.empatadas.AGEB)
direcciones.empatadas.AGEB$DISPLAYLAT <- NULL
direcciones.empatadas.AGEB$DISPLAYLON <- NULL
unique(direcciones.empatadas.AGEB$SeqNumber)
direcciones.empatadas.AGEB$matchCode<-NULL
direcciones.empatadas.AGEB$matchQualityBuilding <- NULL
direcciones.empatadas.AGEB$matchQualityCountry <- NULL
direcciones.empatadas.AGEB$SeqNumber <- NULL
direcciones.empatadas.AGEB$seqLength <- NULL
direcciones.empatadas.AGEB[which(direcciones.empatadas.AGEB$CVEGEO == ""),]$CVEGEO <- "9999999999999"
length(which(direcciones.empatadas.AGEB$CVEGEO == "9999999999999"))

NSE.AGEB <- read.csv("NSE_AGEB.csv", stringsAsFactors = FALSE)
NSE.AGEB[which(nchar(NSE.AGEB$AGEB_ID) == "7"),]
table(nchar(NSE.AGEB$AGEB_ID))
nrow(NSE.AGEB)
str(NSE.AGEB)
head(NSE.AGEB)
 ?merge
direcciones.empatadas.AGEB.NSE <- merge(direcciones.empatadas.AGEB,NSE.AGEB, by.x = "CVEGEO", by.y = "AGEB_ID",sort=FALSE,all.x = TRUE)
nrow(direcciones.empatadas.AGEB.NSE)
head(direcciones.empatadas.AGEB.NSE)
str(direcciones.empatadas.AGEB.NSE)
names(direcciones.empatadas.AGEB.NSE)
table(direcciones.empatadas.AGEB.NSE$NSE_char)
head(direcciones.empatadas.AGEB.NSE[which(is.na(direcciones.empatadas.AGEB.NSE$NSE_char)),])
parsed2 <- do.call(rbind,strsplit(direcciones.empatadas.AGEB.NSE$CustomerNum,"_",fixed = TRUE))        
head(parsed2) 
direcciones.empatadas.AGEB.NSE$Cliente <- parsed2[,1] 
direcciones.empatadas.AGEB.NSE$NumOrden <- parsed2[,2] 
direcciones.empatadas.AGEB.NSE <- direcciones.empatadas.AGEB.NSE[,c(50,51,2,48,49,4,5,6,3,7,8,12,11,13,14,16,15,17,18,19,9,10,20,21,22,23,24,25,26,27,28,1,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46)]
head(direcciones.empatadas.AGEB.NSE)
unique(direcciones.empatadas.AGEB.NSE$state)
direcciones.empatadas.AGEB.NSE[which(direcciones.empatadas.AGEB.NSE$state == "DF"),]
head(direcciones.empatadas.AGEB.NSE[which(direcciones.empatadas.AGEB.NSE$NOM_MUN == "Benito Juárez"),c(1:20)])
head(direcciones.empatadas.AGEB.NSE[which(direcciones.empatadas.AGEB.NSE$NOM_MUN == "Iztapalapa"),c(1:20)])

##Cuantas direcciones en cada tipo
suma <- table(direcciones.empatadas.AGEB.NSE$NSE_char)/length(direcciones.empatadas.AGEB.NSE$NSE_char)*100
sum(suma) 
suma <- sum(table(direcciones.empatadas.AGEB.NSE$NSE_char))-length(direcciones.empatadas.AGEB.NSE$NSE_char)
#14,491 direcciones empatadas que no tienen NSE
#4710 direcciones que no hicieron match por geografia
#9781 direcciones que estan en localidades de menos de 50,000 habitantes
14491-4710
        ?order
nrow(direcciones.empatadas.AGEB.NSE[order(direcciones.empatadas.AGEB.NSE$Cliente,direcciones.empatadas.AGEB.NSE$NumOrden,na.last=FALSE),])
write.csv(direcciones.empatadas.AGEB.NSE[sample(1:nrow(direcciones.empatadas.AGEB.NSE),2000),],"muestra_resultados.csv",row.names=FALSE)

write.csv(direcciones.empatadas.AGEB.NSE,"direcciones_empatadas_AGEB_NSE_FULL.csv",row.names=FALSE)


dir()

##Tests en Linio
direcciones <- read.csv("direcciones_empatadas_AGEB_NSE_FULL.csv",stringsAsFactors = FALSE)
?by
head(direccione)
?split
list <- split(head(direcciones,50000),head(direcciones,50000)$Cliente)
list[which(sapply(list,nrow) == 6)]
table(sapply(list,nrow))
library(plyr)
test <- ddply(direcciones,~Cliente,summarise,NSE = length(unique(NSE_char)))
nrow(test[which(test$NSE == 1),])#13648
write.csv(test,"clientes_con_masdeunadireccion.csv",row.names=FALSE)
masdeuna <- direcciones[which(direcciones$Cliente %in% test[which(test$NSE > 1),1]),]
masdeuna <- masdeuna[order(masdeuna$Cliente,masdeuna$NSE_num),]
write.csv(masdeuna[1:5],"clientesconmasdeunNSE.csv",row.names=FALSE)
head(direcciones[which(direcciones$Cliente == "512256"),],20)

transacciones <- read.csv("Transacciones.csv", stringsAsFactors = FALSE)
head(transacciones)
nrow(transacciones)
codigo.dir.unicos  <- read.csv("Linio_Direcciones_Originales.csv", stringsAsFactors = FALSE)
codigo.dir.unicos <- codigo.dir.unicos[,c(1,3)]
codigo.dir.unicos$codematch <- codigo.dir.unicos$CustomerNum_OrderNum
head(codigo.dir.unicos)
nrow(codigo.dir.unicos)
transacciones.dir.unica <- merge(transacciones,codigo.dir.unicos, by.x = "CUSTOMER_ORDER", by.y = "CustomerNum_OrderNum",sort=FALSE,all.x = TRUE)
nrow(transacciones.dir.unica)
head(transacciones.dir.unica,50)
transacciones.dir.unica.order <- transacciones.dir.unica[order(as.numeric(transacciones.dir.unica$ORDER)),]
nrow(transacciones.dir.unica.order)
head(transacciones.dir.unica.order,50)
transacciones.dir.unica.order$Country <- NULL
corregir <- which(is.na(transacciones.dir.unica.order[,5]))
transacciones.dir.unica.order[corregir,5] <- transacciones.dir.unica.order[corregir-1,5]

for(i in 1:length(corregir))
{
    transacciones.dir.unica.order[corregir[i],5] <- transacciones.dir.unica.order[corregir[i]-1,5]
  print(i)
}
write.csv(transacciones.dir.unica.order,"transacciones_matchcode.csv",row.names=FALSE)
dir()
direcciones_empatadas <- read.csv("direcciones_empatadas_AGEB_NSE_FULL.csv", stringsAsFactors = FALSE)
rm(transacciones.dir.unica)
head(direcciones_empatadas)
direcciones_empatadas <- direcciones_empatadas[,c(3,4,5,32)]

names(direcciones_empatadas)
str(direcciones_empatadas)
direcciones_sin_empate <- read.csv("direcciones_sinempate.csv", stringsAsFactors = FALSE)
head(direcciones_sin_empate)
direcciones_sin_empate$NSE_num <- rep(0,nrow(direcciones_sin_empate))
direcciones_sin_empate$NSE_char <- rep("Dir Sin Empate AGEB",nrow(direcciones_sin_empate))
direcciones_sin_empate$CVEGEO <- rep("9999999999999",nrow(direcciones_sin_empate))
direcciones_sin_empate <- direcciones_sin_empate[,c(1,8,9,10)]
names(direcciones_sin_empate) <- c("CustomerNum","NSE_num","NSE_char","CVEGEO")
direcciones_malformadas <- read.csv("direcciones_malformadas.csv", stringsAsFactors = FALSE)
head(direcciones_malformadas)
direcciones_malformadas$NSE_num <- rep(0,nrow(direcciones_malformadas))
direcciones_malformadas$NSE_char <- rep("Dir Malformada",nrow(direcciones_malformadas))
direcciones_malformadas$CVEGEO <- rep("9999999999999",nrow(direcciones_malformadas))
names(direcciones_malformadas) <- c("CustomerNum","NSE_num","NSE_char","CVEGEO")

direcciones_malformadas <- direcciones_malformadas[,c(2,7,8,9)]
direcciones <- rbind(direcciones_empatadas,direcciones_sin_empate,direcciones_malformadas)
nrow(direcciones)

transacciones.NSE <- merge(transacciones.dir.unica.order,direcciones, by.x = "codematch", by.y = "CustomerNum",sort=FALSE,all.x = TRUE)
head(transacciones.NSE)
nrow(transacciones.NSE)
table(transacciones.NSE$NSE_num)/nrow(transacciones.NSE)
29891  +11938 + 53848+  88034+ 117786+ 151601+ 200870+ 151971
transacciones.NSE[which(is.na(transacciones.NSE$NSE_num)),]$NSE_num <- 0
transacciones.NSE[which(is.na(transacciones.NSE$NSE_char)),]$NSE_char <- "Localidad de menos de 50,000 habs"
transacciones.NSE$codematch <- NULL
transacciones.NSE$CUSTOMER_ORDER <- NULL
transacciones.NSE <- transacciones.NSE[order(transacciones.NSE$ORDER),]
names(transacciones.NSE) <- c("RegistroNumero","Cliente","OrdenNum","NSE_num","NSE_char","AGEB")
write.csv(transacciones.NSE,"transacciones_NSE.csv",row.names=FALSE)

transacciones.NSE <- read.csv("transacciones_NSE.csv", stringsAsFactors = FALSE)
table(transacciones.NSE$NSE_char)
ddply(sessions,.(contactGrp),
      summarise,
      count = length(contact[relpos == 0 & maxpos > 1]))


direcciones_empatadas <- read.csv("direcciones_empatadas_AGEB_NSE_FULL.csv", stringsAsFactors = FALSE)
table(direcciones_empatadas$State,direcciones_empatadas$NSE_num, useNA = "always")
?table
