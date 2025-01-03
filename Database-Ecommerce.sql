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
    OrderStatus enum('Cancelado', 'Confirmado', 'Em processamento') default 'Em processamento',
    OrderDescription varchar(255),
    SendValue float default 0,
    PaymentCash bool default false,
    -- IdPayment vai ser uma foreign key
    constraint fk_orders_client foreign key (IdOrderClient) references Clients(IdClient)
);

-- Criar tabela estoque

create table productStorage(
	IdProdStorage int auto_increment primary key,
    Location varchar (255),
    Quantity int default 0
);

-- Criar tabela fornecedor
create table Supplier(
	IdSupplier int auto_increment primary key,
    SocialName varchar (255) not null,
    CNPJ varchar (15) not null,
    Contact char (11) not null,
    constraint unique_supplier unique (CNPJ)
);

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

-- Produto vendedor

create table productSeller(
	idPseller int ,
    idPproduct int ,
	prodQuantity int default 1,
    primary key (IdSeller, idProduct),
    constraint fk_product_seller foreign key (idPseller) references Seller(IdSeller),
    constraint fk_product_product foreign key (idPproduct) references Product(IdProduct)
);

create table ProductOrder(
	idPOproduct int,
    idPOorder int,
    poQuantity int default 1,
    poStatus enum('Disponível','Em estoque') default 'Disponível',
    primary key (idPOproduct, idPOorder),
	constraint fk_po_product foreign key (idPOproduct) references Product(idProduct),
    constraint fk_po_order foreign key (idPOorder) references Orders(idOrder)
);

create table StorageLocation(
	idLproduct int,
    idLstorage int,
    location varchar(255) not null,
    primary key (idLproduct, idLstorage),
    constraint fk_sl_product foreign key (idLproduct) references Product(idProduct),
    constraint fk_sl_order foreign key (idLstorage) references Orders(idOrders)
);

