page 50022 "Choose Customs Doc Template"
{
    Caption = 'Choose Customs Doc Template';
    PageType = Card;
    UsageCategory = None;
    layout
    {
        area(content)
        {
            field(DocumentTemplateCode; DocumentTemplateCode)
            {
                ApplicationArea = all;
                Caption = 'Document Template Code';
                TableRelation = "PWD Customs Documents Template";
            }
        }
    }

    actions
    {
    }

    var
        DocumentTemplateCode: Code[10];

    procedure GetFields(var GetDocTemplateCode: Code[10])
    begin
        GetDocTemplateCode := DocumentTemplateCode;
    end;
}
