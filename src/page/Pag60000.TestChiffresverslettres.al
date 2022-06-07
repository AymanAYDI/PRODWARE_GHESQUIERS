page 60000 "PWD Test Chiffres vers lettres"
{
    PageType = Card;

    layout
    {
        area(content)
        {
            field(nombre; nombre)
            {
                DecimalPlaces = 2 : 3;
                ShowCaption = false;
                ApplicationArea = All;
            }
            field("NombreText[1]"; NombreText[1])
            {
                ShowCaption = false;
                ApplicationArea = All;
            }
            field("NombreText[2]"; NombreText[2])
            {
                ShowCaption = false;
                ApplicationArea = All;
            }
            field("NombreText[3]"; NombreText[3])
            {
                ShowCaption = false;
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Générer")
            {
                Promoted = true;
                PromotedCategory = Process;
                Image= Action;
                ApplicationArea = All;
                PromotedOnly = true;
                trigger OnAction()
                begin
                    codeu.InitTextVariable();
                    codeu.FormatNoText(NombreText, nombre, 'Kg');
                end;
            }
        }
    }

    var
        codeu: Codeunit "PrintTextAmount(dec => Letter)";
        nombre: Decimal;
        NombreText: array[3] of Text[100];
}
