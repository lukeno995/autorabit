public class PO_AMResponseWrapper{

//Abhishek anand 21112018 For CR34 This class is used to wrap the data relevent for the autocomplete feature field and reflect it on the VF page
        public string label{get;set;}
        public string value{get;set;}
        public PO_AMResponseWrapper(String label, String value){
            this.label = label;
            this.value = value;
        }
        
    }