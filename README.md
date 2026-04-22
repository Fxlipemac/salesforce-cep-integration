# Salesforce CEP Integration

Integração REST no Salesforce que consome a API pública [ViaCEP](https://viacep.com.br) para busca e preenchimento automático de endereços a partir de um CEP.

## Demonstração

O usuário digita um CEP no componente LWC e clica em **Buscar** — o endereço é retornado pela API e exibido automaticamente na tela.

## Tecnologias

- **Apex** — consumo da API REST externa e desserialização do JSON
- **LWC** — interface do usuário com campo de CEP e exibição do endereço
- **REST API** — integração com a API pública ViaCEP
- **Git** — versionamento com fluxo de branches e Pull Requests

## Arquitetura

LWC (cepForm)
↓ usuário digita o CEP e clica em Buscar
Apex (ViaCepService)
↓ monta requisição HTTP GET
API ViaCEP (https://viacep.com.br)
↓ retorna JSON com dados do endereço
Apex (ViaCepService)
↓ desserializa e filtra os campos
LWC (cepForm)
↓ exibe o endereço preenchido automaticamente

## Estrutura do Projeto

force-app/main/default/
├── classes/
│   ├── ViaCepService.cls         # Classe Apex de integração REST
│   ├── ViaCepServiceMock.cls     # Mock para testes unitários
│   └── ViaCepServiceTest.cls     # Testes unitários (100% de cobertura)
└── lwc/
└── cepForm/                  # Componente LWC de busca de CEP

## Testes

Os testes unitários cobrem 100% do código da classe `ViaCepService`, utilizando `HttpCalloutMock` para simular as respostas da API sem realizar chamadas externas reais.

```bash
sf apex run test --class-names ViaCepServiceTest --target-org dev-org --result-format human
```

## Como executar localmente

```bash
# Autenticar na org
sf org login web --alias dev-org

# Deploy para a org
sf project deploy start --source-dir force-app/ --target-org dev-org
```