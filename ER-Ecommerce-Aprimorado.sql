-- Criação do Banco de Dados para o cenário de E-commerce Aprimorado

-- drop database ecommerce_aprimorado;
show databases;
create database if not exists ecommerce_aprimorado;
use ecommerce_aprimorado;

-- Criar as tabelas ClientesPF e ClientesPJ
create table ClientPF (
	idClientPF int auto_increment primary key,
	Fname varchar(10),
    Minit char(3),
    Lname varchar(20),
    CPF char(11),
    Bdate date,
    Address varchar(255)
);
create table ClientPJ(
	idClientPJ int auto_increment primary key,
    CNPJ char(14),
    RazaoSocial varchar(50),
    Address varchar(255)
);

-- Criar tabela Cliente
create table Clients(
	IdClient int auto_increment primary key,
    idClientPJ int,
    idClientPF int,
    ClientType enum ('PF','PJ') not null,
    CONSTRAINT ck_tipo_cliente CHECK (
        (ClientType = 'PF' AND idClientPJ IS NULL) OR 
        (ClientType = 'PJ' AND idClientPF IS NULL) )
 );
alter table Clients auto_increment = 1;
alter table Clients
    add constraint fk_cliente_pf foreign key (idClientPF) references ClientPF(idClientPF),
    add constraint fk_cliente_pj foreign key (idClientPJ) references ClientPJ(idClientPJ);


-- select * from clients;
-- select * from clientpf;
-- select * from clientpj;
-- show tables;

-- Criar tabela Produto

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
	IdPayment int,
	IdClient int,
	PaymentType enum('Boleto','Cartão','Dois cartões','Pix'),
	LimitAvaible float,
    dadoscartao varchar(255),
    chavepix varchar(50),
    codigoboleto varchar(50),
	primary key (IdClient, IdPayment),
	constraint fk_payment_client foreign key (IdClient) references Clients(IdClient)
);
alter table Payments auto_increment = 1;
-- select * from payments;
-- drop table Payments;

-- Criar tabela Pedido

create table Orders(
	IdOrder int auto_increment primary key,
    IdOrderClient int,
    OrderStatus enum('Cancelado','Confirmado','Em processamento') default 'Em processamento',
    OrderDescription varchar(255),
    SendValue float default 10,
    PaymentCash boolean default false,
    constraint fk_orders_client foreign key (IdOrderClient) references Clients(IdClient)
		on update cascade ## todas as tabelas relacionadas a essa foreign key serão atualizadas
);
alter table Orders auto_increment = 1;

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

-- Criar tabela vendedor
-- dica de melhoramento (modelo refinado), separar CPF e CNPJ

create table Seller(
	IdSeller int auto_increment primary key,
    SocialName varchar (255) not null,
    AbstName varchar (255),
    CNPJ varchar (15),
    CPF char (11),
    SellerType enum ('PF','PJ') not null,
    Location varchar (255),
    Contact char (11) not null,
    constraint unique_cnpj_supplier unique (CNPJ),
    constraint unique_cpf_supplier unique (CPF),
	constraint ck_tipo_vendedor check (
		(SellerType = 'PF' and CNPJ is null) or 
		(SellerType = 'PJ' and CPF is null)
));
alter table Seller auto_increment = 1;

-- Produto vendedor

create table productSeller(
	idPseller int,
    idPproduct int,
	prodQuantity int default 1,
    primary key (IdPseller, idPproduct),
    constraint fk_product_seller foreign key (idPseller) references Seller(IdSeller),
    constraint fk_product_product foreign key (idPproduct) references Product(IdProduct)
);

-- Produto pedido

create table ProductOrder(
	idPOproduct int,
    idPOorder int,
    poQuantity int default 1,
    poStatus enum('Disponível','Em estoque') default 'Disponível',
    primary key (idPOproduct, idPOorder),
	constraint fk_product_order_product foreign key (idPOproduct) references Product(idProduct),
    constraint fk_product_order_order foreign key (idPOorder) references Orders(idOrder)
);

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

-- Criar tabela entrega

create table Entrega (
	idEntrega int auto_increment primary key,
    idOrder int,
    entregaStatus enum('Em preparação','Enviado','Entregue','Cancelado'),
    codigoRastreamento varchar(50),
    constraint fk_entrega_order foreign key (idOrder) references Orders(idOrder)
);
alter table Entrega auto_increment = 1;


