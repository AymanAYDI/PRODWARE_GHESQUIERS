pageextension 50009 "PWD ItemCard" extends "Item Card"
{
    layout
    {
        addafter("No.")
        {
            field("PWD SEAF Code"; Rec."PWD SEAF Code")
            {
                ApplicationArea = all;
            }
            field("PWD SEAF Code 2"; Rec."PWD SEAF Code 2")
            {
                ApplicationArea = all;
            }
            field("PWD SEAF Code 3"; Rec."PWD SEAF Code 3")
            {
                ApplicationArea = all;
            }
            field("PWD SEAF Code 4"; Rec."PWD SEAF Code 4")

            {
                ApplicationArea = all;
            }
            field("PWD SEAF Code 5"; Rec."PWD SEAF Code 5")
            {
                ApplicationArea = all;
            }
        }
        addafter(Description)
        {
            field("PWD Description 2"; Rec."Description 2")

            {
                ApplicationArea = all;
            }
        }
        modify("Base Unit of Measure")
        {
            LookupPageId = "Item Units of Measure";
            DrillDownPageId = "Item Units of Measure";
        }
        addafter("Qty. on Sales Order")
        {
            field("PWD Qty. on Sales Order Prep"; Rec."PWD Qty. on Sales Order Prep")
            {
                ApplicationArea = all;
            }
        }
        addafter("Qty. on Service Order")
        {
            field("PWD Qty. on Quote Order"; Rec."PWD Qty. on Quote Order")
            {
                ApplicationArea = all;
            }
        }
        addafter("Unit Price")
        {
            field("PWD Customs Price"; Rec."PWD Customs Price")
            {
                ApplicationArea = all;
            }
            field("PWD Prestation SEAF Price"; Rec."PWD Prestation SEAF Price")
            {
                ApplicationArea = all;
            }
            field("PWD SEAF E price"; Rec."PWD SEAF E price")
            {
                ApplicationArea = all;
            }
        }
        addafter("Sales Unit of Measure")
        {
            field("PWD Propriete Seafrance"; Rec."PWD Propriete Seafrance")
            {
                ApplicationArea = all;
            }
            field("PWD Bottom Price"; Rec."PWD Bottom Price")
            {
                ApplicationArea = all;
            }
            field("PWD Maximum Price"; Rec."PWD Maximum Price")
            {
                ApplicationArea = all;
            }
        }
        addafter("Lot Size")
        {
            field("PWD Item Category Code"; Rec."Item Category Code")
            {
                ApplicationArea = all;
            }
        }
        addafter("Safety Stock Quantity")
        {
            field("PWD Routing No."; Rec."Routing No.")
            {
                ApplicationArea = all;
            }
            field("PWD Production BOM No."; Rec."Production BOM No.")
            {
                ApplicationArea = all;
            }
            field("PWD Rounding Precision"; Rec."Rounding Precision")
            {
                ApplicationArea = all;
            }
            field("PWD Critical"; Rec.Critical)
            {
                ApplicationArea = all;
            }
        }
        addafter("Gross Weight")
        {
            field("PWD Translation"; Rec."PWD Translation")
            {
                ApplicationArea = All;
            }
        }
        addafter("Expiration Calculation")
        {
            field("PWD Butchery EC"; Rec."PWD Butchery")
            {
                ApplicationArea = all;
            }
            field("PWD Conserving Temperature"; Rec."PWD Conserving Temperature")
            {
                ApplicationArea = all;
            }
            field("PWD Transport Temperature"; Rec."PWD Transport Temperature")
            {
                ApplicationArea = All;
            }
            field("PWD Trading Brand"; Rec."PWD Trading Brand")
            {
                ApplicationArea = All;
            }
        }
        addafter("Use Cross-Docking")
        {
            field("PWD Health Certificate Required"; Rec."PWD Health Certificate Required")
            {
                ApplicationArea = all;
            }
            field("PWD Origin Certified"; Rec."PWD Origin Certified")
            {
                ApplicationArea = all;
            }
            field("PWD Conformity Certificate"; Rec."PWD Conformity Certificate")
            {
                ApplicationArea = all;
            }
            field("PWD Technical Card"; Rec."PWD Technical Card")
            {
                ApplicationArea = all;
            }
            field("PWD Manifest"; Rec."PWD Manifest")
            {
                ApplicationArea = all;
            }
            field("PWD Manifest Category"; Rec."PWD Manifest Category")
            {
                ApplicationArea = all;
            }
            field("PWD Professional Description"; Rec."PWD Professional Description")
            {
                ApplicationArea = all;
            }
            field("PWD Family"; Rec."PWD Family")
            {
                ApplicationArea = all;
            }
            field("PWD Sub Family"; Rec."PWD Sub Family")
            {
                ApplicationArea = All;
            }
            field("PWD Family (Sea France)"; Rec."PWD Family (Sea France)")
            {
                ApplicationArea = All;
            }
            field("PWD Sub Family (Sea France)"; Rec."PWD Sub Family (Sea France)")
            {
                ApplicationArea = All;
            }
        }
        addafter(Warehouse)
        {
            group("PWD Customs")
            {
                Caption = 'Customs';
                field("PWD National Add. Code"; Rec."PWD National Add. Code")
                {
                    ApplicationArea = all;
                }
                field("PWD Dimension"; Rec."PWD Dimension")
                {
                    ApplicationArea = all;
                }
                field("PWD Restitution Key"; Rec."PWD Restitution Key")
                {
                    ApplicationArea = all;
                }
                field("Alcool %"; Rec."PWD Alcool %")
                {
                    ApplicationArea = all;
                }
                field("PWD Base Customs No."; Rec."PWD Base Customs No.")
                {
                    ApplicationArea = all;
                }
                field("PWD Tariff Regrouping code"; Rec."PWD Tariff Regrouping code")
                {
                    ApplicationArea = all;
                }
                field("PWD IMPA Code"; Rec."PWD IMPA Code")
                {
                    ApplicationArea = All;
                }
                field("PWD ISSA Code"; Rec."PWD ISSA Code")
                {
                    ApplicationArea = All;
                }
                field("ISSA Code (Old Version)"; Rec."ISSA Code (Old Version)")
                {
                    ApplicationArea = All;
                }
                field("PWD Ventilation code"; Rec."PWD Ventilation code")
                {
                    ApplicationArea = all;
                }
                field("PWD Purchase blocked"; Rec."PWD Purchase blocked")
                {
                    ApplicationArea = All;
                }
                field("PWD Gross Weight"; Rec."Gross Weight")
                {
                    ApplicationArea = All;
                }
                field("PWD Net Weight"; Rec."Net Weight")
                {
                    ApplicationArea = All;
                }
                field("PWD Unit Volume"; Rec."Unit Volume")
                {
                    ApplicationArea = All;
                }
                field("PWD No. sommier hors CEE"; Rec."PWD No. sommier hors CEE")
                {
                    ApplicationArea = All;
                }
                field("PWD Coefficient Seafrance"; Rec."PWD Coefficient Seafrance")
                {
                    ApplicationArea = All;
                }
                field("PWD CIEL Personal Caption"; Rec."PWD CIEL Personal Caption")
                {
                    ApplicationArea = all;
                }
                /* field("PWD Boucherie"; "PWD Boucherie")
                 {
                     ApplicationArea = All;
                 }*/
                field("PWD Butchery"; Rec."PWD Butchery")
                {
                    ApplicationArea = All;
                }
                field("PWD Meat Family"; Rec."PWD Meat Family")
                {
                    ApplicationArea = All;
                }
                field("PWD Meat Type"; Rec."PWD Meat Type")
                {
                    ApplicationArea = All;
                }




            }
        }
    }
}
