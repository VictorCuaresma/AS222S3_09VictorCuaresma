-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2023-12-17 19:49:56.914

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

