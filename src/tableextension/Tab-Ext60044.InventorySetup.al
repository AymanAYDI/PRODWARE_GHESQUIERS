tableextension 60044 "PWD InventorySetup" extends "Inventory Setup"
{
    fields
    {
        field(50000; "PWD Default Transl. Lang."; Code[10])
        {
            Caption = 'Default Translation Language';
            Description = 'PW2009';
            TableRelation = Language.Code;
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                UpdateTranslation("PWD Default Transl. Lang.");
            end;
        }
        field(50001; "PWD Whse Responsible Role Id"; Code[20])
        {
            Caption = 'Whse Responsible Role Id';
            Description = 'PW2009';
            TableRelation = "Permission Set"."Role ID";
            DataClassification = CustomerContent;
        }
        field(50002; "PWD Nom modele prestation"; Code[20])
        {
            Caption = 'Nom modèle préstation';
            Description = 'PW2009';
            TableRelation = "Item Journal Template".Name;
            DataClassification = CustomerContent;
        }
    }

    procedure UpdateTranslation(LanguageCode: Code[10])
    var
        Item: Record Item;
        ItemTranslation: Record "Item Translation";
    begin
        IF Item.FindSet() THEN
            REPEAT
                ItemTranslation.SETRANGE(ItemTranslation."Item No.", Item."No.");
                ItemTranslation.SETRANGE("Language Code", LanguageCode);
                IF ItemTranslation.FindFirst() THEN BEGIN
                    Item."PWD Translation" := ItemTranslation.Description;
                    Item.MODIFY();
                END;
            UNTIL Item.NEXT() = 0;
    end;
}
