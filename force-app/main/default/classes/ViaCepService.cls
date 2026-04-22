public with sharing class ViaCepService {
    @AuraEnabled
    public static Map<String, String> buscarEndereco(String cep) {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        HttpResponse response;
        
        request.setEndpoint('https://viacep.com.br/ws/' + cep + '/json/');
        request.setMethod('GET');

        response = http.send(request);
            if (response.getStatusCode() == 200) {

                Map<String, Object> resultado = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
                
                Map<String, String> endereco = new Map<String, String>();
                endereco.put('cep', (String) resultado.get('cep'));
                endereco.put('logradouro', (String) resultado.get('logradouro'));
                endereco.put('bairro', (String) resultado.get('bairro'));
                endereco.put('localidade', (String) resultado.get('localidade'));
                endereco.put('uf', (String) resultado.get('uf'));

                return endereco;
            } else {
                return null;
            }
    }
}