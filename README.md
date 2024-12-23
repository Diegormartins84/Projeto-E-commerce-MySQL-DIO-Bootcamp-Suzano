Projeto Conceitual: E-commerce

Qual o escopo? R: venda de produtos

Entidades: Produto, Estoque, Cliente, Pedido, Fornecedor

Levantamento de requisitos:
Narrativa: Produto
	- Os produtos são vendidos por uma única plataforma online. Contudo, estes podem ter vendedores distintos (terceiros)
    - Cada produto possui um fornecedor
    - Um ou mais produtos podem compor um pedido
    
Narrativa: Cliente
	- O cliente pode se cadastrar o site com seu CPF ou CNPJ
    - O endereço do cliente irá determinar o valor do frete
    - Um cliente pode comprar mais de um pedido. Este tem um período de carência para devolução do produto

Narrativa: Pedido
	- Os pedidos são criados por clientes que possuem informações de compra, endereço e status de entrega
    - Um produto ou mais compoem o pedido
    - O pedido pode ser cancelado
    
Narrativa: Fornecedor & estoque
	- Vamos pensar juntos...

Refinando
    Cliente PJ e PF - Uma conta pode ser PJ ou PF, mas não pode ter as duas informações
    Pagamento - Pode ter cadastrado mais de uma forma de pagamento
    Entrega - Possui status e código de rastreio
