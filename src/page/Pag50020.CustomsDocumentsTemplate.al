page 50020 "PWD Customs Documents Template"
{
    Caption = 'Customs Documents Template';
    DelayedInsert = true;
    PageType = List;
    SourceTable = "PWD Customs Documents Template";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field("No."; Rec."No.")
                {
                    ApplicationArea = all;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = all;
                }
                field("Based On"; Rec."Based On")
                {
                    ApplicationArea = all;
                }
                field(Correspondence; Rec.Correspondence)
                {
                    ApplicationArea = all;
                }
                field(Attachment; Rec.Attachment)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Doc. joint")
            {
                Caption = '&Attachment';
                action(Ouvrir)
                {
                    ApplicationArea = all;
                    Caption = 'Open';

                    trigger OnAction()
                    var
                        InteractTemplLanguage: Record "Interaction Tmpl. Language";
                    begin
                        Rec.OpenAttachment(Rec.Description, FALSE);
                    end;
                }
                action("Créer")
                {
                    ApplicationArea = all;
                    Caption = 'Create';
                    Ellipsis = true;

                    trigger OnAction()
                    var
                        InteractTemplLanguage: Record "Interaction Tmpl. Language";
                    begin
                        Rec.CreateAttachment();
                        CurrPage.UPDATE();
                    end;
                }
                action("Copier &de")
                {
                    ApplicationArea = all;
                    Caption = 'Copy &from';
                    Ellipsis = true;
                    Visible = false;
                    trigger OnAction()
                    var
                        InteractTemplLanguage: Record "Interaction Tmpl. Language";
                    begin
                        IF NOT InteractTemplLanguage.GET(Rec."No.", '') THEN BEGIN
                            InteractTemplLanguage.INIT();
                            InteractTemplLanguage."Interaction Template Code" := Rec."No.";
                            InteractTemplLanguage."Language Code" := '';
                            InteractTemplLanguage.Description := Rec.Description;
                            InteractTemplLanguage.INSERT();
                            COMMIT();
                        END;
                        InteractTemplLanguage.CopyFromAttachment();
                        CurrPage.UPDATE();
                    end;
                }
                action("I&mporter")
                {
                    ApplicationArea = all;
                    Caption = 'Import';
                    Ellipsis = true;
                    trigger OnAction()
                    var
                        InteractTemplLanguage: Record "Interaction Tmpl. Language";
                    begin
                        Rec.ImportAttachment('', TRUE);
                        CurrPage.UPDATE();
                    end;
                }
                action("Ex&porter")
                {
                    ApplicationArea = all;
                    Caption = 'E&xport';
                    Ellipsis = true;
                    Visible = false;

                    trigger OnAction()
                    var
                        InteractTemplLanguage: Record "Interaction Tmpl. Language";
                    begin
                        IF InteractTemplLanguage.GET(Rec."No.", '') THEN
                            InteractTemplLanguage.ExportAttachment();
                    end;
                }
                action("S&upprimer")
                {
                    ApplicationArea = all;
                    Caption = 'Remove';
                    Ellipsis = true;
                    Visible = false;
                    trigger OnAction()
                    var
                        InteractTemplLanguage: Record "Interaction Tmpl. Language";
                    begin
                        IF InteractTemplLanguage.GET(Rec."No.", '') THEN
                            InteractTemplLanguage.RemoveAttachment(TRUE);
                    end;
                }
            }
        }
    }
}

