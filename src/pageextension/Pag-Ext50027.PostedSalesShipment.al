pageextension 50027 "PWD PostedSalesShipment" extends "Posted Sales Shipment"
{
    layout
    {
        addafter("No.")
        {
            field("PWD Call No."; Rec."PWD Call No.")
            {
                ApplicationArea = all;
                Editable = false;
            }
        }
        addafter("No. Printed")
        {
            field("PWD Reference"; Rec."PWD Reference")
            {
                ApplicationArea = all;
                Editable = false;
            }
            field("PWD Seafrance Order No."; Rec."PWD Seafrance Order No.")
            {
                ApplicationArea = All;
            }
        }
        addafter("Order No.")
        {
            field("PWD Shipping Time"; Rec."Shipping Time")
            {
                ApplicationArea = all;
            }
        }
        addafter("Bill-to Contact No.")
        {
            field("PWD Bill-to Additional name"; Rec."PWD Bill-to Additional name")
            {
                ApplicationArea = all;
            }
            field("PWD Bill-to C/O"; Rec."PWD Bill-to C/O")
            {
                ApplicationArea = All;
            }
        }
        addafter("Bill-to Name")
        {
            field("PWD Bill-to Name 2"; Rec."Bill-to Name 2")
            {
                ApplicationArea = all;
            }
        }
        addlast("Shipping")
        {
            /*field("PWD Douane"; "PWD Douane")
            {
                ApplicationArea = all;
            }*/
            field("PWD DSA No."; Rec."PWD DSA No.")
            {
                ApplicationArea = all;
            }
            field("PWD No. T1"; Rec."PWD No. T1")
            {
                ApplicationArea = All;
            }
            field("PWD No. TM"; Rec."PWD No. TM")
            {
                ApplicationArea = All;
            }
            field("PWD Liste de chargement"; Rec."PWD Liste de chargement")
            {
                ApplicationArea = All;
            }
            field("PWD Transaction Type"; Rec."Transaction Type")
            {
                ApplicationArea = all;
            }
            field("PWD Transport Method"; Rec."Transport Method")
            {
                ApplicationArea = all;
            }
            field("PWD Transaction Specification"; Rec."Transaction Specification")
            {
                ApplicationArea = all;
            }
        }
    }
    actions
    {
        addafter(Approvals)
        {
            action("PWD PrintHealthCertificate")
            {
                ApplicationArea = all;
                Caption = 'Print Health Certificate';
                Image = Certificate;
                RunObject = Page "PWD Lignes Doc Douane";
                RunPageLink = "Document Type" = CONST("S.Shipment"),
                                  "Document No." = FIELD("No."),
                                  "Customs Document Type" = CONST(T5);
            }
            separator(separator)
            {
            }
            action("PWD Line")
            {
                ApplicationArea = all;
                Caption = 'lignes T5';
                Image = AllLines;
                RunObject = Page "PWD Lignes Doc Douane";
                RunPageLink = "Document Type" = CONST("S.Shipment"),
                                  "Document No." = FIELD("No."),
                                  "Customs Document Type" = CONST(T5);
                Trigger OnAction()
                VAR
                    CalcT5: Codeunit "PWD Edit T5";
                BEGIN
                    CurrPage.SETSELECTIONFILTER(SalesShptHeader);
                    CLEAR(CalcT5);
                    CalcT5.RUN(SalesShptHeader);
                END;
            }
            Action("Loading List")
            {
                Caption = 'Listes de chargement';
                Image = ListPage;
                RunObject = Page "PWD Listes de chargement";
                RunPageLink = "Sales Ship. No." = FIELD("No.");
                ApplicationArea = all;
            }
        }
        addafter("F&unctions")
        {
            group("PWD Imprimer")
            {
                Caption = 'Imprimer';
                action("PWD Delivery note")
                {
                    ApplicationArea = all;
                    Caption = 'Delivery note';
                    Image = PrintReport;
                    Trigger OnAction()
                    BEGIN
                        SalesShptHeader := Rec;
                        SalesShptHeader.SETRECFILTER();
                        REPORT.RUN(Report::"Sales - Shipment BL bac blanc", FALSE, FALSE, SalesShptHeader);
                    END;
                }
                action("PWD Bon d'Avitaillement")
                {
                    ApplicationArea = all;
                    Caption = 'Bon d''Avitaillement';//;
                    Image = PrintReport;
                    Trigger OnAction()
                    var
                        DataCompression: Codeunit "Data Compression";
                    BEGIN
                        SalesShptHeader := Rec;
                        SalesShptHeader.SETRECFILTER();
                        Rec.CreateZipFolderReports(SalesShptHeader, DataCompression);
                        // REPORT.RunModal(Report::"Sales - Shipmt BLAVI bac blanc", FALSE, FALSE, SalesShptHeader);
                        // REPORT.RunModal(Report::"Sales - Shipmt BLAVI bac rose", FALSE, FALSE, SalesShptHeader);

                    END;
                }
                Action("PWD DAA")
                {
                    ApplicationArea = all;
                    Caption = 'DAA';
                    Image = PrintReport;
                    trigger OnAction()
                    BEGIN
                        SalesShptHeader := Rec;
                        SalesShptHeader.SETRECFILTER();
                        REPORT.RUN(Report::"Sales - Shipment AVITA - DAA", TRUE, FALSE, SalesShptHeader);
                    END;
                }
                Action("PWD DSA")
                {
                    Caption = 'DSA';
                    Image = PrintReport;
                    ApplicationArea = All;
                    Trigger OnAction()
                    BEGIN
                        SalesShptHeader := Rec;
                        SalesShptHeader.SETRECFILTER();
                        REPORT.RUN(50108, TRUE, FALSE, SalesShptHeader);
                    END;
                }
                Action("PWD T5")
                {
                    Caption = 'T5';
                    ApplicationArea = All;
                    Image = Print;
                    Trigger OnAction()
                    BEGIN
                        CurrPage.SETSELECTIONFILTER(SalesShptHeader);
                        CLEAR(PWDCduFunctionMgt);
                        PWDCduFunctionMgt.PrintT5(Rec);
                    END;
                }
                Action("PWD T1")
                {
                    Caption = 'T1';
                    ApplicationArea = All;
                    Image = Print;
                    Trigger OnAction()
                    BEGIN
                        CurrPage.SETSELECTIONFILTER(SalesShptHeader);
                        CLEAR(PWDCduFunctionMgt);
                        PWDCduFunctionMgt.PrintT1(Rec);
                    END;
                }
                // Action("PWD Certificat d''origine")
                // {
                //     ApplicationArea = all;
                //     Caption = 'Certificat d''origine';
                //     Image = Certificate;
                //     Trigger OnAction()
                //     BEGIN
                //         CurrPage.SETSELECTIONFILTER(SalesShptHeader);
                //         SalesShptHeader.PrintCustomsDoc(CstG001);
                //     END;
                // }
                // Action("PWD Liste de chargement simple")
                // {
                //     Caption = 'Liste de chargement simple';
                //     Image = Print;
                //     ApplicationArea = All;

                //     trigger OnAction()
                //     BEGIN
                //         CurrPage.SETSELECTIONFILTER(SalesShptHeader);
                //         SalesShptHeader.PrintCustomsDoc(CstG002);
                //     END;
                // }
                // Action("PWD Load/Store List")
                // {
                //     Caption = 'Liste de chargement/magasin';
                //     Image = Print;
                //     ApplicationArea = All;

                //     Trigger OnAction()
                //     BEGIN
                //         CurrPage.SETSELECTIONFILTER(SalesShptHeader);
                //         SalesShptHeader.PrintCustomsDoc(CstG003);
                //     END;
                // }
                // Action("PWD Liste de chargement TM")
                // {
                //     Caption = 'Liste de chargement (TM)';
                //     ApplicationArea = All;
                //     Image = Print;
                //     Trigger OnAction()
                //     BEGIN
                //         CurrPage.SETSELECTIONFILTER(SalesShptHeader);
                //         SalesShptHeader.PrintCustomsDoc(CstG004);
                //     END;
                // }
                // Action("PWD Mutation")
                // {
                //     Caption = 'Mutation';
                //     Image = Print;
                //     ApplicationArea = All;
                //     trigger OnAction()
                //     BEGIN
                //         CurrPage.SETSELECTIONFILTER(SalesShptHeader);
                //         SalesShptHeader.PrintCustomsDoc(CstG005);
                //     END;
                // }
                Action("PWD TM")
                {
                    Caption = 'TM';
                    ApplicationArea = All;
                    Image = Print;
                    Trigger OnAction()
                    BEGIN
                        CurrPage.SETSELECTIONFILTER(SalesShptHeader);
                        CLEAR(PWDCduFunctionMgt);
                        PWDCduFunctionMgt.PrintTM(Rec);
                    END;
                }
                // Action("PWD Classic Print")
                // {
                //     ApplicationArea = all;
                //     Caption = 'Impression classique';
                //     Image = Print;
                //     Trigger OnAction()
                //     VAR
                //         RepLShipmentHeader: Record "Sales Shipment Header";
                //     BEGIN
                //         RepLShipmentHeader.SETRANGE("No.", Rec."No.");
                //         REPORT.RUN(50119, TRUE, TRUE, RepLShipmentHeader);
                //     END;
                // }
                Group("PWD Exemplaire 3")
                {
                    Caption = 'Exemplaire 3';
                    Action(EX1)
                    {
                        Caption = 'EX1';
                        Image = Print;
                        ApplicationArea = All;
                        Trigger OnAction()
                        BEGIN
                            CurrPage.SETSELECTIONFILTER(SalesShptHeader);
                            CLEAR(PWDCduFunctionMgt);
                            PWDCduFunctionMgt.PrintEX1(Rec);
                        END;
                    }
                    Action("PWD COM9")
                    {
                        Caption = 'COM9';
                        ApplicationArea = All;
                        Image = Print;
                        Trigger OnAction()
                        BEGIN
                            CurrPage.SETSELECTIONFILTER(SalesShptHeader);
                            CLEAR(PWDCduFunctionMgt);
                            PWDCduFunctionMgt.PrintCOM9(Rec);
                        END;
                    }
                    Action("PWD EX9")
                    {
                        Caption = 'EX9';
                        ApplicationArea = All;
                        Image = Print;
                        Trigger OnAction()
                        BEGIN
                            CurrPage.SETSELECTIONFILTER(SalesShptHeader);
                            CLEAR(PWDCduFunctionMgt);
                            PWDCduFunctionMgt.PrintEX9(Rec);
                        END;
                    }
                }
            }
        }
    }

    var
        SalesShptHeader: Record "Sales Shipment Header";
        PWDCduFunctionMgt: Codeunit "PWD Function Mgt";
        CstG001: label 'CO';
        CstG002: label 'CHARSIMPLE';
        CstG003: label 'CHARGEMENT';
        CstG004: label 'CHARTM';
        CstG005: label 'MUTATION';
}
