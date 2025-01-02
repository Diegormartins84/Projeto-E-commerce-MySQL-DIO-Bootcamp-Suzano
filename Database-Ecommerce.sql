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
-- Criar tabela Pedido

create table Orders(
	IdOrder int auto_increment primary key,
    IdOrderClient int ,
    OrderStatus enum('Cancelado', 'Confirmado', 'Em processamento') not null,
    OrderDescription varchar(255),
    SendValue float default 0,
    constraint fk_orders_client foreign key (IdOrderClient) references Clients(IdClient)
);