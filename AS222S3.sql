Use master;

-- Eliminar la base de datos si existe
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'AS222S3')
BEGIN
    DROP DATABASE AS222S3;
END

CREATE DATABASE AS222S3;
USE AS222S3;

-- tables
-- Table: Areas
CREATE TABLE Areas (
    ID int  NOT NULL,
    area_name varchar(80)  NOT NULL,
    Surnames varchar(80)  NOT NULL,
    Names varchar(80)  NOT NULL,
    CONSTRAINT Areas_pk PRIMARY KEY  (ID)
);

-- Table: Depreciation
CREATE TABLE Depreciation (
    depreciation_id int  NOT NULL,
    Annual int  NOT NULL,
    Descripcion varchar(100)  NOT NULL,
    Estate_code int  NOT NULL,
    CONSTRAINT Depreciation_pk PRIMARY KEY  (depreciation_id)
);

-- Table: Estate
CREATE TABLE Estate (
    code int  NOT NULL,
    Goods_detail varchar(60)  NOT NULL,
    book_value int  NOT NULL,
    Admission_date date  NOT NULL,
    depreciation_date date  NOT NULL,
    Annual_depreciation decimal(8,2)  NOT NULL,
    Monthly_Depreciation decimal(8,2)  NOT NULL,
    Accumulated_depreciation decimal(8,2)  NOT NULL,
    Amount int  NOT NULL,
    State char(4)  NOT NULL,
    Areas_ID int  NOT NULL,
    CONSTRAINT Estate_pk PRIMARY KEY  (code)
);

-- foreign keys
-- Reference: Depreciation_Estate (table: Depreciation)
ALTER TABLE Depreciation ADD CONSTRAINT Depreciation_Estate
    FOREIGN KEY (Estate_code)
    REFERENCES Estate (code);

-- Reference: Estate_Areas (table: Estate)
ALTER TABLE Estate ADD CONSTRAINT Estate_Areas
    FOREIGN KEY (Areas_ID)
    REFERENCES Areas (ID);

-- End of file.



-- Insert into Areas table
INSERT INTO Areas (ID, area_name, Surnames, Names) VALUES
(1, 'Area 1', 'Surname1', 'Name1'),
(2, 'Area 2', 'Surname2', 'Name2'),
(3, 'Area 3', 'Surname3', 'Name3'),
(4, 'Area 4', 'Surname4', 'Name4'),
(5, 'Area 5', 'Surname5', 'Name5');

-- Insert into Depreciation table with existing Estate_code values
INSERT INTO Depreciation (depreciation_id, Annual, Descripcion, Estate_code) VALUES
(1, 1000, 'Description 1', 101),
(2, 1500, 'Description 2', 102),
(3, 1200, 'Description 3', 103),
(4, 1300, 'Description 4', 104),
(5, 1100, 'Description 5', 105);

-- Insert into Estate table
INSERT INTO Estate (code, Goods_detail, book_value, Admission_date, depreciation_date, Annual_depreciation, Monthly_Depreciation, Accumulated_depreciation, Amount, State, Areas_ID) VALUES
(101, 'Detail 1', 5000, '2023-01-01', '2023-12-31', 1000.00, 83.33, 500.00, 6000, 'ACTV', 1),
(102, 'Detail 2', 6000, '2023-02-01', '2023-12-31', 1500.00, 125.00, 600.00, 7000, 'ACTV', 2),
(103, 'Detail 3', 7000, '2023-03-01', '2023-12-31', 1200.00, 100.00, 700.00, 8000, 'ACTV', 3),
(104, 'Detail 4', 8000, '2023-04-01', '2023-12-31', 1300.00, 108.33, 800.00, 9000, 'ACTV', 4),
(105, 'Detail 5', 9000, '2023-05-01', '2023-12-31', 1100.00, 91.67, 900.00, 10000, 'ACTV', 5);

-- Ver registros de la tabla Areas
SELECT * FROM Areas;

-- Ver registros de la tabla Depreciation
SELECT * FROM Depreciation;

-- Ver registros de la tabla Estate
SELECT * FROM Estate;

-- Agregar restricciones a la tabla Areas
ALTER TABLE Areas
ADD CONSTRAINT area_name_unique UNIQUE (area_name);

-- Agregar restricciones a la tabla Depreciation
ALTER TABLE Depreciation
ADD CONSTRAINT Annual_positive CHECK (Annual > 0);

-- Agregar restricciones a la tabla Estate
ALTER TABLE Estate
ADD CONSTRAINT book_value_positive CHECK (book_value > 0);

-- Consulta con WHERE
SELECT * FROM Estate WHERE book_value > 6000;

-- Ejemplo de programación en SQL (procedimiento almacenado)
CREATE PROCEDURE UpdateDepreciation
AS
BEGIN
    UPDATE Depreciation
    SET Annual = Annual * 1.1
    WHERE depreciation_id < 4;
END;

-- Ejemplo de cursor en SQL
DECLARE @EstateCode INT;
DECLARE estate_cursor CURSOR FOR
SELECT code FROM Estate;

OPEN estate_cursor;

FETCH NEXT FROM estate_cursor INTO @EstateCode;
WHILE @@FETCH_STATUS = 0
BEGIN
    -- Realizar operaciones con @EstateCode
    FETCH NEXT FROM estate_cursor INTO @EstateCode;
END

CLOSE estate_cursor;
DEALLOCATE estate_cursor;

EXEC UpdateDepreciation;

-- Declaración del cursor
DECLARE @EstateCode INT;
DECLARE estate_cursor CURSOR FOR
SELECT code FROM Estate;

-- Apertura del cursor
OPEN estate_cursor;

-- Recorrido y consulta con join
FETCH NEXT FROM estate_cursor INTO @EstateCode;
WHILE @@FETCH_STATUS = 0
BEGIN
    SELECT E.code, E.Goods_detail, D.Annual
    FROM Estate E
    INNER JOIN Depreciation D ON E.code = D.Estate_code
    WHERE E.code = @EstateCode;

    FETCH NEXT FROM estate_cursor INTO @EstateCode;
END

-- Cierre y liberación del cursor
CLOSE estate_cursor;
DEALLOCATE estate_cursor;


-- Declaración del cursor con estructura condicional IF
DECLARE @EstateCode INT;
DECLARE @ThresholdValue INT = 7000;
DECLARE estate_cursor CURSOR FOR
SELECT code FROM Estate;

-- Apertura del cursor
OPEN estate_cursor;

-- Recorrido condicional con IF
FETCH NEXT FROM estate_cursor INTO @EstateCode;
WHILE @@FETCH_STATUS = 0
BEGIN
    IF (SELECT book_value FROM Estate WHERE code = @EstateCode) > @ThresholdValue
    BEGIN
        PRINT 'Estate with code ' + CAST(@EstateCode AS NVARCHAR(10)) + ' has a book value greater than ' + CAST(@ThresholdValue AS NVARCHAR(10));
    END

    FETCH NEXT FROM estate_cursor INTO @EstateCode;
END

-- Cierre y liberación del cursor
CLOSE estate_cursor;
DEALLOCATE estate_cursor;

