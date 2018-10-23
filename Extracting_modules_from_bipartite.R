
modules_from_bipartite=function(info_mod) {
  
  Rtable=data.frame(info_mod[[1]][[1]][[1]])
  colnames(Rtable)="Row_names"
  Ctable=data.frame(info_mod[[1]][[1]][[2]])
  colnames(Ctable)="Col_names"
  
  # Diferentes niveis de modularidade
  for (nivel in 2:length(info_mod)) {
    
    RModN=vector(length = nrow(Rtable))
    names(RModN)=Rtable[,1]
    
    CModN=vector(length = nrow(Ctable))
    names(CModN)=Ctable[,1]
    
    # Diferentes modulos no mesmo nivel
    for (modulo in 1:length(info_mod[[nivel]])) {
      
      RModNM=info_mod[[nivel]][[modulo]][[1]]
      CModNM=info_mod[[nivel]][[modulo]][[2]]
      
      RModN[RModNM]=modulo
      CModN[CModNM]=modulo
    }
    
    
    Rtable[,paste("Nivel",nivel-1,sep = "_")]=RModN
    Ctable[,paste("Nivel",nivel-1,sep = "_")]=CModN
  }
  
  return(list(Rows_modules=Rtable, Cols_modules=Ctable))
  
}
