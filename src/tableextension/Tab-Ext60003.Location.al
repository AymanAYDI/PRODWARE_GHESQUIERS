tableextension 60003 "PWD Location" extends Location
{
    fields
    {
        field(50000; "PWD Customs System"; Code[10])
        {
            Caption = 'Customs System';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(50001; "PWD Restitution"; Code[10])
        {
            Caption = 'Restitution';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(50002; "PWD Restitution Location"; Boolean)
        {
            Caption = 'Restitution Location';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(50003; "PWD Regime"; Text[50])
        {
            Caption = 'Regime';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(50004; "PWD Placement Series No."; Code[20])
        {
            Caption = 'Stocking Series No.';
            Description = 'PW2009';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(50005; "PWD Location ID"; Code[20])
        {
            Caption = 'Location ID (COM7)';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(50006; "PWD CounterMark Location"; Boolean)
        {
            Caption = 'CounterMark Location';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(50007; "PWD Magasin libre"; Boolean)
        {
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(50008; "PWD COM 7"; Boolean)
        {
            Caption = 'COM 7';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(50009; "PWD T5 ou T1"; Boolean)
        {
            Caption = 'T5 ou T1';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(50029; "PWD Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            Description = 'PW2009';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            DataClassification = CustomerContent;
        }
        field(50030; "PWD Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            Description = 'PW2009';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
            DataClassification = CustomerContent;
        }
        field(50031; "PWD Magasin DEB"; Boolean)
        {
            Caption = 'Magasin DEB';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(50032; "PWD Purch. Gen. Bus. Posting Group"; Code[10])
        {
            Caption = 'Purch. Gen. Bus. Posting Group';
            Description = 'PW2009';
            TableRelation = "Gen. Business Posting Group";
            DataClassification = CustomerContent;
        }
        field(50033; "PWD Sales Gen. Bus. Posting Group"; Code[10])
        {
            Caption = 'Sales Gen. Bus. Posting Group';
            Description = 'PW2009';
            TableRelation = "Gen. Business Posting Group";
            DataClassification = CustomerContent;
        }
        field(50034; "PWD Controle du prix plancher"; Boolean)
        {
            Caption = 'Contrôle du prix plancher';
            Description = 'PW2009';
            InitValue = true;
            DataClassification = CustomerContent;
        }
        field(50035; "PWD SEAF Placement Series No."; Code[10])
        {
            Caption = 'SEAF Placement Series No.';
            Description = 'PW2009';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(50036; "PWD Groupe autorise"; Code[20])
        {
            Caption = 'Groupe autorisé';
            Description = 'PW2009';
            TableRelation = "Permission Set";
            DataClassification = CustomerContent;
        }
        field(50037; "PWD Régime sortie"; Code[10])
        {
            Caption = 'Régime sortie';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(50038; "PWD Souche de DCG"; Code[20])
        {
            Caption = 'Souche de DCG';
            Description = 'PW2009';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(50039; "PWD Valorisation mvts periode"; Option)
        {
            Caption = 'Valorisation mvts periode';
            Description = 'PW2009';
            OptionMembers = "Coût unitaire","Prix douane";
            DataClassification = CustomerContent;
        }
    }
}