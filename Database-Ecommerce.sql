-- Criação do Banco de Dados para o cenário de E-commerce
-- drop database ecommerce;
show databases;
create database if not exists ecommerce;
use ecommerce;

-- Criar tabela Cliente
create table Clients(
	IdClient int auto_increment primary key,
    Fname varchar(10),
    Minit char(3),
    Lname varchar(20),
    CPF char(11) not null,
    Address varchar(255),
	constraint unique_cpf_client unique (CPF)
);
alter table Clients auto_increment = 1;
-- desc Clients;

-- Criar tabela Produto
-- Size = dimensão do produto
create table Product(
	IdProduct int auto_increment primary key,
    Pname varchar(50) not null,
    Classification_kids bool default false,
    Category enum('Eletrônico','Vestimenta','Brinquedos','Alimentos','Móveis') not null,
    Avaliação float default 0,
    Size varchar(20)
);
alter table Product auto_increment = 1;
-- desc product;

-- para ser continuado no desafio: termine de  implementar a tabela e crie a conexão com as tabelas necessárias
-- além disso, reflita essa modificação no diagrama esquema relacional
-- criar constraints relacionada ao pagamento


create table Payments(
IdClient int,
IdPayment int,
TypePayment enum('Boleto','Cartão','Dois cartões'),
LimitAvaible float,
primary key (IdClient, IdPayment)
);


-- Criar tabela Pedido
-- drop table orders;
create table Orders(
	IdOrder int auto_increment primary key,
    IdOrderClient int ,
    OrderStatus enum('Cancelado','Confirmado','Em processamento') default 'Em processamento',
    OrderDescription varchar(255),
    SendValue float default 10,
    PaymentCash boolean default false,
    -- IdPayment vai ser uma foreign key
    constraint fk_orders_client foreign key (IdOrderClient) references Clients(IdClient)
		on update cascade ## todas as tabelas relacionadas a essa foreign key serão atualizadas
);
alter table Orders auto_increment = 1;
-- desc orders;

-- Criar tabela estoque

create table productStorage(
	IdProdStorage int auto_increment primary key,
    Location varchar (255),
    Quantity int default 0
);
alter table productStorage auto_increment = 1;

-- Criar tabela fornecedor
create table Supplier(
	IdSupplier int auto_increment primary key,
    SocialName varchar (255) not null,
    CNPJ varchar (15) not null,
    Contact char (11) not null,
    constraint unique_supplier unique (CNPJ)
);
alter table Supplier auto_increment = 1;
-- desc Supplier;

-- Criar tabela vendedor
-- dica de melhoramento (modelo refinado), separar CPF e CNPJ

create table Seller(
	IdSeller int auto_increment primary key,
    SocialName varchar (255) not null,
    AbstName varchar (255),
    CNPJ varchar (15),
    CPF char (11),
    Location varchar (255),
    Contact char (11) not null,
    constraint unique_cnpj_supplier unique (CNPJ),
    constraint unique_cpf_supplier unique (CPF)
);
alter table Seller auto_increment = 1;
-- desc Seller;

-- Produto vendedor

create table productSeller(
	idPseller int ,
    idPproduct int ,
	prodQuantity int default 1,
    primary key (IdPseller, idPproduct),
    constraint fk_product_seller foreign key (idPseller) references Seller(IdSeller),
    constraint fk_product_product foreign key (idPproduct) references Product(IdProduct)
);
-- desc productSeller;

create table ProductOrder(
	idPOproduct int,
    idPOorder int,
    poQuantity int default 1,
    poStatus enum('Disponível','Em estoque') default 'Disponível',
    primary key (idPOproduct, idPOorder),
	constraint fk_product_order_product foreign key (idPOproduct) references Product(idProduct),
    constraint fk_product_order_order foreign key (idPOorder) references Orders(idOrder)
);
-- drop table productorder;

create table StorageLocation(
	idLproduct int,
    idLstorage int,
    location varchar(255) not null,
    primary key (idLproduct, idLstorage),
    constraint fk_storage_location_product foreign key (idLproduct) references Product(idProduct),
    constraint fk_storage_location_storage foreign key (idLstorage) references productStorage(IdProdStorage)
);

create table productSupplier(
	idPsSupplier int,
    idPsProduct int,
    Quantity int not null,
    primary key (idPsSupplier, idPsProduct),
    constraint fk_product_supplier_supplier foreign key (idPsSupplier) references Supplier(IdSupplier),
    constraint fk_product_supplier_product foreign key (idPsProduct) references Product(IdProduct)
);
-- desc productSupplier;

use ecommerce;
show tables;
use information_schema;
show tables;
desc table_constraints;
desc REFERENTIAL_CONSTRAINTS;
select * from REFERENTIAL_CONSTRAINTS where constraint_schema = 'ecommerce';
