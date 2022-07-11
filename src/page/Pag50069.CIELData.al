page 50069 "PWD CIEL Data"
{
    // -----------------------------------------------------------------------------------------------------------------
    // Prodware - www.prodware.fr
    // -----------------------------------------------------------------------------------------------------------------
    //
    // //>>NDBI (P25940_002)
    // LALE.RO : 03/09/2018 : cf NDBI ID 437
    //                        new Page

    Caption = 'CIEL Data';
    InsertAllowed = false;
    PageType = List;
    SourceTable = "PWD CIEL Data";
    ApplicationArea = all;
    UsageCategory = Tasks;
    layout
    {
        area(content)
        {
            repeater(Data)
            {
                Caption = 'Data';
                Editable = BooGModify;
                field("Location Filter"; Rec."Location Filter")
                {
                    ApplicationArea = All;
                }
                field("Personnal Caption"; Rec."Personnal Caption")
                {
                    ApplicationArea = All;
                }
                field(Month; Rec.Month)
                {
                    ApplicationArea = All;
                }
                field(Year; Rec.Year)
                {
                    ApplicationArea = All;
                }
                field("Right Type"; Rec."Right Type")
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
                field(Observation; Rec.Observation)
                {
                    ApplicationArea = All;
                }
                field("Begin Period Stock"; Rec."Begin Period Stock")
                {
                    DecimalPlaces = 0 : 5;
                    ApplicationArea = All;
                }
                field(Purchase; Rec.Purchase)
                {
                    DecimalPlaces = 0 : 5;
                    ApplicationArea = All;
                }
                field(Sales; Rec.Sales)
                {
                    DecimalPlaces = 0 : 5;
                    ApplicationArea = All;
                }
                field("Suspension Replacement"; Rec."Suspension Replacement")
                {
                    DecimalPlaces = 0 : 5;
                    ApplicationArea = All;
                }
                field("End Period Stock"; Rec."End Period Stock")
                {
                    DecimalPlaces = 0 : 5;
                    ApplicationArea = All;
                }
                field("Item Volume"; Rec."Item Volume")
                {
                    DecimalPlaces = 0 : 5;
                    ApplicationArea = All;
                }
                field("Item Suspended Rights"; Rec."Item Suspended Rights")
                {
                    DecimalPlaces = 0 : 5;
                    ApplicationArea = All;
                }
                field("Input Work With Way"; Rec."Input Work With Way")
                {
                    DecimalPlaces = 0 : 5;
                    ApplicationArea = All;
                }
                field("Output With Current Year Paym"; Rec."Output With Current Year Paym")
                {
                    DecimalPlaces = 0 : 5;
                    ApplicationArea = All;
                }
                field("Definitive Output"; Rec."Definitive Output")
                {
                    DecimalPlaces = 0 : 5;
                    ApplicationArea = All;
                }
                field("Exemption Rights"; Rec."Exemption Rights")
                {
                    DecimalPlaces = 0 : 5;
                    ApplicationArea = All;
                }
                field("Output Work With Way"; Rec."Output Work With Way")
                {
                    DecimalPlaces = 0 : 5;
                    ApplicationArea = All;
                }
                field("Other Item Production"; Rec."Other Item Production")
                {
                    DecimalPlaces = 0 : 5;
                    ApplicationArea = All;
                }
                field("Distil Wine Lees"; Rec."Distil Wine Lees")
                {
                    DecimalPlaces = 0 : 5;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Process)
            {
                Caption = 'Calculate Datas';
                Image = Refresh;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                var
                    RepLCIELDataCalcul: Report "PWD CIEL Data Calcul";
                begin
                    IF Rec.GET('', '') THEN Rec.DELETE();

                    IF Rec.FINDFIRST() THEN
                        IF NOT CONFIRM(CstG002, FALSE) THEN
                            ERROR(CstG003)
                        ELSE
                            Rec.DELETEALL();

                    COMMIT();

                    RepLCIELDataCalcul.RUNMODAL();
                end;
            }
            action(Export)
            {
                Caption = 'Export Datas';
                Image = Export;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                var
                    RepLExportCIEL: Report "PWD Export CIEL";
                begin
                    IF Rec.FINDFIRST() THEN BEGIN
                        IF NOT CONFIRM(CstG004, FALSE) THEN
                            ERROR(CstG003)
                        ELSE
                            //RepLExportCIEL.RUNMODAL();
                            Xmlport.Run(50000, false, false);
                    END ELSE
                        ERROR(CstG005);
                end;
            }
            action(Modify)
            {
                Caption = 'Modify';
                Enabled = BooGView;
                Image = Edit;
                Promoted = true;
                PromotedIsBig = true;
                ApplicationArea = All;
                PromotedOnly = true;
                trigger OnAction()
                begin
                    BooGModify := TRUE;
                    BooGView := FALSE;
                    CurrPage.UPDATE();
                end;
            }
            action(View)
            {
                Caption = 'Afficher';
                Enabled = BooGModify;
                Image = View;
                Promoted = true;
                PromotedIsBig = true;
                ApplicationArea = All;
                PromotedOnly = true;
                trigger OnAction()
                begin
                    BooGModify := FALSE;
                    BooGView := TRUE;
                    CurrPage.UPDATE();
                end;
            }
            action(Check)
            {
                Caption = 'Apurement fin de mois V2';
                Image = Reconcile;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                RunObject = Report "PWD Apurement fin de mois V2";
                ApplicationArea = All;
            }
        }
    }

    trigger OnOpenPage()
    begin
        IF Rec.GET('', '') THEN Rec.DELETE();

        IF Rec.FINDLAST() THEN
            IF CONFIRM(CstG001, FALSE) THEN
                Rec.DELETEALL();

        BooGModify := FALSE;
        BooGView := TRUE;
    end;

    var
        [InDataSet]
        BooGModify: Boolean;
        [InDataSet]
        BooGView: Boolean;
        CstG001: Label 'Lines already exist.\Do you want to delete them before open the page ?';
        CstG002: Label 'Lines already exist.\This lines will be delete.\Do you want to continue the calcul ?';
        CstG003: Label 'Cancel !';
        CstG004: Label 'Do you want to create the EDI DTI+ CIEL file ?';
        CstG005: Label 'Table is empty !';
}
