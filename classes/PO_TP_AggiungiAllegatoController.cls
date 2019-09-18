public class PO_TP_AggiungiAllegatoController {
    
    public String case_id {get;set;}
    public Attachment attach {get;set;}
    public String fileName {get;set;}
    public Blob fileBody {get;set;}
    public String statusTP {get;set;}
    public List<Attachment> lista_allegati {get;set;}
    public boolean showAllegati{get;set;}
    
    public PO_TP_AggiungiAllegatoController()
    {
        String tempOrigId = ApexPages.currentPage().getParameters().get('origId');
        if(String.isBlank(case_id) || String.isNotBlank(tempOrigId) ) {
            case_id = ApexPages.currentPage().getParameters().get('origId');
        }
        
        lista_allegati = [Select id, Name
                         from attachment
                         where parentId = :case_id];
                        
        if(lista_allegati.size()>0){
            showAllegati = true;
        }
    }
    
    public PageReference uploadAttach()
    {
        PageReference pg = new PageReference('/PO_TP_AggiungiAllegato');
        pg.getParameters().put('origId',case_id);
        
        if(fileBody==null) {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Scegliere prima il file da allegare'));
            return null;
        }
        else
        {
            lista_allegati = new List<Attachment>();
            
            attach = new Attachment();
            attach.name = fileName;
            attach.body = fileBody;
            attach.parentId = case_id;
            lista_allegati.add(attach);
            insert lista_allegati;
            
            return pg;
        }
    }

    public PageReference goToRiepilogoRichiesta()
    {
        PageReference pg = new PageReference('/PO_TP_InsertNewRequest');
        pg.getParameters().put('proc','TPVisualizzaIncident');
        pg.getParameters().put('origId',case_id);
        return pg;
    }
    
    public PageReference annulla(){
        
        PageReference pg = new PageReference('/PO_TP_InsertNewRequest');
        pg.getParameters().put('azione','Incident');
        return pg;
    }

}