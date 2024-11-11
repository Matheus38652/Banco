DELIMITER $$

CREATE TRIGGER SaldoNulo
AFTER UPDATE ON Contas
FOR EACH ROW
BEGIN
    IF NEW.Saldo < OLD.Saldo THEN
        IF NEW.Saldo < 0 THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Saldo insuficiente para realizar o saque';
        END IF;
    END IF;
END$$


CREATE TRIGGER PosDeposito
AFTER UPDATE ON Contas
FOR EACH ROW
BEGIN
    IF NEW.TipoOperacao = 'deposito' THEN
        INSERT INTO Transacoes (ValorTransacao, DataTransacao, ContaOrigem, ContaDestino, Conta_idConta)
        VALUES (NEW.Saldo - OLD.Saldo, NOW(), NEW.IDConta, NEW.IDConta, NEW.IDConta);
    END IF;
END$$

CREATE TRIGGER PosSaque
AFTER UPDATE ON Contas
FOR EACH ROW
BEGIN
    IF NEW.T = 'saque' THEN
        INSERT INTO Transacoes (ValorTransacao, DataTransacao, ContaOrigem, ContaDestino, Conta_idConta)
        VALUES (OLD.Saldo - NEW.Saldo, NOW(), NEW.IDConta, NEW.IDConta, NEW.IDConta);
    END IF;
END$$

CREATE TRIGGER PosTransferir
AFTER UPDATE ON Contas
FOR EACH ROW
BEGIN
    IF NEW.TipoOperacao = 'transferencia' THEN
        INSERT INTO Transacoes (ValorTransacao, DataTransacao, ContaOrigem, ContaDestino, Conta_idConta)
        VALUES (NEW.Saldo - OLD.Saldo, NOW(), OLD.IDConta, NEW.IDConta, OLD.IDConta);
    END IF;
END$$


CREATE TRIGGER DepoisDaTransacao
AFTER INSERT ON Transacoes
FOR EACH ROW
BEGIN
    INSERT INTO HistoricoTran (Data, Hist_idConta, Hist_idCliente)
    VALUES (NEW.DataTransacao, NEW.ContaOrigem, NEW.Conta_idConta);
END$$

DELIMITER ;

drop trigger saldonulo;