/*
use ecommerce;
show tables;
use information_schema;
show tables;
desc table_constraints;
desc REFERENTIAL_CONSTRAINTS;
select * from REFERENTIAL_CONSTRAINTS where constraint_schema = 'ecommerce';
*/

-- Inserção de dados e queries

use ecommerce_aprimorado;
show tables;
-- idClient, Fname, Minit, Lname, CPF, Address
insert into ClientPF(Fname, Minit, Lname, CPF, Bdate, Address) values
	('Maria','M','Silva',12346789,'1984-01-05','rua silva de prata 29 , Carangola - Cidade das flores'),
	('Matheus','O','Pimentel',987654321,'1995-05-15','rua alemeda 289 , Centro - Cidade das flores'),
    ('Ricardo','F','Silva',45678913,'1986-07-20','avenida alemeda vinha 1009 , Centro - Cidade das flores'),
    ('Julia','S','França',789123456,'1998-09-30','rua lareijras 861 , Centro - Cidade das flores'),
    ('Roberta','G','Assis',98745631,'2001-12-01','Avenida de Koller 19 , Centro - Cidade das flores'),
    ('Isabela','M','Cruz',654789123,'2003-08-10','Rua Alameda das Flores 28 , Centro - Cidade das flores')
;

insert into ClientPJ(CNPJ,RazaoSocial,Address) values
	('12345678000110','Empresa A','Rua das Flores 123, Centro - Cidade das flores'),
    ('98765432000120','Empresa B','Avenida Brasil 456, Centro - Cidade das flores'),
    ('56789012000130','Empresa C','Rua Venezuelandia 1313, Vila Margarida - Cidade das flores'),
    ('23456789000140','Empresa D','Rua dos Jumencios 352, Bairro da Esperança - Cidade das flores')
;

insert into Clients(idClientPJ,idClientPF,ClientType) values
	(null,'1','PF'),
    (null,'2','PF'),
    (null,'3','PF'),
    (null,'4','PF'),
    (null,'5','PF'),
    (null,'6','PF'),
    ('1',null,'PJ'),
    ('2',null,'PJ'),
    ('3',null,'PJ'),
    ('4',null,'PJ')
;

desc product;
-- idProduct, Pname, Classification_kids, Category, Avaliação, Size
insert into Product(Pname, Classification_kids, Category, Avaliação, Size)
	values
		('Fone de ouvido',false,'Eletrônico','4',null),
        ('Barbie Elsa',true,'Brinquedos','3',null),
		('Body Carters',true,'Vestimenta','5',null),
        ('Microfone Vedo - Youtuber',false,'Eletrônico','4',null),
        ('Sofá retrátil',false,'Móveis','3','3x57x80'),
        ('Farinha de Arroz',false,'Alimentos','2',null),
        ('Fire Stick Amazon',false,'Eletrônico','3',null)
;
-- select * from product;

-- desc orders;
-- IdOrderClient,OrderStatus,OrderDescription,SendValue,PaymentCash

insert into Orders(IdOrderClient, OrderStatus, OrderDescription, SendValue, PaymentCash)
	values
    (1,default,'compra via aplicativo',null,1),
    (2,default,'compra via aplicativo',50,0),
    (3,'Confirmado',null,null,1),
    (4,default,'compra via web site',150,0),
    (2,default,'compra via aplicativo',null,1)
;
    
-- delete from orders where IdOrderClient in (1,2,3,4);
select * from clients;

desc productOrder;
-- idPOproduct,idPOorder,poQuantity,poStatus
insert into productOrder(idPOproduct,idPOorder,poQuantity,poStatus)
	values
    (1,5,2,null),
    (2,5,1,null),
    (3,6,1,null)
;
delete from productOrder where idPOproduct in (1,2,3);
/*	(1,1,2,null),
    (2,1,1,null),
    (3,2,1,null)*/
select * from productorder;

desc ProductStorage;
-- IdProdStorage,Location,Quantity
insert into ProductStorage (Location,Quantity)
	values
    ('Rio de Janeiro',1000),
    ('Rio de Janeiro',500),
    ('São Paulo',10),
    ('São Paulo',100),
    ('São Paulo',10),
    ('Brasília',60);

desc StorageLocation;
-- idLproduct,idLstorage,location
insert into StorageLocation(idLproduct,idLstorage,location)
	values
    (1,2,'RJ'),
    (1,6,'GO');

desc supplier;
-- IdSupplier,SocialName,CNPJ,Contact
insert into Supplier(SocialName,CNPJ,Contact)
	values
    ('Almeida e filhos',123456789123456,'21985474'),
    ('Eletrônicos Silva',854519649143457,'21985484'),
    ('Eletrônicos Valma',934567893934695,'21975474');
    
