page 50067 "PWD Fiscal Caption"
{
    // -----------------------------------------------------------------------------------------------------------------
    // Prodware - www.prodware.fr
    // -----------------------------------------------------------------------------------------------------------------
    // 
    // //>>NDBI (P25940_002)
    // LALE.RO : 03/09/2018 : cf NDBI ID 437
    //                        new Page

    Caption = 'Fiscal Caption';
    PageType = List;
    SourceTable = "PWD Fiscal Caption";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

