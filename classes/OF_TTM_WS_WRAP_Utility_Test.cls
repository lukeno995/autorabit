@isTest
public class OF_TTM_WS_WRAP_Utility_Test {
  
@isTest
     public static void  Function1()
     { 
       OF_TTM_WS_WRAP_Utility T1=new OF_TTM_WS_WRAP_Utility();
      string k='test';
      T1.getKeyByValue_TipoComunicazione(k);
      T1.getKeyByValue_DescrEvRis(k);
      T1.getKeyByValue_CausaleSosp(k);  
      T1.getValueByKey_CausaleSosp(k);
      T1.getValueByKey_DescrEvRis(k);
      T1.getValueByKey_TipoComunicazione(k);
         
         
     }
   
}