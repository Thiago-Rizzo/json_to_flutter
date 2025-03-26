# Flutter JSON Code Generator

Essa biblioteca de linha de comando (CLI) foi criada para agilizar a criação de arquivos Dart a partir de um arquivo JSON. Ela oferece a possibilidade de gerar arquivos como Models, SuperModel, Controllers, Services e um HttpClient (Dio), de maneira semelhante ao que o Artisan faz no Laravel com o comando `make`.

## Funcionalidades

- **Gerar Models**: Crie automaticamente classes Dart baseadas no esquema do seu arquivo JSON.
- **Gerar SuperModel**: Crie um SuperModel genérico para facilitar a reutilização e gerenciamento de dados.
- **Gerar Controllers**: Crie controllers com a estrutura necessária para manipulação de dados.
- **Gerar Services**: Crie services para organizar as lógicas de negócio.
- **Gerar HttpClient**: Gera um cliente HTTP com o pacote Dio para consumir APIs.

## Como Funciona?

Com base no seu arquivo JSON, essa CLI gera automaticamente os arquivos necessários, conforme a sua escolha. Ao rodar o comando, você pode escolher quais arquivos você quer gerar, facilitando a organização do código no seu projeto Flutter.

## Instalação

Para instalar a CLI, basta rodar o seguinte comando:

```bash
dart pub global activate json_to_flutter
```

#### Exemplo de Uso

```bash
jf
```

Isso gerará todos os arquivos: Models, SuperModel, Controllers, Services e um HttpClient para consumir a API.

## Exemplo de Geração

### Arquivo JSON Exemplo

```json
{
  "packageName": "json_to_flutter",
  "stubs": {
    "model": "lib/stubs/model.stub",
    "superModel": "lib/stubs/super_model.stub",
    "controller": "lib/stubs/controller.stub",
    "httpClient": "lib/stubs/http_client.stub",
    "service": "lib/stubs/service.stub"
  },
  "modules": [
    {
      "name": "User",
      "fields": [
        {
          "name": "id",
          "type": "int"
        },
        {
          "name": "name",
          "type": "String"
        },
        {
          "name": "email",
          "type": "String",
          "default": "null"
        }
      ]
    }
  ]
}
```

Isso gerará a seguinte estrutura de arquivos:

- `lib/core/http_client.dart`
- `lib/app/data/models/model.dart`
- `lib/app/data/models/user.dart`
- `lib/app/data/services/user_service.dart`
- `lib/app/modules/user/controller.dart`

## Roadmap

### Próximas Funcionalidades

- [ ] Interface interativa para seleção dos arquivos a serem gerados.
- [ ] Opção para personalizar templates de geração de código.
- [ ] Suporte a geração de testes automatizados para os arquivos criados.

Esse roadmap pode ser ajustado conforme o feedback da comunidade. Contribuições são bem-vindas!
