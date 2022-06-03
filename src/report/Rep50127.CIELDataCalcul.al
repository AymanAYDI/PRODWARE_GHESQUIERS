report 50127 "PWD CIEL Data Calcul"
{
    Caption = 'CIEL Data Calcul';
    ProcessingOnly = true;
    UseRequestPage = true;
    dataset
    {
        dataitem("Personal Caption"; "PWD Personal Caption")
        {
            DataItemTableView = SORTING(Name);
            dataitem(Item; Item)
            {
                DataItemLink = "PWD CIEL Personal Caption" = FIELD(Name);
                DataItemTableView = SORTING("PWD CIEL Personal Caption");
                PrintOnlyIfDetail = true;
                dataitem(ItemLedgerEntryAcquitRight; "Item Ledger Entry")
                {
                    DataItemTableView = SORTING("Item No.", "Location Code", Open, "Variant Code", "Unit of Measure Code", "Lot No.", "Serial No.");
                    dataitem(ValueEntryAcquitRight; "Value Entry")
                    {
                        DataItemTableView = SORTING("Item Ledger Entry No.");

                        trigger OnAfterGetRecord()
                        begin
                            IF (DatGEndingDate <> 0D) AND ("Posting Date" > DatGEndingDate) THEN
                                CurrReport.SKIP();

                            DecGStartInvQty := 0;
                            DecGInputInvQty := 0;
                            DecGOutputInvQty := 0;

                            IF ("Posting Date" < DatGStartingDate) THEN BEGIN
                                DecGStartInvQty := "Invoiced Quantity";
                                IF (IntGmethodeAT = 1) THEN DecGStartInvQty := "Invoiced Quantity" * Item."Net Weight" / 100;
                                IF (IntGmethodeAT = 2) THEN DecGStartInvQty := "Invoiced Quantity" * Item."Net Weight" / 100;
                                IF (IntGmethodeAT = 3) THEN DecGStartInvQty := "Invoiced Quantity" * Item."Net Weight";

                            END ELSE
                                IF ("Item Ledger Entry Type" IN
                                   ["Item Ledger Entry Type"::Purchase,
                                    "Item Ledger Entry Type"::"Positive Adjmt.",
                                    "Item Ledger Entry Type"::Output])
                                THEN BEGIN
                                    DecGInputInvQty := "Invoiced Quantity";
                                    IF IntGmethodeAT = 1 THEN DecGInputInvQty := "Invoiced Quantity" * Item."Net Weight" / 100;
                                    IF IntGmethodeAT = 2 THEN DecGInputInvQty := "Invoiced Quantity" * Item."Net Weight" / 100;
                                    IF IntGmethodeAT = 3 THEN DecGInputInvQty := "Invoiced Quantity" * Item."Net Weight";

                                END ELSE BEGIN
                                    DecGOutputInvQty := -"Invoiced Quantity";
                                    IF IntGmethodeAT = 1 THEN DecGOutputInvQty := -"Invoiced Quantity" * Item."Net Weight" / 100;
                                    IF IntGmethodeAT = 2 THEN DecGOutputInvQty := -"Invoiced Quantity" * Item."Net Weight" / 100;
                                    IF IntGmethodeAT = 3 THEN DecGOutputInvQty := -"Invoiced Quantity" * Item."Net Weight";
                                END;

                            DecGQtyAcquitRight += DecGStartInvQty;
                            DecGInputAcquitRight += DecGInputInvQty;
                            DecGOutputAcquitRight += DecGOutputInvQty;
                        end;

                        trigger OnPreDataItem()
                        begin
                            SETRANGE("Item Ledger Entry No.", ItemLedgerEntryAcquitRight."Entry No.");
                            SETFILTER("Location Code", TxtGAcquitRightLocation);
                        end;
                    }

                    trigger OnAfterGetRecord()
                    begin
                        IntGCounter -= 1;
                        Bdialog.UPDATE(3, IntGCounter);

                        DecGInvQty := "Invoiced Quantity";

                        IF IntGmethodeAT = 1 THEN DecGInvQty := "Invoiced Quantity" * Item."Net Weight" / 100;
                        IF IntGmethodeAT = 2 THEN DecGInvQty := "Invoiced Quantity" * Item."Net Weight" / 100;
                        IF IntGmethodeAT = 3 THEN DecGInvQty := "Invoiced Quantity" * Item."Net Weight";

                        DecGQtyEndPeriodAcquitRight += DecGInvQty;
                    end;

                    trigger OnPreDataItem()
                    begin

                        SETRANGE("Item No.", Item."No.");
                        SETFILTER("Location Code", TxtGAcquitRightLocation);
                        SETRANGE("Posting Date", 0D, DatGEndingDate);

                        IntGCounter := COUNT;
                    end;
                }
                dataitem(ItemLedgerEntrySuspendRight; "Item Ledger Entry")
                {
                    DataItemTableView = SORTING("Item No.", "Location Code", Open, "Variant Code", "Unit of Measure Code", "Lot No.", "Serial No.");
                    dataitem(ValueEntrySuspendRight; "Value Entry")
                    {
                        DataItemTableView = SORTING("Item Ledger Entry No.");

                        trigger OnAfterGetRecord()
                        begin
                            IF (DatGEndingDate <> 0D) AND ("Posting Date" > DatGEndingDate) THEN
                                CurrReport.SKIP();

                            DecGStartInvQty := 0;
                            DecGInputInvQty := 0;
                            DecGOutputInvQty := 0;

                            IF ("Posting Date" < DatGStartingDate) THEN BEGIN
                                DecGStartInvQty := "Invoiced Quantity";
                                IF IntGmethodeAT = 1 THEN DecGStartInvQty := "Invoiced Quantity" * Item."Net Weight" / 100;
                                IF IntGmethodeAT = 2 THEN DecGStartInvQty := "Invoiced Quantity" * Item."Net Weight" / 100;
                                IF IntGmethodeAT = 3 THEN DecGStartInvQty := "Invoiced Quantity" * Item."Net Weight";

                            END ELSE
                                IF ("Item Ledger Entry Type" IN
                                   ["Item Ledger Entry Type"::Purchase,
                                    "Item Ledger Entry Type"::"Positive Adjmt.",
                                    "Item Ledger Entry Type"::Output])
                                THEN BEGIN
                                    DecGInputInvQty := "Invoiced Quantity";
                                    IF IntGmethodeAT = 1 THEN DecGInputInvQty := "Invoiced Quantity" * Item."Net Weight" / 100;
                                    IF IntGmethodeAT = 2 THEN DecGInputInvQty := "Invoiced Quantity" * Item."Net Weight" / 100;
                                    IF IntGmethodeAT = 3 THEN DecGInputInvQty := "Invoiced Quantity" * Item."Net Weight";

                                END ELSE BEGIN
                                    DecGOutputInvQty := -"Invoiced Quantity";
                                    IF IntGmethodeAT = 1 THEN DecGOutputInvQty := -"Invoiced Quantity" * Item."Net Weight" / 100;
                                    IF IntGmethodeAT = 2 THEN DecGOutputInvQty := -"Invoiced Quantity" * Item."Net Weight" / 100;
                                    IF IntGmethodeAT = 3 THEN DecGOutputInvQty := -"Invoiced Quantity" * Item."Net Weight";
                                END;

                            DecGQtySuspendRight += DecGStartInvQty;
                            DecGInputSuspendRight += DecGInputInvQty;
                            DecGOutputSuspendRight += DecGOutputInvQty;
                        end;

                        trigger OnPreDataItem()
                        begin
                            SETRANGE("Item Ledger Entry No.", ItemLedgerEntrySuspendRight."Entry No.");
                            SETFILTER("Location Code", TxtGSuspendRightLocation);
                        end;
                    }

                    trigger OnAfterGetRecord()
                    begin
                        IntGCounter -= 1;
                        Bdialog.UPDATE(4, IntGCounter);

                        DecGInvQty := "Invoiced Quantity";

                        IF IntGmethodeAT = 1 THEN DecGInvQty := "Invoiced Quantity" * Item."Net Weight" / 100;
                        IF IntGmethodeAT = 2 THEN DecGInvQty := "Invoiced Quantity" * Item."Net Weight" / 100;
                        IF IntGmethodeAT = 3 THEN DecGInvQty := "Invoiced Quantity" * Item."Net Weight";

                        DecGQtyEndPeriodSuspendRight += DecGInvQty;
                    end;

                    trigger OnPreDataItem()
                    begin

                        SETRANGE("Item No.", Item."No.");
                        SETFILTER("Location Code", TxtGSuspendRightLocation);
                        SETRANGE("Posting Date", 0D, DatGEndingDate);

                        IntGCounter := COUNT;
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    Bdialog.UPDATE(2, Item."No.");

                    IF (Item."PWD Family" = '') AND (Item."PWD Family (Sea France)" = '') THEN
                        CurrReport.SKIP()
                    ELSE
                        IF RecGItemFamille.GET(RecGItemFamille.Type::Item, RecGItemFamille."Group Type"::Family, '', Item."PWD Family")
                        THEN BEGIN
                            IF RecGItemFamille."Type famille" = RecGItemFamille."Type famille"::" " THEN
                                CurrReport.SKIP()
                        END ELSE
                            IF RecGItemFamille.GET(RecGItemFamille.Type::Item, RecGItemFamille."Group Type"::Family, '', Item."PWD Family (Sea France)") THEN
                                IF RecGItemFamille."Type famille" = RecGItemFamille."Type famille"::" " THEN CurrReport.SKIP();

                    IntGmethodeAT := 0;

                    IF RecGItemFamille.GET(RecGItemFamille.Type::Item, RecGItemFamille."Group Type"::Family, '', Item."PWD Family") THEN BEGIN
                        IF (RecGItemFamille."Type famille" = RecGItemFamille."Type famille"::Alcool) AND
                           (RecGItemFamille."Mode de calcul AT" = RecGItemFamille."Mode de calcul AT"::"Poids Net") THEN
                            IntGmethodeAT := 1;
                        IF (RecGItemFamille."Type famille" = RecGItemFamille."Type famille"::Alcool) AND
                           (RecGItemFamille."Mode de calcul AT" = RecGItemFamille."Mode de calcul AT"::"Poids Net x °Alcool") THEN
                            IntGmethodeAT := 2;
                        IF (RecGItemFamille."Type famille" = RecGItemFamille."Type famille"::Tabac) AND
                           (RecGItemFamille."Mode de calcul AT" = RecGItemFamille."Mode de calcul AT"::"Poids Net") THEN
                            IntGmethodeAT := 3;
                    END ELSE
                        IF RecGItemFamille.GET(RecGItemFamille.Type::Item, RecGItemFamille."Group Type"::Family, '', Item."PWD Family (Sea France)") THEN BEGIN
                            IF (RecGItemFamille."Type famille" = RecGItemFamille."Type famille"::Alcool) AND
                               (RecGItemFamille."Mode de calcul AT" = RecGItemFamille."Mode de calcul AT"::"Poids Net") THEN
                                IntGmethodeAT := 1;
                            IF (RecGItemFamille."Type famille" = RecGItemFamille."Type famille"::Alcool) AND
                               (RecGItemFamille."Mode de calcul AT" = RecGItemFamille."Mode de calcul AT"::"Poids Net x °Alcool") THEN
                                IntGmethodeAT := 2;
                            IF (RecGItemFamille."Type famille" = RecGItemFamille."Type famille"::Tabac) AND
                               (RecGItemFamille."Mode de calcul AT" = RecGItemFamille."Mode de calcul AT"::"Poids Net") THEN
                                IntGmethodeAT := 3;
                        END;
                end;

                trigger OnPostDataItem()
                begin
                    IF (DecGQtyAcquitRight <> 0) OR
                       (DecGInputAcquitRight <> 0) OR
                       (DecGOutputAcquitRight <> 0) OR
                       (DecGQtyEndPeriodAcquitRight <> 0) THEN BEGIN
                        RecGCIELData.INIT();
                        RecGCIELData."Location Filter" := TxtGAcquitRightLocation;
                        RecGCIELData."Personnal Caption" := "Personal Caption".Name;
                        RecGCIELData.Month := IntGMonth;
                        RecGCIELData.Year := IntGyear;
                        RecGCIELData."Right Type" := RecGCIELData."Right Type"::"Value acquittees";
                        RecGCIELData."Fiscal Caption" := "Personal Caption"."Fiscal Caption";
                        RecGCIELData."Rate Of Alcohol By Volume" := "Personal Caption"."Rate Of Alcohol By Volume";
                        RecGCIELData."Begin Period Stock" := DecGQtyAcquitRight;
                        RecGCIELData.Purchase := DecGInputAcquitRight;
                        RecGCIELData.Sales := DecGOutputAcquitRight;
                        RecGCIELData."Suspension Replacement" := 0;
                        RecGCIELData."End Period Stock" := DecGQtyEndPeriodAcquitRight;
                        RecGCIELData."Item Volume" := 0;
                        RecGCIELData."Item Suspended Rights" := DecGInputAcquitRight;
                        RecGCIELData."Input Work With Way" := 0;
                        RecGCIELData."Output With Current Year Paym" := 0;
                        RecGCIELData."Definitive Output" := DecGOutputAcquitRight;
                        RecGCIELData."Exemption Rights" := 0;
                        RecGCIELData."Output Work With Way" := 0;
                        RecGCIELData."Other Item Production" := 0;
                        RecGCIELData."Distil Wine Lees" := 0;
                        RecGCIELData.INSERT();
                    END;

                    IF (DecGQtySuspendRight <> 0) OR
                       (DecGInputSuspendRight <> 0) OR
                       (DecGOutputSuspendRight <> 0) OR
                       (DecGQtyEndPeriodSuspendRight <> 0) THEN BEGIN
                        RecGCIELData.INIT();
                        RecGCIELData."Location Filter" := TxtGSuspendRightLocation;
                        RecGCIELData."Personnal Caption" := "Personal Caption".Name;
                        RecGCIELData.Month := IntGMonth;
                        RecGCIELData.Year := IntGyear;
                        RecGCIELData."Right Type" := RecGCIELData."Right Type"::"Value suspended";
                        RecGCIELData."Fiscal Caption" := "Personal Caption"."Fiscal Caption";
                        RecGCIELData."Rate Of Alcohol By Volume" := "Personal Caption"."Rate Of Alcohol By Volume";
                        RecGCIELData."Begin Period Stock" := DecGQtySuspendRight;
                        RecGCIELData.Purchase := DecGInputSuspendRight;
                        RecGCIELData.Sales := DecGOutputSuspendRight;
                        RecGCIELData."Suspension Replacement" := 0;
                        RecGCIELData."End Period Stock" := DecGQtyEndPeriodSuspendRight;
                        RecGCIELData."Item Volume" := 0;
                        RecGCIELData."Item Suspended Rights" := DecGInputSuspendRight;
                        RecGCIELData."Input Work With Way" := 0;
                        RecGCIELData."Output With Current Year Paym" := 0;
                        RecGCIELData."Definitive Output" := DecGOutputSuspendRight;
                        RecGCIELData."Exemption Rights" := 0;
                        RecGCIELData."Output Work With Way" := 0;
                        RecGCIELData."Other Item Production" := 0;
                        RecGCIELData."Distil Wine Lees" := 0;
                        RecGCIELData.INSERT();
                    END;
                end;

                trigger OnPreDataItem()
                begin
                    DecGQtyAcquitRight := 0;
                    DecGInputAcquitRight := 0;
                    DecGOutputAcquitRight := 0;
                    DecGQtyEndPeriodAcquitRight := 0;
                    DecGQtySuspendRight := 0;
                    DecGInputSuspendRight := 0;
                    DecGOutputSuspendRight := 0;
                    DecGQtyEndPeriodSuspendRight := 0;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                Bdialog.UPDATE(1, "Personal Caption".Name);
            end;

            trigger OnPostDataItem()
            begin
                Bdialog.CLOSE();
                MESSAGE(CstG004);
            end;

            trigger OnPreDataItem()
            begin
                Bdialog.OPEN(CstG001);
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                group("Options de Filtrage")
                {
                    Caption = 'Options de Filtrage';
                    field(IntGyear; IntGyear)
                    {
                        Caption = 'Year';
                        ApplicationArea = All;
                    }
                    field(IntGMonth; IntGMonth)
                    {
                        Caption = 'Month';
                        ApplicationArea = All;
                    }
                    field(TxtGAcquitRightLocation; TxtGAcquitRightLocation)
                    {
                        Caption = 'Acquits Rights Location';
                        ApplicationArea = All;
                    }
                    field(TxtGSuspendRightLocation; TxtGSuspendRightLocation)
                    {
                        Caption = 'Suspended Rights Location';
                        ApplicationArea = All;
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            IntGyear := DATE2DMY(WORKDATE(), 3);
            IntGMonth := DATE2DMY(WORKDATE(), 2);

            RecGCompanyInformation.GET();

            TxtGAcquitRightLocation := RecGCompanyInformation."PWD LocationRightAcquitFilter";
            TxtGSuspendRightLocation := RecGCompanyInformation."PWD Loc.RightSuspendedFilter";
        end;
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        IF IntGyear = 0 THEN
            ERROR(CstG002);
        IF (IntGMonth < 1) OR (IntGMonth > 12) THEN
            ERROR(CstG003);

        DatGStartingDate := DMY2DATE(1, IntGMonth, IntGyear);
        IF IntGMonth = 12 THEN
            DatGEndingDate := CALCDATE('<-1D>', DMY2DATE(1, 1, IntGyear + 1))
        ELSE
            DatGEndingDate := CALCDATE('<-1D>', DMY2DATE(1, IntGMonth + 1, IntGyear));
    end;

    var
        RecGCompanyInformation: Record "Company Information";
        RecGCIELData: Record "PWD CIEL Data";
        RecGItemFamille: Record "PWD Family & Sub Family";
        DatGEndingDate: Date;
        DatGStartingDate: Date;
        DecGInputAcquitRight: Decimal;
        DecGInputInvQty: Decimal;
        DecGInputSuspendRight: Decimal;
        DecGInvQty: Decimal;
        DecGOutputAcquitRight: Decimal;
        DecGOutputInvQty: Decimal;
        DecGOutputSuspendRight: Decimal;
        DecGQtyAcquitRight: Decimal;
        DecGQtyEndPeriodAcquitRight: Decimal;
        DecGQtyEndPeriodSuspendRight: Decimal;
        DecGQtySuspendRight: Decimal;
        DecGStartInvQty: Decimal;
        Bdialog: Dialog;
        IntGCounter: Integer;
        IntGmethodeAT: Integer;
        IntGMonth: Integer;
        IntGyear: Integer;
        CstG001: Label 'Libellé personnalisé #1##########\Article #2##########\Ecriture droits acquits #3##########\Ecriture droits suspendus #4##########\';
        CstG002: Label 'You must specify a year';
        CstG003: Label 'You must specify a month';
        CstG004: Label 'Calcul finish !';
        TxtGAcquitRightLocation: Text[100];
        TxtGSuspendRightLocation: Text[100];
}
