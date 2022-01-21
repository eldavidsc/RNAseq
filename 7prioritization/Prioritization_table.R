diffexp <- read.table("result_tableT.txt")
codingprot <- read.table("CPAT_datanovelcut.txt")
intergenic <- read.table("inter.txt",sep="\t")
tsspolya <- read.table("TSS_polyA.txt",sep="\t",header=T, fileEncoding = "UCS-2LE")


```{r}
intermut <- intergenic %>% 
  mutate(target_id = )
```

test <- read.csv("inter.txt",sep = " ")

```{r}
#Cutting intergenic and adding intergenic variable
intergenic_cut <- test %>% 
  mutate(target_id = gsub(test$MSTRG.1., pattern = ";", replacement = "")) %>% 
  mutate(intergenic = TRUE) %>% 
  select(target_id,intergenic)
```

```{r}
#Cutting diffexp
diffexp_cut <- diffexp %>% 
  select(target_id,b)
```

```{r}
#Editing and cutting coding potential
codingprot_cut <- codingprot %>% 
  mutate(target_id = rownames(codingprot)) %>% 
  mutate(codingprot = TRUE) %>% 
  select(target_id,codingprot)

```

```{r}
#Edit tsspolya
tsspolya_cut<- tsspolya %>% 
  mutate(endannotationtrue = TRUE) %>% 
  select(target_id,endannotationtrue)

```

```{r}
merge1 <- merge(intergenic_cut, tsspolya_cut,by = "target_id",all=T)
merge2 <- merge(merge1, diffexp_cut,by = "target_id",all=T)
merge3 <- merge(merge2, codingprot_cut, by = "target_id",all=T)

```

```{r}
write.csv(merge3,"prioritization_table.csv")
```


```{r}
merge3 %>% 
  filter(endannotationtrue = TRUE) %>% 
  filter(codingprot = TRUE)
```





```{r}
#merge all

prioritization_table <- merge(intergenic_cut, diffexp_cut, codingprot_cut, tsspolya_cut, by = "target_id",all=T)


```


