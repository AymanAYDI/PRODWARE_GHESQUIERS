tableextension 60049 "PWD Contact" extends Contact
{
    fields
    {
        field(55000; "PWD Business Initiator"; Code[20])
        {
            Caption = 'Business Initiator';
            Description = 'PW2009';
            TableRelation = Contact."No." WHERE(Type = CONST(Person));
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                UpdateBusinessInitiator();
            end;
        }
        field(55001; "PWD Payback Commission Rate"; Decimal)
        {
            Caption = 'Payback Commission Rate';
            Description = 'PW2009';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                UpdateBusinessInitiator();
            end;
        }
    }

    procedure UpdateBusinessInitiator()
    var
        ContUpd: Record Contact;
        ContBusRelUpd: Record "Contact Business Relation";
        CustUpd: Record Customer;
    begin
        //--------------------------------------------//
        //*** Fonction C2A -  MAJ Busines initiator & Payback commissoin rate
        //--------------------------------------------//
        //*** Recherche de la société
        //*** MAJ du BusinessInitiator dans les fiches contacts
        ContUpd.SETRANGE("Company No.", "Company No.");
        IF ContUpd.FIND('-') THEN
            REPEAT
                IF ContUpd."No." <> "No." THEN BEGIN
                    ContUpd."PWD Business Initiator" := "PWD Business Initiator";
                    ContUpd."PWD Payback Commission Rate" := "PWD Payback Commission Rate";
                    ContUpd.MODIFY();
                END;
            UNTIL ContUpd.NEXT() = 0;

        //*** MAJ du BusinessInitiator dans la fiche client
        ContBusRelUpd.SETCURRENTKEY("Link to Table", "Contact No.");
        ContBusRelUpd.SETRANGE("Link to Table", ContBusRel."Link to Table"::Customer);
        ContBusRelUpd.SETRANGE("Contact No.", "Company No.");
        IF ContBusRelUpd.FIND('-') THEN BEGIN
            IF CustUpd.GET(ContBusRelUpd."No.") THEN
                CustUpd."PWD Business Initiator" := "PWD Business Initiator";
            CustUpd."PWD Payback Commission Rate" := "PWD Payback Commission Rate";
            CustUpd.MODIFY();
        END;
    end;

    var
        ContBusRel: Record "Contact Business Relation";
}

