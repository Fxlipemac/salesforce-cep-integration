@isTest
public class ViaCepServiceTest {

    private class ViaCepServiceMockError implements HttpCalloutMock {
        public HttpResponse respond(HttpRequest request) {
            HttpResponse response = new HttpResponse();
            response.setStatusCode(400);
            return response;
        }
    }

    @isTest
    static void testBuscarEnderecoSucesso() {
        Test.setMock(HttpCalloutMock.class, new ViaCepServiceMock());
        
        Test.startTest();
            Map<String, String> endereco = ViaCepService.buscarEndereco('01001000');
        Test.stopTest();

        System.assertEquals('Praça da Sé', endereco.get('logradouro'));
        System.assertEquals('São Paulo', endereco.get('localidade'));
        System.assertEquals('SP', endereco.get('uf'));
    }

    @isTest
    static void testBuscarEnderecoErro() {
        Test.setMock(HttpCalloutMock.class, new ViaCepServiceMockError());
        
        Test.startTest();
            Map<String, String> endereco = ViaCepService.buscarEndereco('00000000');
        Test.stopTest();

        System.assertEquals(null, endereco);
    }
}