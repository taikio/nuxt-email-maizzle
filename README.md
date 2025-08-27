# Gerador de HTML e-mail friendly com Nuxt 4 e Maizzle

## Ferramentas Utilizadas

Estamos utilizando o motor de processamento do Maizzle para fazer o mapeamento de classes utilizadas nos componentes Vue e substituir pelo style inline das mesmas. A grande vantagem de utilizar esta ferramenta é que ela já vem com o tailwind embutido nela, nos permitindo usar utility classes na construção dos templates de e-mail, e graças ao preset `tailwind-preset-email` temos a garantia de que o style gerado no final será e-mail friendly, subsitituindo `rem` por `px` por exemplo.

[Documentação Oficial do Maizzle](https://maizzle.com/docs/api);

Também usamos o Cheerio para facilitar a sanitização do HTML final, removendo meta tags adicionadas pelo Nuxt e pelo Devtools

[Documentação do Cheerio](https://cheerio.js.org/)

Adicionamos o motor de renderização do vue-email para processar os componentes Vue e transformá-los em HTML, sem ter a necessidade de fazer uma requisição GET para a URL do template

[Documentação do Vue-email](https://vuemail.net/getting-started/usage)

## Como funciona o projeto

Você pode criar os componentes principais dos templates dentro de `~/app/pages` e também dá para criar componentes reutilizáveis dentro de `~/app/components`. Para visualizar o resultado no browser acesse o endpoint de preview passando o caminho do template que se deseja visualizar. Ex: `http://localhost:3000/api/preview?template=/email-template`. Vale ressaltar que você estará visualizando um HTML já sanitizado e com os styles inline exatamente como será entregue no endpoint de integração.

Para obter o HTMl de um template via integração basta fazer um GET no endpoint correspondente ao template desejado e passar os parâmetros via Query.

Ex: `GET http://localhost:3000/api/email-template?nome=NomeCliente`

A idéia é que para cada template novo seja criado um endpoint de consumo.
