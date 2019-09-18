public class PO_AMJSONtoApexVia {
//Abhishek Anand 21112028 - FOR CR34 addreessmatching requirement this class is used to parse the JSON response 
//string coming for the VIA(Italian) values
 
    public cls_Address Address;
   public String Result;   //OK
  public class cls_Address {
      public cls_Comune Comune;
   }
  public class cls_Comune {
      public String NumRecord;   //11
      public List<cls_Strada> Strada;
   }
   public class cls_Strada {
      public String DescStrada;  //VIA DON LUIGI STURZO
      public String Cap;   //05100
      public String IdEgonStrada;   //38000647675
   }
    public static PO_AMJSONtoApexVia parse(String json){
        return (PO_AMJSONtoApexVia ) System.JSON.deserialize(json, PO_AMJSONtoApexVia .class);
    }
}