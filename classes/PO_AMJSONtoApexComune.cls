public class PO_AMJSONtoApexComune{

//Abhishek Anand 21112028 - FOR CR34 addreessmatching requirement this class is used to parse the JSON response 
//string coming for the Comune(Italian) values

    public cls_Address Address;
    public String Result;   //OK
    public class cls_Address {
        public String NumRecord;    //1
        public list<cls_Comune> Comune;
    }
    public class cls_Comune {
        public String IdEgonComune; //38000000533
        public String Cap;  //05100
        public String DescProvincia;    //TERNI
        public String DescComune;   //TERNI
    }
    public static PO_AMJSONtoApexComune parse(String json){
        return (PO_AMJSONtoApexComune) System.JSON.deserialize(json, PO_AMJSONtoApexComune.class);
    }
    
}