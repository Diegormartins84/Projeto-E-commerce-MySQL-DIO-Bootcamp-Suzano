-- Inserção de dados e queries

use ecommerce;
show tables;
-- idClient, Fname, Minit, Lname, CPF, Address
insert into Clients(Fname, Minit, Lname, CPF, Address)
values
	('Maria','M','Silva',12346789,'rua silva de prata 29','Carangola - Cidade das flores'),
	('Matheus','O','Pimentel',987654321,'rua alemeda 289','Centro - Cidade das flores'),
    ('Ricardo','F','Silva',45678913,'avenida alemeda vinha 1009','Centro - Cidade das flores'),
    ('Julia','S','França',789123456,'rua lareijras 861','Centro - Cidade das flores'),
    ('Roberta','G','Assis',98745631,'Avenida de Koller 19','Centro - Cidade das flores'),
    ('Isabela','M','Cruz',654789123,'Rua Alameda das Flores 28','Centro - Cidade das flores')
;
desc product;
-- idProduct, Pname, Classification_kids, Category, Avaliação, Size
insert into Product(Pname, Classification_kids, Category, Avaliação, Size)
	values
		('Fone de ouvido',false,'Eletrônico','4',null),
        ('Barbie Elsa',true,'Brinquedos','3',null),
		('Body Carters',true,'Vestimenta','5',null),
        ('Microfone Vedo - Youtuber',false,'Eletrônico','4',null),
        ('Sofá retrátil',false,'Móveis','3','3x57x80)
;