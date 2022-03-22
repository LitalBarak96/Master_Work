path<-"F:/allGroups/Males_Grouped"
setwd(path)
dir<-list.dirs(recursive = F)
chain_path<-list.files(path=dir, pattern="Chain", all.files=TRUE,
                        full.names=TRUE)
chase_path<-list.files(path=dir, pattern="Chase", all.files=TRUE,
                        full.names=TRUE)
song_path<-list.files(path=dir, pattern="Song", all.files=TRUE,
                       full.names=TRUE)
unlink(song_path)
unlink(chain_path)
unlink(chase_path)
