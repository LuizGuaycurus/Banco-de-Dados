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
(2,'Cleison','Rua: Cordura ,nº698','Ipanema','(21)2369-5541');

insert into peca(cod_peca,nome,preco,quant) values 
(050,'Cano de descarga',150,8),
(060,'Painel',800,30);

insert into veiculo (placa,ano,cor,marca,modelo,descri,cod_clien) values 
('FIT-3863','2017','Preta','Mercedes-benz','Mercedes-AMG G 63','Cano de descarga furado',1),
('KAT-5534','2016','Cinza','Wolkswagen','Passat','Painel ruim',2);

insert into servico (cod_serv,cod_clien,cod_peca,placa,dataentrada) values
(1056,2,050,'KAT-5534','10/05/2018'),
(0057,1,060,'FIT-3863','22/12/2018');

insert into mao_de_obra (cod_mao,hora_trab,especi,cod_serv,preco) values
 (024,'5hrs','mecanico',1056,500),
 (025,'10hrs','lanterneiro',0057,600);
 
 insert into executa (cod_exe,cod_mao,cod_serv) values
(78,'024','1056'),
(79,'025','0057');

insert into usa (codusa,cod_peca,cod_serv) values
(81,050,1056),
(91,060,0057);

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

/*11*/select nome,telefone,modelo from cliente,veiculo where cliente.cod_clien = veiculo.cod_clien 
and veiculo.ano = '2016';

/*12*/select especi from mao_de_obra where cod_serv = 1056;

/*13-  Mostrar o nome e telefone de todos os clientes que entraram com o carro para serviço no dia 15/01/2019.*/

select nome,telefone, dataentrada from cliente,servico where servico.dataentrada = '10/05/2018';

/*14*/ select nome, telefone ,  modelo from veiculo, cliente where veiculo.modelo = 'Mercedes-AMG G 63';

/*15*/select placa from veiculo,servico, mao_de_obra where veiculo.placa = servico.placa and mao_de_obra.cod_serv = servico.cod_serv ;
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

