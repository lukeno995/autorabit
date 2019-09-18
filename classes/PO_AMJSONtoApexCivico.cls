public class PO_AMJSONtoApexCivico {

//Abhishek Anand 21112028 - FOR CR34 addreessmatching requirement this class is used to parse the JSON response 
//string coming for the Civico (Italian) values

  public String Result;  //OK
  public cls_Address Address;
  public class cls_Address {
    public cls_Comune Comune;
  }
  public class cls_Comune {
    public cls_Strada Strada;
  }
  public class cls_Strada {
    public String NumRecord;  //1
    public List<cls_civico> civico;
  }
  public class cls_civico {
    public String IdEgonCivico;  //380000024980000
    public String DescCivico;  //55
    public String Esponente;  //
    public String TipoCivico ;  //0
  }
    public static PO_AMJSONtoApexCivico parse(String json){
        return (PO_AMJSONtoApexCivico ) System.JSON.deserialize(json, PO_AMJSONtoApexCivico .class);
    }
}