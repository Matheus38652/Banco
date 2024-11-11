DELIMITER $$

CREATE PROCEDURE Depositar(
    IN p_ContaID INT,
    IN p_Valor DECIMAL(10,2)
)
BEGIN

	SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
    START TRANSACTION;
    UPDATE Contas
    SET Saldo = Saldo + p_Valor,
        TipoOperacao = 'deposito'
    WHERE IDConta = p_ContaID;
    COMMIT;
    
    UPDATE Contas
	SET TipoOperacao = NULL
	WHERE IDConta = p_ContaID;
END$$

CREATE PROCEDURE Sacar(
    IN p_ContaID INT,
    IN p_Valor DECIMAL(10,2)
)
BEGIN
    DECLARE p_SaldoAtual DECIMAL(10,2);
    
    SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
    START TRANSACTION;
    SELECT Saldo INTO p_SaldoAtual FROM Contas WHERE IDConta = p_ContaID;

    IF p_SaldoAtual >= p_Valor THEN
        UPDATE Contas
        SET Saldo = Saldo - p_Valor,
            TipoOperacao = 'saque'
        WHERE IDConta = p_ContaID;
        COMMIT;
        
    ELSE
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Saldo insuficiente';
    END IF;
    
    UPDATE Contas
	SET TipoOperacao = NULL
	WHERE IDConta = p_ContaID;
END$$

CREATE PROCEDURE Transferir(
    IN p_ContaOrigem INT,
    IN p_ContaDestino INT,
    IN p_Valor DECIMAL(10,2)
)
BEGIN
    DECLARE p_SaldoOrigem DECIMAL(10,2);
    DECLARE p_DataTransacao DATETIME;
    DECLARE p_ContaDestinoExists INT;

    SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
    SET p_DataTransacao = NOW();

    START TRANSACTION;

    SELECT COUNT(*) INTO p_ContaDestinoExists FROM Contas WHERE IDConta = p_ContaDestino;
    
    IF p_ContaDestinoExists = 0 THEN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Conta inexistente';
    ELSE

        SELECT Saldo INTO p_SaldoOrigem FROM Contas WHERE IDConta = p_ContaOrigem;

        IF p_SaldoOrigem >= p_Valor THEN

            UPDATE Contas
            SET Saldo = Saldo - p_Valor
            WHERE IDConta = p_ContaOrigem;

            UPDATE Contas
            SET Saldo = Saldo + p_Valor
            WHERE IDConta = p_ContaDestino;

            INSERT INTO Transacoes (ValorTransacao, DataTransacao, ContaOrigem, ContaDestino, Conta_idConta)
            VALUES (p_Valor, p_DataTransacao, p_ContaOrigem, p_ContaDestino, p_ContaOrigem);

        ELSE
            ROLLBACK;
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Saldo insuficiente';
        END IF;
    END IF;
END$$

CREATE PROCEDURE ConsultarSaldo(
    IN p_ContaID INT
)
BEGIN
    SELECT Saldo FROM Contas WHERE IDConta = p_ContaID;
END$$


DELIMITER $$

CREATE PROCEDURE RealizarEmprestimo(
    IN p_ContaID INT,
    IN p_ClienteID INT,
    IN p_Valor DECIMAL(10,2),
    IN p_TaxaJuro FLOAT
)
BEGIN
    DECLARE p_DataEmp DATETIME;
    DECLARE p_ContaExists INT;
    DECLARE p_ClienteExists INT;
    DECLARE p_ProprietarioExists INT;

    SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
    SET p_DataEmp = NOW();

    START TRANSACTION;

    SELECT COUNT(*) INTO p_ContaExists FROM Contas WHERE IDConta = p_ContaID;

    SELECT COUNT(*) INTO p_ClienteExists FROM Cliente WHERE idCliente = p_ClienteID;

    SELECT COUNT(*) INTO p_ProprietarioExists FROM Contas WHERE IDConta = p_ContaID AND Conta_idCliente = p_ClienteID;

    IF p_ContaExists = 0 THEN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Conta inexistente';
    ELSEIF p_ClienteExists = 0 THEN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cliente inexistente';
    ELSEIF p_ProprietarioExists = 0 THEN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cliente não é o proprietário da conta';
    ELSE
        INSERT INTO Emprestimo (Valor, DataEmp, TaxaJuro, Emp_idConta, Emp_idCliente)
        VALUES (p_Valor, p_DataEmp, p_TaxaJuro, p_ContaID, p_ClienteID);

        UPDATE Contas
        SET Saldo = Saldo + p_Valor
        WHERE IDConta = p_ContaID;

        COMMIT;
    END IF;
END$$

DELIMITER ;


DELIMITER ;

drop procedure realizaremprestimo;