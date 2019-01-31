create database oficina;

use oficina;

create table cep(
CEP varchar(20) not null primary key,
rua varchar (50) not null,
bairro varchar (50) not null,
cidade varchar (50) not null,
uf varchar (2) 
);

create table cliente(
cpf varchar(20) not null primary key,
nome varchar(60)not null,
CEP varchar (20) not null,
foreign key (CEP) references cep(CEP),
telefone varchar (20) not null
);

insert into cliente(cpf,nome,CEP,telefone)values
('555.666.111.20','Luiz','55555-20', '(21)99999-5454'),
('852.147.963-50','Cleison','66666-00','(21)88888-2345')
;

create table veiculo(
placa varchar(15) not null primary key,
modelo varchar (30) not null,
ano int not null,
marca varchar(40) not null
);

insert into veiculo(modelo,ano,marca) values
('LLZ-5060','Classe G Mercedes-AMG G 63','2018','Mercedez-Benz'),
('SLC-5000','SLC Roadster','2018','Mercedez-Benz');

create table servico(
codservico int not null primary key,
nome varchar(60)not null,
preco real not null,
precop real not null,
foreign key(precop) references pecas(precop)
);

create table mao_de_obra(
codmao_de_obra smallint not null primary key,
especialidade varchar(35) not null,
valor double not null);

insert into servico (nome, preco, precop) values
('Troca de pneu',80,200),
('Lanternagem',150,90);

create table pecas(
codpecas int not null primary key,
nome varchar(60)not null,
precop real not null
);



insert into pecas (nome,precop) values
('radiador',400),
('carburador',500);

create table executa(
serv_maodeobra varchar(20) primary key,
codservico int not null,
codmao_de_obra smallint not null,
foreign key (codservico) references servico(codservico),
foreign key (codmao_de_obra) references mao_de_obra(codmao_de_obra)
);

select*from pecas;

drop database oficina;