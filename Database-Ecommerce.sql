-- Criação do Banco de Dados para o cenário de E-commerce

create database ecommerce;
use ecommerce;

-- Criar tabela Cliente
create table Clients(
	IdClient int auto_increment primary key,
    Fame varchar(10),
    Minit char(3),
    Lname varchar(20),
    CPF char(11) not null,
    Address varchar(30),
	constraint unique_cpf_client unique (CPF)
);

-- Criar tabela Produto

-- Size = dimensão do produto
create table Product(
	IdProduct int auto_increment primary key,
    Pame varchar(10) not null,
    Classification_kids bool default false,
    Category enum('Eletrônico','Vestimenta','Brinquedos','Alimentos','Móveis') not null,
    Avaliação float default 0,
    Size varchar(10)
    -- constraint unique_cpf_client unique (CPF)
);

-- para ser continuado no desafio: termine de  implementar a tabela e crie a conexão com as tabelas necessárias
-- além disso, reflita essa modificação no diagrama esquema relacional
-- criar constraints relacionada ao pagamento

create table Payments(
IdClient int primary key,
IdPayment int,
TypePayment enum('Boleto','Cartão','Dois cartões'),
LimitAvaible float,
primary key (IdClient, IdPayment)
);

-- Criar tabela Pedido

create table Orders(
	IdOrder int auto_increment primary key,
    IdOrderClient int ,
    OrderStatus enum('Cancelado', 'Confirmado', 'Em processamento') not null,
    OrderDescription varchar(255),
    SendValue float default 0,
    PaymentCash bool default false,
    -- IdPayment vai ser uma foreign key
    constraint fk_orders_client foreign key (IdOrderClient) references Clients(IdClient)
);