desc productSupplier;
-- idPsSupplier,idPsProduct,Quantity
insert into ProductSupplier(idPsSupplier,idPsProduct,Quantity)
	values
    (1,1,500),
    (1,2,400),
    (2,4,633),
    (3,3,5),
    (2,5,10);
    
desc Seller;
-- IdSeller,SocialName,AbstName,CNPJ,CPF,Location,Contact
insert into Seller(SocialName,AbstName,CNPJ,CPF,SellerType,Location,Contact)
	values
	('Tech eletronics',null,123456789456321,null,'PJ','Rio de Janeiro',219946287),
    ('Botique Durgas',null,null,123456783,'PF','Rio de Janeiro',219567895),
    ('Kids World',null,456789123654485,null,'PJ','São Paulo',1198657484);
-- select * from seller;
-- desc ProductSeller;
-- idPseller,idPproduct,prodQuantity
insert into ProductSeller(idPseller,idPproduct,prodQuantity)
	values
    (4,6,80),
    (5,7,10);

-- SET SESSION sql_mode = REPLACE(@@sql_mode, 'ONLY_FULL_GROUP_BY', '');

-- Quantos pedidos foram feitos por cada cliente?
select c.IdClient, COUNT(o.IdOrder) as TotalPedidos
from Clients c left join Orders o on c.IdClient = o.IdOrderClient
group by c.IdClient;

-- Algum vendedor também é fornecedor?
select s.SocialName from Seller s
join Supplier sp on s.CNPJ = sp.CNPJ;

-- Relação de produtos fornecedores e estoques;
select p.Pname,s.SocialName,ps.Quantity,st.Location from Product p
join productSupplier ps on p.IdProduct = ps.idPsProduct
join Supplier s on ps.idPsSupplier = s.IdSupplier
join StorageLocation sl on p.IdProduct = sl.idLproduct
join productStorage st on sl.idLstorage = st.IdProdStorage;

-- Relação de nomes dos fornecedores e nomes dos produtos
select s.SocialName,p.Pname from Supplier s
join productSupplier ps on s.IdSupplier = ps.idPsSupplier
join Product p on ps.idPsProduct = p.IdProduct;


-- 
-- Queries criadas para responder outras perguntas de negócios
-- 

-- Quais clientes pessoa física compraram produtos eletrônicos e brinquedos?
select cp.Fname, cp.Lname, p.Pname from ClientPF cp
join Clients c on cp.idClientPF = c.idClientPF
join Orders o on c.IdClient = o.IdOrderClient
join ProductOrder po on o.IdOrder = po.idPOorder
join Product p on po.idPOproduct = p.IdProduct
where p.Category in ('Eletrônico', 'Brinquedos');

-- Qual cliente pessoa física realizou o pedido de maior valor?
select cp.Fname, cp.Lname, max(o.SendValue) as MaiorValor
from ClientPF cp
join Clients c on cp.idClientPF = c.idClientPF
join Orders o on c.IdClient = o.IdOrderClient
group by cp.Fname, cp.Lname
order by MaiorValor desc;

-- Qual empresa realizou o maior número de pedidos?
select cpj.RazaoSocial, COUNT(*) as NumPedidos
from ClientPJ cpj
join Clients c on cpj.idClientPJ = c.idClientPJ
join Orders o on c.IdClient = o.IdOrderClient
group by cpj.RazaoSocial
order by NumPedidos desc;

-- Quais são os produtos vendidos por vendedores que não têm CNPJ?
select ps.idPproduct, p.Pname
from ProductSeller ps
join Product p on ps.idPproduct = p.IdProduct
where ps.idPseller in (
    select IdSeller
    from Seller
    where SellerType = 'PF'
);

-- Quais pedidos contêm produtos cuja quantidade disponível no armazenamento é maior que 100 unidades?
select po.idPOorder, po.idPOproduct, po.poQuantity
from ProductOrder po
where po.idPOproduct in (
    select idLproduct
    from StorageLocation sl
    join ProductStorage ps on sl.idLstorage = ps.IdProdStorage
    where ps.Quantity > 100
);

-- Quais clientes fizeram mais de 1 pedido?
select o.IdOrderClient, COUNT(o.IdOrder) as TotalPedidos from Orders o
group by o.IdOrderClient
having COUNT(o.IdOrder) > 1;



