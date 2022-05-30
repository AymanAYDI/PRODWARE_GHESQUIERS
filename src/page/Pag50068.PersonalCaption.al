page 50068 "PWD Personal Caption"
{
    // -----------------------------------------------------------------------------------------------------------------
    // Prodware - www.prodware.fr
    // -----------------------------------------------------------------------------------------------------------------
    //
    // //>>NDBI (P25940_002)
    // LALE.RO : 03/09/2018 : cf NDBI ID 437
    //                        new Page

    Caption = 'Personnal Caption';
    PageType = List;
    SourceTable = "PWD Personal Caption";
    ApplicationArea = all;
    UsageCategory = Lists;
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
                field("Fiscal Caption"; Rec."Fiscal Caption")
                {
                    ApplicationArea = All;
                }
                field("Rate Of Alcohol By Volume"; Rec."Rate Of Alcohol By Volume")
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
