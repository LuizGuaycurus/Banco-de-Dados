create database oficina;

use oficina;

create table cliente(
	cod_clien smallint not null primary key,
	nome varchar (60) not null,
	endereco varchar (80) not null,
	cidade varchar (80) not null,
	telefone varchar (20) not null
);

create table peca(
	cod_peca smallint not null primary key,
	nome varchar (40) not null,
	preco int (20) not null,
	quant int (20) not null
);

create table veiculo(
	placa varchar (8) not null primary key,
	ano varchar (5) not null,
	cor varchar (10) not null,
	marca varchar (20) not null,
    modelo varchar (20) not null,
	descri varchar (80) not null,
	cod_clien smallint not null,
	foreign key (cod_clien) references cliente (cod_clien)
);
												
create table servico(
	cod_serv smallint not null primary key,
    cod_clien smallint not null,
    cod_peca smallint not null,
	placa varchar (8) not null,
	dataentrada varchar (50) not null,
	foreign key (cod_clien) references cliente (cod_clien),
	foreign key (cod_peca) references peca (cod_peca),
	foreign key (placa) references veiculo (placa)
);

CREATE TABLE mao_de_obra (
    cod_mao smallint not null primary key,
    hora_trab varchar(50) not null,
    especi varchar(20) not null,
    cod_serv smallint not null,
    preco int not null,
    foreign key (cod_serv) references servico (cod_serv)
);

Create table executa(
cod_exe smallint not null primary key,
cod_mao smallint not null,
cod_serv smallint not null,
foreign key (cod_serv) references servico (cod_serv),
foreign key (cod_mao) references mao_de_obra (cod_mao));			
												 
Create table usa(
codusa smallint not null primary key,
cod_peca smallint not null,
cod_serv smallint not null,
foreign key (cod_serv) references servico (cod_serv),
foreign key (cod_peca) references peca (cod_peca));															 
											  

insert into cliente(cod_clien,nome,endereco,cidade,telefone) values 
(1,'Luiz','Rua: Professor Filgueira, nº17','Jaquarepaguá','(21)3659-5046'),
(2,'Cleison','Rua: Cordura ,nº698','Ipanema','(21)2369-5541'),
(3,'Messi','Rua: Carmela Dutra,nº 698','Barcelona','(21)99955-2222');

insert into peca(cod_peca,nome,preco,quant) values 
(1,'Cano de descarga',150,8),
(2,'Roda',200,6),
(3,'Mola',800,30);

insert into veiculo (placa,ano,cor,marca,modelo,descri,cod_clien) values 
('FIT-3863','2017','Preta','Mercedes-benz','Mercedes-AMG G 63','Cano de descarga furado',1),
('luw-5554','2017','Branco','Fiat','Palio','Roda quebrada',3),
('KAT-5534','2016','Cinza','Wolkswagen','Passat','Painel ruim',2);

insert into servico (cod_serv,cod_clien,cod_peca,placa,dataentrada) values
(100,2,1,'KAT-5534','01/01/2019'),
(103,1,3,'FIT-3863','22/01/2019'),
(105,3,2,'luw-5554','04/02/2019');

insert into mao_de_obra (cod_mao,hora_trab,especi,cod_serv,preco) values
 (024,'5hrs','mecanico',100,50),
 (025,'10hrs','lanterneiro',103,150),
 (026,'3hrs','mecanico',105,200);
 
 insert into executa (cod_exe,cod_mao,cod_serv) values
(78,'024','100'),
(79,'025','103'),
(80,'026','105');

insert into usa (codusa,cod_peca,cod_serv) values
(81,1,100),
(91,2,103),
(100,3,105);

select * from peca;
Select * from peca where nome like 'M%';

select * from cliente where nome like 'M%';

select especi from mao_de_obra,servico where servico.dataentrada between '10/05/2018' and '22/12/2018';

Select * from peca where nome like '%de%';

Select * from peca where cod_peca in(1,3);

select * from peca where cod_peca between 1 and 3;

select * from servico where cod_serv in (100,105);

select especi from mao_de_obra where preco between 50 and 150;

/*5) Mostrar código do serviço e defeito de todos os atendimentos do veiculo placa luw5554.*/

select servico.cod_serv, descri from servico,veiculo where veiculo.placa like 'luw-5554%';





/*1*/ select nome, endereco from cliente;

/*2*/ select nome , endereco from cliente where cidade = 'Jaquarepaguá';

/*3*/ select nome ,  endereco , telefone , placa , modelo , marca from cliente,veiculo;

/*4 select nome, telefone, veiculo.placa from cliente, veiculo, servico where cliente.cod_clien = veiculo.cod_clien and cod_serv = 1056;*/
		
        select c.nome, c.telefone , v.placa from veiculo v inner join servico s on v.placa = s.placa
        inner join cliente c on c.cod_clien = v.cod_clien and s.cod_serv = 1056 ;
        
/*5*/ select peca.nome from peca,servico where servico.cod_peca = peca.cod_peca and cod_serv = 1001;

/*6 select mao_de_obra.cod_serv, servico.cod_peca from servico, mao_de_obra where mao_de_obra.cod_serv = servico.cod_serv and veiculo.placa ='LUW-5567';*/
select mao_de_obra.cod_mao,peca.nome,servico.placa,servico.dataentrada
   from mao_de_obra,peca,servico,veiculo
   where servico.placa = 'LUW-5567'
   and servico.dataentrada = '10/05/2018';
   
/*7*/select sum(quant) from peca;

/*8*/select avg(preco) from peca;

/*10*/select nome from peca where quant < 10; 

/*11 Mostrar o nome e telefone de todos os clientes que possuem carro do ano 2014.*/

select c.nome, c.telefone from cliente c inner join veiculo v on c.cod_clien = v.cod_clien and v.ano = '2016';

/*12*/select especi from mao_de_obra where cod_serv = 1056;

/*13-  Mostrar o nome e telefone de todos os clientes que entraram com o carro para serviço no dia 15/01/2019.*/


/*14*/ 

/*15*/
/*1) consultar nome e endereço de todos os clientes        OK

2) consultar nome e endereço de todos os clientes que moram em jacarepagua   OK

3)consultar nome dos clientes,telefone,placa do 
veiculo, modelo e marca.

4) consultar nome,telefone e placa do veiculo do 
cliente do serviço código 100.

5)Nome de todas as peças usadas na ordem
de serviço número 1001

6)consultar quais foram os serviços executados(mão obra)
e as peças utilizadas no veículo placa luw5567
no dia 10/05/2018.

7) Mostrar a soma atualizada das peças do estoque.

8) Mostrar a média de preço das peças do estoque

9)Mostrar o maior valor de mão de obra da oficina por especialidade.
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
10)Mostrar o nome de todas as peças com quantidade em estoque menor que 10.

11) Mostrar o nome e telefone de todos os clientes que possuem carro do ano 2014.

12) Mostrar o nome de todos os profissionais que trabalharam no serviço código 234.

13) Mostrar o nome e telefone de todos os clientes que entraram com o carro para serviço no dia 15/01/2019.

14)Mostrar o nome e telefone de todos os proprietários de carros marca Nissam.

15)Placa de todos os veículos que realizaram serviço da especialidade "lanternagem".


*/

drop database oficina;


