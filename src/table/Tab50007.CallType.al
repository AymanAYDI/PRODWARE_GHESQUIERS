table 50007 "PWD Call Type"
{
    // 31.01.2006    C2A(LLE)  add New boolean fields
    //                         Ne pas imprimer DLC sur BP
    //                         Pas de saut de page sur BP

    Caption = 'Call type';
    LookupPageID = "PWD Call Type";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Code"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(2; Description; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(3; "Shipment Method Code"; Code[10])
        {
            Caption = 'Shipment Method Code';
            TableRelation = "Shipment Method";
            DataClassification = CustomerContent;
        }
        field(4; "Shipping No. Series"; Code[10])
        {
            Caption = 'Souche de n° expédition';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(5; "Posting No. Series"; Code[10])
        {
            Caption = 'Souches de n° validation';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(6; "Message EXO"; Boolean)
        {
            Caption = 'Message EXO';
            DataClassification = CustomerContent;
        }
        field(7; "Tri sur code SEAF"; Boolean)
        {
            Caption = 'Tri sur code SEAF';
            DataClassification = CustomerContent;
        }
        field(60007; "Ne pas imprimer DLC sur BP"; Boolean)
        {
            Caption = 'Ne pas imprimer DLC sur BP';
            DataClassification = CustomerContent;
        }
        field(60008; "Pas de saut de page sur BP"; Boolean)
        {
            Caption = 'Pas de saut de page sur BP';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
