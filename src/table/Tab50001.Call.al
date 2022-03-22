table 50001 "PWD Call"
{
    Caption = 'Call';
    LookupPageID = "PWD Calls List";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Call No."; Code[10])
        {
            Caption = 'Call No.';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                IF "Call No." <> xRec."Call No." THEN BEGIN
                    SRSetup.GET();
                    NoSeriesMgt.TestManual(SRSetup."PWD Call No. Series");
                    "No. Series" := '';
                END;
                IF "File Date" = 0D THEN
                    "File Date" := TODAY;
            end;
        }
        field(2; "Call Type"; Code[10])
        {
            Caption = 'Call Type';
            TableRelation = "PWD Call Type".Code;
            DataClassification = CustomerContent;
        }
        field(3; Ship; Code[20])
        {
            Caption = 'Ship';
            Description = 'Customer Table';
            TableRelation = Customer."No.";
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                GetCust(Ship);
                Name := Cust.Name;
                VALIDATE(Flag, Cust."PWD Flag");
                VALIDATE("Country Code", Cust."Country/Region Code");
                Address := Cust.Address;
                "Address 2" := Cust."Address 2";
                City := Cust.City;
                "Post Code" := Cust."Post Code";
                "Customer No." := Cust."No.";
                Area := Cust."PWD Area";
            end;
        }
        field(4; Flag; Code[20])
        {
            Caption = 'Flag';
            Description = 'Default Customer Table';
            DataClassification = CustomerContent;

            trigger OnLookup()
            var
                Country: Record "Country/Region";
                PageCountry: Page "Countries/Regions";
            begin
                CLEAR(PageCountry);
                PageCountry.LOOKUPMODE(TRUE);
                PageCountry.SETTABLEVIEW(Country);
                IF PageCountry.RUNMODAL() = ACTION::LookupOK THEN BEGIN
                    ;
                    PageCountry.GETRECORD(Country);
                    Flag := Country."PWD Flag";
                    GetCountry(Country.Code);
                    "Monthly Code" := RecCountry."PWD Monthly Code";
                END;
            end;
        }
        field(5; "Monthly Code"; Code[10])
        {
            Caption = 'Monthly Code';
            Description = 'Flag and country Table';
            DataClassification = CustomerContent;
        }
        field(6; "Board Location"; Text[30])
        {
            Caption = 'Board Location';
            DataClassification = CustomerContent;
        }
        field(7; "Border Office"; Text[30])
        {
            Caption = 'Customs Office';
            DataClassification = CustomerContent;
        }
        field(8; "File Date"; Date)
        {
            Caption = 'File Date';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(9; Department; Code[10])
        {
            Caption = 'Department';
            DataClassification = CustomerContent;
        }
        field(10; Address; Text[30])
        {
            Caption = 'Address';
            Description = 'Customer Table';
            DataClassification = CustomerContent;
        }
        field(11; "Address 2"; Text[30])
        {
            Caption = 'Address 2';
            Description = 'Customer Table';
            DataClassification = CustomerContent;
        }
        field(12; City; Text[30])
        {
            Caption = 'City';
            Description = 'Customer Table';
            DataClassification = CustomerContent;
        }
        field(13; Name; Text[30])
        {
            Caption = 'Name';
            Description = 'Customer Table';
            DataClassification = CustomerContent;
        }
        field(14; "Name 2"; Text[30])
        {
            Caption = 'Name 2';
            Description = 'Shiponwer (Armateur)';
            DataClassification = CustomerContent;
        }
        field(15; "Post Code"; Code[20])
        {
            Caption = 'Post Code';
            Description = 'Customer Table';
            DataClassification = CustomerContent;
            //This property is currently not supported
            //TestTableRelation = false;
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = false;            
        }
        field(16; "Area"; Code[10])
        {
            Caption = 'Area';
            TableRelation = Area;
            DataClassification = CustomerContent;
        }
        field(17; "No. Series"; Code[10])
        {
            Caption = 'Series Code';
            Description = 'CodeUnit 396';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(18; "Date and time of arrival"; DateTime)
        {
            Caption = 'Date and time of arrival';
            DataClassification = CustomerContent;
        }
        field(19; "Date and time of departure"; DateTime)
        {
            Caption = 'Date and time of departure';
            DataClassification = CustomerContent;
        }
        field(20; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            DataClassification = CustomerContent;
        }
        field(21; "DAS No."; Code[20])
        {
            Caption = 'DAS No.';
            DataClassification = CustomerContent;
        }
        field(22; "Boat Name"; Text[50])
        {
            Caption = 'Boat Name';
            DataClassification = CustomerContent;
        }
        field(23; Attachement; Text[50])
        {
            Caption = 'Attachement';
            DataClassification = CustomerContent;
        }
        field(24; "Equipe for fisching"; Text[50])
        {
            Caption = 'Equipe for fisching';
            DataClassification = CustomerContent;
        }
        field(25; "Equipement Statement"; Text[50])
        {
            Caption = 'Equipement Statement';
            DataClassification = CustomerContent;
        }
        field(26; Captain; Text[50])
        {
            Caption = 'Captain';
            DataClassification = CustomerContent;
        }
        field(27; "Country Code"; Code[10])
        {
            Caption = 'Country Code';
            TableRelation = "Country/Region";
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                IF RecCountry.GET("Country Code") THEN
                    "Monthly Code" := RecCountry."PWD Monthly Code";
            end;
        }
        field(30; "Code information transport"; Code[20])
        {
            TableRelation = "Standard Text".Code;
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                StandardText: Record "Standard Text";
            begin
                IF StandardText.GET("Code information transport") THEN
                    "Designation info. transport" := StandardText.Description ELSE
                    "Designation info. transport" := '';
            end;
        }
        field(40; "Designation info. transport"; Text[30])
        {
            Caption = 'Designation info. transport';
            DataClassification = CustomerContent;
        }
        field(60001; "Commentaire 1"; Text[50])
        {
            Caption = 'Commentaire 1';
            DataClassification = CustomerContent;
        }
        field(60002; "Commentaire 2"; Text[50])
        {
            Caption = 'Commentaire 2';
            DataClassification = CustomerContent;
        }
        field(60003; "Commentaire 3"; Text[50])
        {
            Caption = 'Commentaire 3';
            DataClassification = CustomerContent;
        }
        field(60004; "Commentaire 4"; Text[50])
        {
            Caption = 'Commentaire 4';
            DataClassification = CustomerContent;
        }
        field(60005; "Commentaire 5"; Text[50])
        {
            Caption = 'Commentaire 5';
            DataClassification = CustomerContent;
        }
        field(60006; "DSA 13"; Option)
        {
            Caption = 'DSA 13';
            OptionMembers = "Valeur Facture","Valeur Douane";
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Call No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        SRSetup.GET();

        IF "Call No." = '' THEN BEGIN
            SRSetup.GET();
            SRSetup.TESTFIELD(SRSetup."PWD Call No. Series");
            NoSeriesMgt.InitSeries(SRSetup."PWD Call No. Series", xRec."No. Series", 0D, "Call No.", "No. Series");
        END;

        "File Date" := TODAY;
    end;

    var
        SRSetup: Record "Sales & Receivables Setup";
        RecCall: Record "PWD Call";
        Cust: Record Customer;
        RecCountry: Record "Country/Region";
        NoSeriesMgt: Codeunit NoSeriesManagement;

    procedure AssistEdit(OldCall: Record "PWD Call"): Boolean
    begin
        RecCall := Rec;
        SRSetup.GET();
        SRSetup.TESTFIELD("PWD Call No. Series");
        IF NoSeriesMgt.SelectSeries(SRSetup."PWD Call No. Series", OldCall."No. Series", RecCall."No. Series") THEN BEGIN
            SRSetup.GET();
            SRSetup.TESTFIELD("PWD Call No. Series");
            NoSeriesMgt.SetSeries(RecCall."Call No.");
            Rec := RecCall;
            EXIT(TRUE);
        END;
    end;

    local procedure GetCust(CustNo: Code[20])
    begin
        IF NOT (CustNo = '') THEN BEGIN
            IF CustNo <> Cust."No." THEN
                Cust.GET(CustNo);
        END ELSE
            CLEAR(CustNo);
    end;

    local procedure GetCountry(CountryNo: Code[20])
    begin
        IF NOT (CountryNo = '') THEN BEGIN
            IF CountryNo <> RecCountry.Code THEN
                RecCountry.GET(CountryNo);
        END ELSE
            CLEAR(CountryNo);
    end;
}

