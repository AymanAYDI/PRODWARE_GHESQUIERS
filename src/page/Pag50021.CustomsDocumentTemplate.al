page 50021 "PWD Customs Document Template"
{
    Caption = 'Customs Document Template';
    Editable = false;
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
                field(Attachment; Rec.Attachment)
                {
                    ApplicationArea = all;
                }
                field("Template Type"; Rec."Template Type")
                {
                    ApplicationArea = all;
                }
                field(Correspondence; Rec.Correspondence)
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }
}

