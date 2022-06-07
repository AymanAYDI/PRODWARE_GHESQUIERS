pageextension 50010 "PWD ItemList" extends "Item List"
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
                ApplicationArea = All;
            }
            field("PWD SEAF Code 3"; Rec."PWD SEAF Code 3")
            {
                ApplicationArea = All;
            }
            field("PWD SEAF Code 4"; Rec."PWD SEAF Code 4")
            {
                ApplicationArea = All;
            }
            field("PWD SEAF Code 5"; Rec."PWD SEAF Code 5")
            {
                ApplicationArea = All;
            }
        }
        addafter(Description)
        {
            field("PWD Description 2"; Rec."Description 2")
            {
                ApplicationArea = All;
            }
            field("PWD Translation"; Rec."PWD Translation")
            {
                ApplicationArea = all;
            }
            field("PWD Gross Weight"; Rec."Gross Weight")
            {
                ApplicationArea = all;
            }
            field("PWD Family"; Rec."PWD Family")
            {
                ApplicationArea = All;
            }
            field("Family (Sea France)"; Rec."PWD Family (Sea France)")
            {
                ApplicationArea = All;
            }
            field("Sub Family (Sea France)"; Rec."PWD Sub Family (Sea France)")
            {
                ApplicationArea = All;
            }
            field("PWD Net Weight"; Rec."Net Weight")
            {
                ApplicationArea = All;
            }
            field("PWD Sub Family"; Rec."PWD Sub Family")
            {
                ApplicationArea = All;
            }
        }
        addafter("Routing No.")
        {
            field("PWD Inventory"; Rec.Inventory)
            {
                ApplicationArea = All;
            }
            field("PWD Qty. on Purch. Order"; Rec."Qty. on Purch. Order")
            {
                ApplicationArea = All;
            }
            field("PWD Qty. on Sales Order"; Rec."Qty. on Sales Order")
            {
                ApplicationArea = All;
            }
        }
        addafter("Indirect Cost %")
        {
            field("PWD National Add. Code"; Rec."PWD National Add. Code")

            {
                ApplicationArea = all;
            }
            field("PWD Dimension"; Rec."PWD Dimension")
            {
                ApplicationArea = All;
            }
            field("PWD Marginal Tax"; Rec."PWD Marginal Tax")
            {
                ApplicationArea = All;
            }
            field("PWD Restitution Key"; Rec."PWD Restitution Key")
            {
                ApplicationArea = All;
            }
            field("Product %"; Rec."PWD Product %")
            {
                ApplicationArea = All;
            }
            field("PWD Restitution Amount"; Rec."PWD Restitution Amount")
            {
                ApplicationArea = All;
            }
            field("PWD Butchery"; Rec."PWD Butchery")
            {
                ApplicationArea = All;
            }
            field("PWD Alcool %"; Rec."PWD Alcool %")
            {
                ApplicationArea = All;
            }
            field("PWD Base Customs No."; Rec."PWD Base Customs No.")
            {
                ApplicationArea = All;
            }
            field("PWD Tariff Regrouping code"; Rec."PWD Tariff Regrouping code")
            {
                ApplicationArea = All;
            }
            field("PWD IMPA Code"; Rec."PWD IMPA Code")
            {
                ApplicationArea = All;
            }
            field("PWD ISSA Code"; Rec."PWD ISSA Code")
            {
                ApplicationArea = All;
            }
            field("ISSA Code (Old Version)"; Rec."PWD ISSA Code (Old Version)")
            {
                ApplicationArea = All;
            }
            field("PWD Professional Description"; Rec."PWD Professional Description")
            {
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        addafter("Compare List")
        {
            action("PWD Evaluation stock")
            {
                Caption = 'Evaluation stock';
                Image = Evaluate;
                RunObject = Report "PWD Evaluation stock SAS Ghes";
                ApplicationArea = all;
            }
            action("PWD Apurement fin de mois")
            {
                ApplicationArea = All;
                Caption = 'Apurement fin de mois';
                Image = PrintReport;
                RunObject = Report "PWD Apurement fin de mois";
            }
            action("PWD Inventaire pour la douane")
            {
                ApplicationArea = all;
                Caption = 'Inventaire pour la douane';
                Image = PrintReport;
                RunObject = Report "PWD Inventaire pour la douane";
            }
            action("Avita : Stock par lot")
            {
                ApplicationArea = All;
                Caption = 'Avita : Stock par lot';
                Image = PrintReport;
                //TODO
                //RunObject = Report 50073;
            }
            action("Relevé de douane")
            {
                ApplicationArea = all;
                caption = 'Relevé de douane';
                Image = PrintReport;
                RunObject = Report "PWD Relevé de douane";
            }
            action("SEAF : relevé vtes à emporter")
            {
                ApplicationArea = all;
                caption = 'SEAF : relevé vtes à emporter';
                Image = PrintReport;
                RunObject = Report "SEAF : relevé vtes à emporter";
            }
            action("PWD Generation Purchase Order-TrB")
            {
                ApplicationArea = all;
                caption = 'Generation Purchase Order -TrB';
                Image = PrintReport;
                RunObject = Report "Generation Purchase Order -TrB";
            }
            action("Relevé des Sorties Export 2")
            {
                ApplicationArea = all;
                caption = 'Relevé des Sorties Export 2';
                Image = PrintReport;
                RunObject = Report "Relevé des Sorties Export 2";
            }
        }
    }
}
