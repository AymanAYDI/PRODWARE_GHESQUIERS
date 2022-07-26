page 50061 "PWD User Signing"
{
    Caption = 'User Signing';
    UsageCategory = None;
    /*DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    SourceTable = "User";
    ApplicationArea = All;
    UsageCategory = Tasks;
    layout
    {
        area(content)
        {
            field("User ID"; "User Security ID")
            {
                Editable = false;
                ShowCaption = false;
                ApplicationArea = All;
            }

            field(Name; "User Name")
            {
                Editable = false;
                ShowCaption = false;
                ApplicationArea = All;
            }
            field(Signing; "PWD Signing")
            {
                ShowCaption = false;
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Signature)
            {
                Caption = 'Signing';
                action(Importer)
                {
                    Caption = 'Importer';
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        PictureExists: Boolean;
                    begin
                        PictureExists := "PWD Signing".HASVALUE;
                        IF Signing.IMPORT('*.BMP', TRUE) = '' THEN
                            EXIT;
                        IF PictureExists THEN
                            IF NOT CONFIRM(Text001, FALSE) THEN
                                EXIT;
                        CurrPage.SAVERECORD;
                    end;
                }
                action(Supprimer)
                {
                    Caption = 'Supprimer';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        IF Signing.HASVALUE THEN
                            IF CONFIRM(Text002, FALSE) THEN BEGIN
                                CLEAR(Signing);
                                CurrPage.SAVERECORD;
                            END;
                    end;
                }
            }
        }
    }
    trigger OnAfterGetRecord()
    var
        UserSetup: Record "User Setup";
    begin
        UserSetup.Get();
    end;

    var
        Text001: Label 'Do you want to replace the existing picture?';
        Text002: Label 'Do you want to delete the picture?';*/
}
