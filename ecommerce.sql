-- BD com cenario de E-commerce
-- create database ecommerce;
-- use ecommerce;
-- show tables;

-- criar tabela cliente

create table clients(
	idClient int auto_increment primary key,
    Fname varchar (10),
    Minit char(3),
    Lname varchar(20),
    CPF char (11) not null,
    Address varchar(40),
	constraint unique_cpf_client unique(CPF)
    );
    
create table product(
	idproduto int auto_increment primary key,
    Pname varchar (10),
    classification_kids bool,
	category enum('Eletronicos', 'Vestimenta', 'Brinquedos', 'Alimentos', 'Moveis') not null,
    avaliacao float default 0,
    size varchar(10)    
);

create table payment(
	idclient int primary key,
    id_payment int auto_increment,
    Value float,
	type_payment enum ('Boleto', 'PIX', 'credito', 'debito'),
    payment_made boolean default false,
    primary key(idclient, idpayment)
);

create table orders(
idOrder int auto_increment primary key,
idOrderClient int,
orderStatus enum('cancelado', 'confirmado', 'em processamento') not null default 'em processamento',
orderDescription varchar(255),
sendValue float default 10,
constraint fk_order_clent foreign key(idOrderClient) references clients(idClient)
);

create table productstorage(
idProductStorage int auto_increment primary key,
categoria enum('brinquedo', 'alimento', 'eletronicos', 'outros') not null default 'outros',
locationn varchar(255),
quanty float default 0,
payment_value float not null
);

create table supplier(  
idSupplier int auto_increment primary key,
socialName varchar(255) not null,
document enum('CPF', 'CNPJ') not null,
documentNumber varchar(15) unique,
contactNumber varchar(11),
contactEmail varchar (40) not null
);

create table seller(  
idSeller int auto_increment primary key,
socialName varchar(255) not null,
document enum('CPF', 'CNPJ') not null,
documentNumber varchar(15) unique,
contactNumber varchar(11),
contactEmail varchar (40) not null
);

create table productSeller (
idPseller int,
idProduct int,
productQuality int default 1,
primary key (idPseller, idPproduct),
constraint fk_product_product foreign key(idPproduct) references product(idProduct)
);

create table productOrder(
idPOproduct int,
idPOorder int,
poQuality int default 1,
poStatus enum('disponivel', 'Sem estoque') default 'sem estoque',
primary key (idPOproduct, idPOorder),
constraint fk_productorder_product foreign key(idPOorder) references product(idProduct),
constraint fk_productorder_product foreign key(idPOorder) references orders(idOrder)
);

create table storageLocation(
idLproduct int,
idLstorage int,
location varchar(255) not null,
primary key (idLproduct, idLstorage),
constraint fk_storage_location_product foreign key(idLproduct) references product(idProduct),
constraint fk_storage_location_storage foreign key(idLstorage) references productstorage(idProductStorage)
