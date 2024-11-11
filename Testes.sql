use gmg;

insert into cliente (idCliente, Nome, CPF, Idade, RG, Nascimento, EstadoCivil, Nacionalidade, Endereco) values (1,"Matheus da Silva Santos",36596803899,20,52319322,20040309,"Solteiro","Brasileiro");
insert into cliente (idCliente, Nome, CPF, Idade, RG, Nascimento, EstadoCivil, Nacionalidade) values (2,"Guilherme Dias",365121233,25,52334552,20000712,"Casado","Brasileiro");
insert into cliente (idCliente, Nome, CPF, Idade, RG, Nascimento, EstadoCivil, Nacionalidade) values (3,"Gustavo Dias",523234173,21,52334552,20010712,"Namorando","Brasileiro");
insert into cliente (idCliente, Nome, CPF, Idade, RG, Nascimento, EstadoCivil, Nacionalidade) values (4,"Junior Paes",52312123488,23,5233455266,20020622,"Solteiro","Brasileiro");

insert into contas (Agencia, Numero, TipoConta, Saldo, DataAbertura, Conta_idCliente) values (22,2323,"Salario",0.0,20241109,1);
insert into contas (Agencia, Numero, TipoConta, Saldo, DataAbertura, Conta_idCliente) values (22,5433,"Salario",0.0,20241109,2);
insert into contas (Agencia, Numero, TipoConta, Saldo, DataAbertura, Conta_idCliente) values (22,5433,"Poupanca",0.0,20241109,2);
insert into contas (Agencia, Numero, TipoConta, Saldo, DataAbertura, Conta_idCliente) values (22,8923,"Poupanca",0.0,20241109,3);
insert into contas (Agencia, Numero, TipoConta, Saldo, DataAbertura, Conta_idCliente) values (22,8923,"Poupanca",0.0,20241109,4);

update contas set saldo = saldo - 5000 where idconta = 2;

select * from cliente;
select * from transacoes;
select * from historicotran;
select * from emprestimo;
select * from contas;

call Depositar(2,330.00);
call Sacar(2,5000.00);
call Transferir(4,1,200.00);
call ConsultarSaldo(3);
call RealizarEmprestimo(4,2,2000.00,0.02);

commit;
rollback;
