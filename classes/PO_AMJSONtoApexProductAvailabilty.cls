public class PO_AMJSONtoApexProductAvailabilty{
	public String Result;	//OK
	public String Description;	//
	public String NumRecord;	//2
	//public cls_IdCivico[] IdCivico;
    public list<cls_IdCivico> IdCivico;
	public class cls_IdCivico {
		public String ID_BUILDING;	//10_054_054039_8000065082_78 
		public String SCALA_PALAZZINA;	//A
		public String POP;	//PG_01
		public String SERVICE_TYPE;	//Attivo
		public String SERVICE_STATUS;	//110
		public String DATA_RFC_INDICATIVA;	//01/04/2018 00:00
		public String DATA_RFC_EFFETTIVA;	//01/04/2018 00:00
		public String DATA_RFA_INDICATIVA;	//01/04/2018 00:00
		public String DATA_RFA_EFFETTIVA;	//01/04/2018 00:00
		public String DATA_ULTIMA_MODIFICA_RECORD;	//01/04/2018 00:00
		public String DATA_ULTIMA_VARIAZIONE_STATO_BUILDING;	//01/04/2018 00:00
		public String DATA_ULTIMA_VARIAZIONE_STATO_SCALA_PALAZZINA;	//
	}
	public static PO_AMJSONtoApexProductAvailabilty parse(String json){
		return (PO_AMJSONtoApexProductAvailabilty) System.JSON.deserialize(json, PO_AMJSONtoApexProductAvailabilty.class);
	}
}