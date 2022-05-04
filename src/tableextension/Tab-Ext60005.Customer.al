tableextension 60005 "PWD Customer" extends Customer
{
    fields
    {
        field(50000; "PWD Siret No."; Code[30])
        {
            Caption = 'Siret No.';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(50001; "PWD Vendor code"; Code[10])
        {
            Caption = 'Vendor code';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(50002; "PWD Customer No. COALA"; Code[8])
        {
            Caption = 'N° client COALA';
            DataClassification = CustomerContent;
        }
        field(50100; "PWD Mobil No. 1"; Text[30])
        {
            Caption = 'Phone No.';
            Description = 'SOBI';
            ExtendedDatatype = PhoneNo;
            DataClassification = CustomerContent;
        }
        field(50101; "PWD Mobil No. 2"; Text[30])
        {
            Caption = 'N° mobile 2';
            Description = 'SOBI';
            DataClassification = CustomerContent;
        }
        field(50102; "PWD Phone fixe No."; Text[30])
        {
            Caption = 'n° tel. fixe 2';
            Description = 'SOBI';
            DataClassification = CustomerContent;
        }
        field(50103; "PWD E-Mail 2"; Text[80])
        {
            Caption = 'E-Mail';
            Description = 'SOBI';
            ExtendedDatatype = EMail;
            DataClassification = CustomerContent;
        }
        field(50104; "PWD E-Mail 3"; Text[80])
        {
            Caption = 'E-Mail';
            Description = 'SOBI';
            ExtendedDatatype = EMail;
            DataClassification = CustomerContent;
        }
        field(50105; "PWD E-Mail 4"; Text[80])
        {
            Caption = 'E-Mail';
            Description = 'SOBI';
            ExtendedDatatype = EMail;
            DataClassification = CustomerContent;
        }
        field(50106; "PWD Web Identifier"; Text[250])
        {
            Caption = 'Identifiant web';
            Description = 'SOBI';
            DataClassification = CustomerContent;
        }
        field(50107; "PWD Last Shipping Date"; Date)
        {
            CalcFormula = Max("Sales Invoice Header"."Posting Date" WHERE("Sell-to Customer No." = FIELD("No.")));
            Caption = 'Date de dernière livraison';
            Description = 'SOBI';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50108; "PWD Last Invoice No."; Code[20])
        {
            CalcFormula = Max("Sales Invoice Header"."No." WHERE("Sell-to Customer No." = FIELD("No.")));
            Caption = 'Dernier n° de facture';
            Description = 'SOBI';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50110; "PWD C/O"; Boolean)
        {
            Caption = 'c/o';
            Description = 'SOBI';
            DataClassification = CustomerContent;
        }
        field(50111; "PWD Additional name"; Text[50])
        {
            Caption = 'Nom complémentaire';
            Description = 'SOBI';
            DataClassification = CustomerContent;
        }
        field(50200; "PWD Group In EMail"; Boolean)
        {
            Caption = 'Regrouper dans un Email';
            Description = 'SOBI';
            DataClassification = CustomerContent;
        }
        field(52000; "PWD Flag"; Code[20])
        {
            Caption = 'Flag';
            Description = 'PW2009';
            DataClassification = CustomerContent;

            trigger OnLookup()
            var
                Country: Record "Country/Region";
                FormCountry: Page "Countries/Regions";
            begin
                CLEAR(FormCountry);
                FormCountry.LOOKUPMODE(TRUE);
                FormCountry.SETTABLEVIEW(Country);
                IF FormCountry.RUNMODAL() = ACTION::LookupOK THEN BEGIN
                    FormCountry.GETRECORD(Country);
                    "PWD Flag" := Country."PWD Flag";
                END;
            end;
        }
        field(55000; "PWD Business Initiator"; Code[20])
        {
            Caption = 'Business Initiator';
            Description = 'PW2009';
            TableRelation = Contact."No." WHERE(Type = CONST(Person));
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                UpDateBusinessInitiator();
            end;
        }
        field(55001; "PWD Payback Commission Rate"; Decimal)
        {
            Caption = 'Payback Commission Rate';
            Description = 'PW2009';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                UpDateBusinessInitiator();
            end;
        }
        field(55010; "Discount Profit %"; Decimal)
        {
            Caption = 'Discount Profit %';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(55011; "PWD Family Code"; Code[10])
        {
            Caption = 'Family Code';
            Description = 'PW2009';
            TableRelation = "PWD Custom Parameters".Code WHERE("Table ID" = CONST(18), "Field ID" = CONST(55011));
            DataClassification = CustomerContent;
        }
        field(55012; "PWD Sub Family Code"; Code[10])
        {
            Caption = 'Sub Family Code';
            Description = 'PW2009';
            TableRelation = "PWD Custom Parameters".Code WHERE("Table ID" = CONST(18), "Field ID" = CONST(55012));
            DataClassification = CustomerContent;
        }
        field(55013; "PWD Origin Certified"; Boolean)
        {
            Caption = 'Origin Certified';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(55014; "PWD Health Certificate Required"; Boolean)
        {
            Caption = 'Health Certificate Required';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(55015; "PWD Conformity Certificate"; Boolean)
        {
            Caption = 'Conformity Certificate';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(55016; "PWD Technical Card"; Boolean)
        {
            Caption = 'Technical Card';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(55017; "PWD Area"; Code[10])
        {
            Caption = 'Area';
            Description = 'PW2009';
            TableRelation = Area;
            DataClassification = CustomerContent;
        }
        field(55018; "PWD Acknowledgement"; Enum "PWD Acknowledgement")
        {
            Caption = 'Acknowledgement';
            Description = 'PW2009';
            //TODOOptionMembers = "AR par impression","AR par Fax","AR par Email"; //Récupérer la traduction
            DataClassification = CustomerContent;
        }
        field(55019; "PWD No. d accises"; Code[20])
        {
            Caption = 'N° d''accises';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(55030; "PWD Sell-to Customer Filter"; Code[20])
        {
            Caption = 'Sell-to Customer Filter';
            Description = 'PW2009';
            FieldClass = FlowFilter;
            TableRelation = Customer;
        }
        field(55031; "PWD Billing by Vendor"; Boolean)
        {
            Caption = 'Billing by Vendor';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(Key50000; "PWD Group In EMail")
        {
        }
    }
    local procedure UpDateBusinessInitiator()
    var
        ContUpd: Record Contact;
        ContBusRelUpd: Record "Contact Business Relation";
    begin
        //--------------------------------------------//
        //*** Fonction C2A -  MAJ Busines initiator & Payback commissoin rate
        //--------------------------------------------//

        //*** MAJ du BusinessInitiator dans la fiche client
        ContBusRelUpd.SETCURRENTKEY("Link to Table", "No.");
        ContBusRelUpd.SETRANGE("Link to Table", ContBusRelUpd."Link to Table"::Customer);
        ContBusRelUpd.SETRANGE("No.", "No.");
        IF ContBusRelUpd.FIND('-') THEN
            REPEAT

                ContUpd.SETRANGE("Company No.", ContBusRelUpd."Contact No.");
                IF ContUpd.FIND('-') THEN
                    REPEAT
                        ContUpd."PWD Business Initiator" := "PWD Business Initiator";
                        ContUpd."PWD Payback Commission Rate" := "PWD Payback Commission Rate";
                        ContUpd.MODIFY();
                    UNTIL ContUpd.NEXT() = 0;
            UNTIL ContBusRelUpd.NEXT() = 0;
    end;
}

