public class OF_CV_Entry_Checks_Invio_Link {
    
    public static OF_CV_WS_Invio_Link.ResponseFromSend syncCheck(OF_CV_WS_Invio_Link.Tracking track)
    {
        if(String.isBlank(track.ID_REQUEST)){
            OF_CV_WS_Invio_Link.ResponseFromSend resp = new OF_CV_WS_Invio_Link.ResponseFromSend();
            resp.ID_NOTIFICA = track.ID_REQUEST;
            resp.ESITO = 'KO';
            resp.DESCRIZIONE_ESITO = 'Campo obbligatorio ID_REQUEST non valorizzato';
            return resp;
        }
        if(String.isBlank(track.ID_RICHIESTA_VENDIBILITA)){
            OF_CV_WS_Invio_Link.ResponseFromSend resp = new OF_CV_WS_Invio_Link.ResponseFromSend();
            resp.ID_NOTIFICA = track.ID_REQUEST;
            resp.ESITO = 'KO';
            resp.DESCRIZIONE_ESITO = 'Campo obbligatorio ID_RICHIESTA_VENDIBILITA non valorizzato';
            return resp;
        }
        //Se l'esito è OK, verifico se i campi sono valorizzati, aggiorno l'oggetto Tracciamento su SF e mando la mail
        if(track.ESITO=='OK'){
            if(String.isBlank(track.OLO)){
                OF_CV_WS_Invio_Link.ResponseFromSend resp = new OF_CV_WS_Invio_Link.ResponseFromSend();
                resp.ID_NOTIFICA = track.ID_REQUEST;
                resp.ESITO = 'KO';
                resp.DESCRIZIONE_ESITO = 'Campo obbligatorio OLO non valorizzato';
                return resp;
            }
            if(String.isBlank(track.SERVIZIO)){
                OF_CV_WS_Invio_Link.ResponseFromSend resp = new OF_CV_WS_Invio_Link.ResponseFromSend();
                resp.ID_NOTIFICA = track.ID_REQUEST;
                resp.ESITO = 'KO';
                resp.DESCRIZIONE_ESITO = 'Campo obbligatorio SERVIZIO non valorizzato';
                return resp;
            }
            if(String.isBlank(track.LINK_FILE)){
                OF_CV_WS_Invio_Link.ResponseFromSend resp = new OF_CV_WS_Invio_Link.ResponseFromSend();
                resp.ID_NOTIFICA = track.ID_REQUEST;
                resp.ESITO = 'KO';
                resp.DESCRIZIONE_ESITO = 'Campo obbligatorio LINK_FILE non valorizzato';
                return resp;
            }
            
            List<EOF_CV_TRACCIAMENTO_VENDIBILITA__c> list_tracciamenti = [SELECT id, ID_request__c, Email__c, Link__c, Esito__c, olo__c, servizio__c
                                                                            FROM EOF_CV_TRACCIAMENTO_VENDIBILITA__c
                                                                            WHERE ID_request__c =: track.ID_RICHIESTA_VENDIBILITA
                                                                            AND olo__c =: track.OLO
                                                                            AND servizio__c =: track.SERVIZIO
                                                                          ];
            if(list_tracciamenti.isEmpty()){
                OF_CV_WS_Invio_Link.ResponseFromSend resp = new OF_CV_WS_Invio_Link.ResponseFromSend();
                resp.ID_NOTIFICA = track.ID_REQUEST;
                resp.ESITO = 'KO';
                resp.DESCRIZIONE_ESITO = 'Valore campo ID_RICHIESTA_VENDIBILITA non valido';
                return resp;
            }else{
                EOF_CV_TRACCIAMENTO_VENDIBILITA__c tracciato = list_tracciamenti.get(0);
                tracciato.Link__c = track.LINK_FILE;
                tracciato.esito__c = track.ESITO;
                update tracciato;
                sendEmail(tracciato);
            }
        }
        else{
            List<EOF_CV_TRACCIAMENTO_VENDIBILITA__c> list_tracciamenti = [SELECT id, ID_request__c, Email__c, Link__c, Esito__c, olo__c, servizio__c
                                                                            FROM EOF_CV_TRACCIAMENTO_VENDIBILITA__c
                                                                            WHERE ID_request__c =: track.ID_RICHIESTA_VENDIBILITA
                                                                          ];
            EOF_CV_TRACCIAMENTO_VENDIBILITA__c tracciato = list_tracciamenti.get(0);
            tracciato.esito__c = track.ESITO;
            update tracciato;
            sendEmail(tracciato);
        }
        OF_CV_WS_Invio_Link.ResponseFromSend res = new OF_CV_WS_Invio_Link.ResponseFromSend();
        res.ESITO = 'OK';
        return res;
    }
    
    public static void sendEmail(EOF_CV_TRACCIAMENTO_VENDIBILITA__c tr){
        
        String userEmail = tr.Email__c;
        String textBody = '';
        if(userEmail != null && String.isNotBlank(userEmail)){
            
            if(tr.esito__c=='OK')
            {
                textBody = 'Salve, \ndi seguito il link per scaricare il file relativo alla vendibilità richiesta! \n\n' + tr.Link__c;
            }
            else{
                textBody = 'Salve, \nnon è stato possibile produrre il file, contattare l\'Amministratore';
            }
            String subject = 'Export vendibilità';
            
            List<String> toAddresses = new List<string> {userEmail};
            
            Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
            email.setSubject(subject);
            email.setToAddresses(toAddresses);
            email.setPlainTextBody(textBody);
            Messaging.SendEmailResult [] r = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});
        }
    }
}