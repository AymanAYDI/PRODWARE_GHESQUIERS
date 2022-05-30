tableextension 60042 "PWD SalesReceivablesSetup" extends "Sales & Receivables Setup"
{
    fields
    {
        field(50000; "PWD Workbook for Russian Lables"; BLOB)
        {
            Caption = 'Workbook for Russian Lables';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(50001; "PWD Path xls File Export"; Text[250])
        {
            Caption = 'Path xls File Export';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(50002; "PWD Path xls File Import"; Text[250])
        {
            Caption = 'Path xls File Import';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(50003; "PWD Path xlt File"; Text[250])
        {
            Caption = 'Path xlt File';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(50004; "PWD Certif de cautionnement T1"; Code[50])
        {
            Caption = 'Certif de cautionnement T1';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(50005; "PWD Date du certificat T1"; Date)
        {
            Caption = 'Date du certificat T1';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(50006; "PWD Souche de T1"; Code[20])
        {
            Caption = 'Souche de T1';
            Description = 'PW2009';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(50007; "PWD Certif de cautionnement TM"; Code[50])
        {
            Caption = 'Certif de cautionnement TM';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(50008; "PWD Date du certificat TM"; Date)
        {
            Caption = 'Date du certificat TM';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(50009; "PWD Coef Controle prix unitaire"; Decimal)
        {
            Caption = 'Coef Contrôle prix unitaire';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(50010; "PWD DSA Location Filter"; Text[250])
        {
            Caption = 'DSA Filtre magasin';
            DataClassification = CustomerContent;
        }
        field(55001; "PWD Call No. Series"; Code[10])
        {
            Caption = 'Call No. Series';
            Description = 'PW2009';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(70060; "PWD Archive Quotes"; Boolean)
        {
            Caption = 'Archive Quotes';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(70061; "PWD Archive Orders"; Boolean)
        {
            Caption = 'Archive Orders';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(70062; "PWD Sales Order User Group"; Code[20])
        {
            Caption = 'Sales Order User Group';
            Description = 'PW2009';
            TableRelation = "Permission Set"."Role ID";
            DataClassification = CustomerContent;
        }
        field(70063; "PWD Souche DSA"; Code[10])
        {
            Caption = 'Souche DSA';
            Description = 'PW2009';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(70064; "PWD Ressource prestation"; Code[20])
        {
            Caption = 'Ressource prestation';
            Description = 'PW2009';
            TableRelation = Resource;
            DataClassification = CustomerContent;
        }
        field(70065; "PWD Souche de TM"; Code[20])
        {
            Caption = 'Souche de TM';
            Description = 'PW2009';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(70066; "PWD Souche de T5"; Code[20])
        {
            Caption = 'Souche de T5';
            Description = 'PW2009';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(70067; "PWD Souche EX9"; Code[20])
        {
            Caption = 'Souche EX9';
            Description = 'PW2009';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(70068; "PWD Souche COM9"; Code[20])
        {
            Caption = 'Souche COM9';
            Description = 'PW2009';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(70069; "PWD Souche EX1"; Code[20])
        {
            Caption = 'Souche EX1';
            Description = 'PW2009';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(70070; "PWD Prestation M2 Invoice Nos."; Code[10])
        {
            Caption = 'Prestation M2 Invoice Nos.';
            Description = 'PW2009';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
    }
}
