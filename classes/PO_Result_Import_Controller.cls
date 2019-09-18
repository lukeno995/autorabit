public class PO_Result_Import_Controller {

    public PO_Result_Import_Controller(){ }
    
    public PageReference annulla(){
        return new PageReference('/apex/PO_Index'); 
    }
}