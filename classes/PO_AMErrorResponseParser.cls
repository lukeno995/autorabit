public class PO_AMErrorResponseParser {

   
	public String Result;	//KO
	public String Code;	//C01
	public String Description;	//Il parametro Str non è presente
	public static PO_AMErrorResponseParser parse(String json){
		return (PO_AMErrorResponseParser) System.JSON.deserialize(json, PO_AMErrorResponseParser.class);
	}
    
}