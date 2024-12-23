## Sistema de E-commerce

Este projeto tem como objetivo desenvolver uma plataforma de e-commerce para a venda de produtos diversos.
O sistema permite o cadastro de produtos, clientes, fornecedores e a realização de pedidos.

**Esquema Conceitual:**

    O sistema é baseado em um modelo de dados relacional, com as seguintes entidades principais:
    
    * **Cliente:** O cliente pode se cadastrar com seu CPF ou CNPJ. Um cliente pode cadastrar 
    mais de um endereço e ter mais de uma forma de pagamento.
    * **Produto:** Representa os itens disponíveis para venda. Cada produto é vinculado a um 
    fornecedor e pode estar associado a diferentes pedidos.
    * **Pedido:** Representa as compras realizadas pelos clientes. Um pedido pode incluir 
    múltiplos produtos e é associado a um cliente, com informações de status, descrição e frete.
    * **Fornecedor:** Representa os fornecedores de produtos disponíveis. Detalhes como Razão Sozial e CNPJ.
    * **Estoque:** Representa o controle de quantidade e local.
 

**Funcionalidades:**

    Cadastro de produtos: Cadastro de produtos com informações detalhadas, como categoria, descrição e valor.
    Cadastro de clientes: Cadastro de clientes com informações de nome, identificação, endereço e tipo de cliente (PF ou PJ).
    Finalização de pedidos: Escolha da forma de pagamento, confirmação do endereço de entrega e geração do pedido.
    Acompanhamento de pedidos: O cliente pode acompanhar o status do seu pedido.

**Relações:**

   * Um cliente pode fazer muitos pedidos.
   * Um pedido pode conter um ou mais produtos.
   * Um produto pode estar em muitos pedidos.
   * Um produto é fornecido por um fornecedor.
   * Um fornecedor pode fornecer muitos produtos.
   * Um produto está associado a um estoque específico.
   * Um pedido pode ter um ou mais pagamentos

**Tecnologias Utilizadas:**

   * Banco de dados: MySQL Workbench

**Objetivo:**

O objetivo principal do sistema de E-commerce é automatizar os processos de vendas online, desde o cadastro de clientes e produtos até o gerenciamento de pedidos e controle de estoque. Além disso, o sistema visa proporcionar uma experiência otimizada para clientes e fornecedores, garantindo eficiência na gestão de pagamentos, entregas e rastreamento de pedidos.
