report 50022 "PWD Export Microsoft Excel"
{
    Caption = 'PWD Export Microsoft Excel';
    ProcessingOnly = true;
    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            column(AllowLineDisc; "Allow Line Disc.")
            {
            }
            column(Amount; Amount)
            {
            }
            column(AmountIncludingVAT; "Amount Including VAT")
            {
            }
            column(AmtShipNotInvLCY; "Amt. Ship. Not Inv. (LCY)")
            {
            }
            column(AmtShipNotInvLCYBase; "Amt. Ship. Not Inv. (LCY) Base")
            {
            }
            column(AppliestoDocNo; "Applies-to Doc. No.")
            {
            }
            column(AppliestoDocType; "Applies-to Doc. Type")
            {
            }
            column(AppliestoID; "Applies-to ID")
            {
            }
            /*column(Area; "Area")
            {
            }*/
            column(AssignedUserID; "Assigned User ID")
            {
            }
            column(BalAccountNo; "Bal. Account No.")
            {
            }
            column(BalAccountType; "Bal. Account Type")
            {
            }
            column(BilltoAddress; "Bill-to Address")
            {
            }
            column(BilltoAddress2; "Bill-to Address 2")
            {
            }
            column(BilltoCity; "Bill-to City")
            {
            }
            column(BilltoContact; "Bill-to Contact")
            {
            }
            column(BilltoContactNo; "Bill-to Contact No.")
            {
            }
            column(BilltoCountryRegionCode; "Bill-to Country/Region Code")
            {
            }
            column(BilltoCounty; "Bill-to County")
            {
            }
            column(BilltoCustomerNo; "Bill-to Customer No.")
            {
            }
            column(BilltoCustomerTemplCode; "Bill-to Customer Templ. Code")
            {
            }
            column(BilltoCustomerTemplateCode; "Bill-to Customer Template Code")
            {
            }
            column(BilltoICPartnerCode; "Bill-to IC Partner Code")
            {
            }
            column(BilltoName; "Bill-to Name")
            {
            }
            column(BilltoName2; "Bill-to Name 2")
            {
            }
            column(BilltoPostCode; "Bill-to Post Code")
            {
            }
            column(CampaignNo; "Campaign No.")
            {
            }
            column(CombineShipments; "Combine Shipments")
            {
            }
            column(Comment; Comment)
            {
            }
            column(CompletelyShipped; "Completely Shipped")
            {
            }
            column(CompressPrepayment; "Compress Prepayment")
            {
            }
            column(Correction; Correction)
            {
            }
            column(CurrencyCode; "Currency Code")
            {
            }
            column(CurrencyFactor; "Currency Factor")
            {
            }
            column(CustomerDiscGroup; "Customer Disc. Group")
            {
            }
            column(CustomerPostingGroup; "Customer Posting Group")
            {
            }
            column(CustomerPriceGroup; "Customer Price Group")
            {
            }
            column(DimensionSetID; "Dimension Set ID")
            {
            }
            column(DirectDebitMandateID; "Direct Debit Mandate ID")
            {
            }
            column(DocNoOccurrence; "Doc. No. Occurrence")
            {
            }
            column(DocumentDate; "Document Date")
            {
            }
            column(DocumentType; "Document Type")
            {
            }
            column(DueDate; "Due Date")
            {
            }
            column(EU3PartyTrade; "EU 3-Party Trade")
            {
            }
            column(ExitPoint; "Exit Point")
            {
            }
            column(ExternalDocumentNo; "External Document No.")
            {
            }
            column(GenBusPostingGroup; "Gen. Bus. Posting Group")
            {
            }
            column(GetShipmentUsed; "Get Shipment Used")
            {
            }
            column(ICDirection; "IC Direction")
            {
            }
            column(ICStatus; "IC Status")
            {
            }
            column(Id; Id)
            {
            }
            column(IncomingDocumentEntryNo; "Incoming Document Entry No.")
            {
            }
            column(Invoice; Invoice)
            {
            }
            column(InvoiceDiscCode; "Invoice Disc. Code")
            {
            }
            column(InvoiceDiscountAmount; "Invoice Discount Amount")
            {
            }
            column(InvoiceDiscountCalculation; "Invoice Discount Calculation")
            {
            }
            column(InvoiceDiscountValue; "Invoice Discount Value")
            {
            }
            column(IsTest; IsTest)
            {
            }
            column(JobQueueEntryID; "Job Queue Entry ID")
            {
            }
            column(JobQueueStatus; "Job Queue Status")
            {
            }
            column(LanguageCode; "Language Code")
            {
            }
            column(LastEmailNotifCleared; "Last Email Notif Cleared")
            {
            }
            column(LastEmailSentStatus; "Last Email Sent Status")
            {
            }
            column(LastEmailSentTime; "Last Email Sent Time")
            {
            }
            column(LastPostingNo; "Last Posting No.")
            {
            }
            column(LastPrepaymentNo; "Last Prepayment No.")
            {
            }
            column(LastPrepmtCrMemoNo; "Last Prepmt. Cr. Memo No.")
            {
            }
            column(LastReturnReceiptNo; "Last Return Receipt No.")
            {
            }
            column(LastShipmentDate; "Last Shipment Date")
            {
            }
            column(LastShippingNo; "Last Shipping No.")
            {
            }
            column(LateOrderShipping; "Late Order Shipping")
            {
            }
            column(LocationCode; "Location Code")
            {
            }
            column(No; "No.")
            {
            }
            column(NoPrinted; "No. Printed")
            {
            }
            column(NoSeries; "No. Series")
            {
            }
            column(NoofArchivedVersions; "No. of Archived Versions")
            {
            }
            column(OnHold; "On Hold")
            {
            }
            column(OpportunityNo; "Opportunity No.")
            {
            }
            column(OrderClass; "Order Class")
            {
            }
            column(OrderDate; "Order Date")
            {
            }
            column(OutboundWhseHandlingTime; "Outbound Whse. Handling Time")
            {
            }
            column(PWDBilltoAdditionalname; "PWD Bill-to Additional name")
            {
            }
            column(PWDBilltoCO; "PWD Bill-to C/O")
            {
            }
            column(PWDCallNo; "PWD Call No.")
            {
            }
            column(PWDCallType; "PWD Call Type")
            {
            }
            column(PWDCommentaire1; "PWD Commentaire 1")
            {
            }
            column(PWDCommentaire2; "PWD Commentaire 2")
            {
            }
            column(PWDCommentaire3; "PWD Commentaire 3")
            {
            }
            column(PWDCommentaire4; "PWD Commentaire 4")
            {
            }
            column(PWDCommentaire5; "PWD Commentaire 5")
            {
            }
            column(PWDDSANo; "PWD DSA No.")
            {
            }
            column(PWDDeliverytime; "PWD Delivery time")
            {
            }
            column(PWDDiscountProfit; "PWD Discount Profit %")
            {
            }
            column(PWDFilingReason; "PWD Filing Reason")
            {
            }
            column(PWDKPI; "PWD KPI")
            {
            }
            column(PWDLivraisonOK; "PWD Livraison OK")
            {
            }
            column(PWDMonthlyCode; "PWD Monthly Code")
            {
            }
            column(PWDNepasutiliserNodeDSA; "PWD Ne pas utiliser No. de DSA")
            {
            }
            column(PWDOrderPrepared; "PWD Order Prepared")
            {
            }
            column(PWDOrderTradingBrand; "PWD Order Trading Brand")
            {
            }
            column(PWDOrdertoadjust; "PWD Order to adjust")
            {
            }
            column(PWDPersonNumber; "PWD Person Number")
            {
            }
            column(PWDPreparationStatus; "PWD Preparation Status")
            {
            }
            column(PWDPreparationinprocess; "PWD Preparation in process")
            {
            }
            column(PWDPrestaFacturableparfourniss; "PWD Presta Facturable par fourniss")
            {
            }
            column(PWDReadytoship; "PWD Ready to ship")
            {
            }
            column(PWDReference; "PWD Reference")
            {
            }
            column(PWDSeafranceOrderNo; "PWD Seafrance Order No.")
            {
            }
            column(PWDTradingBrand; "PWD Trading Brand")
            {
            }
            column(PWDUserId; "PWD User Id")
            {
            }
            column(PackageTrackingNo; "Package Tracking No.")
            {
            }
            column(PaymentDiscount; "Payment Discount %")
            {
            }
            column(PaymentInstructionsId; "Payment Instructions Id")
            {
            }
            column(PaymentMethodCode; "Payment Method Code")
            {
            }
            column(PaymentServiceSetID; "Payment Service Set ID")
            {
            }
            column(PaymentTermsCode; "Payment Terms Code")
            {
            }
            column(PmtDiscountDate; "Pmt. Discount Date")
            {
            }
            column(PostingDate; "Posting Date")
            {
            }
            column(PostingDescription; "Posting Description")
            {
            }
            column(PostingNo; "Posting No.")
            {
            }
            column(PostingNoSeries; "Posting No. Series")
            {
            }
            column(PostingfromWhseRef; "Posting from Whse. Ref.")
            {
            }
            column(Prepayment; "Prepayment %")
            {
            }
            column(PrepaymentDueDate; "Prepayment Due Date")
            {
            }
            column(PrepaymentNo; "Prepayment No.")
            {
            }
            column(PrepaymentNoSeries; "Prepayment No. Series")
            {
            }
            column(PrepmtCrMemoNo; "Prepmt. Cr. Memo No.")
            {
            }
            column(PrepmtCrMemoNoSeries; "Prepmt. Cr. Memo No. Series")
            {
            }
            column(PrepmtPaymentDiscount; "Prepmt. Payment Discount %")
            {
            }
            column(PrepmtPaymentTermsCode; "Prepmt. Payment Terms Code")
            {
            }
            column(PrepmtPmtDiscountDate; "Prepmt. Pmt. Discount Date")
            {
            }
            column(PrepmtPostingDescription; "Prepmt. Posting Description")
            {
            }
            column(PriceCalculationMethod; "Price Calculation Method")
            {
            }
            column(PricesIncludingVAT; "Prices Including VAT")
            {
            }
            column(PrintPostedDocuments; "Print Posted Documents")
            {
            }
            column(PromisedDeliveryDate; "Promised Delivery Date")
            {
            }
            column(QuoteAccepted; "Quote Accepted")
            {
            }
            column(QuoteAcceptedDate; "Quote Accepted Date")
            {
            }
            column(QuoteNo; "Quote No.")
            {
            }
            column(QuoteSenttoCustomer; "Quote Sent to Customer")
            {
            }
            column(QuoteValidUntilDate; "Quote Valid Until Date")
            {
            }
            column(ReasonCode; "Reason Code")
            {
            }
            column(RecalculateInvoiceDisc; "Recalculate Invoice Disc.")
            {
            }
            column(Receive; Receive)
            {
            }
            column(RequestedDeliveryDate; "Requested Delivery Date")
            {
            }
            column(Reserve; Reserve)
            {
            }
            column(ResponsibilityCenter; "Responsibility Center")
            {
            }
            column(ReturnReceiptNo; "Return Receipt No.")
            {
            }
            column(ReturnReceiptNoSeries; "Return Receipt No. Series")
            {
            }
            column(SalespersonCode; "Salesperson Code")
            {
            }
            column(SelltoAddress; "Sell-to Address")
            {
            }
            column(SelltoAddress2; "Sell-to Address 2")
            {
            }
            column(SelltoCity; "Sell-to City")
            {
            }
            column(SelltoContact; "Sell-to Contact")
            {
            }
            column(SelltoContactNo; "Sell-to Contact No.")
            {
            }
            column(SelltoCountryRegionCode; "Sell-to Country/Region Code")
            {
            }
            column(SelltoCounty; "Sell-to County")
            {
            }
            column(SelltoCustomerName; "Sell-to Customer Name")
            {
            }
            column(SelltoCustomerName2; "Sell-to Customer Name 2")
            {
            }
            column(SelltoCustomerNo; "Sell-to Customer No.")
            {
            }
            column(SelltoCustomerTemplCode; "Sell-to Customer Templ. Code")
            {
            }
            column(SelltoCustomerTemplateCode; "Sell-to Customer Template Code")
            {
            }
            column(SelltoEMail; "Sell-to E-Mail")
            {
            }
            column(SelltoICPartnerCode; "Sell-to IC Partner Code")
            {
            }
            column(SelltoPhoneNo; "Sell-to Phone No.")
            {
            }
            column(SelltoPostCode; "Sell-to Post Code")
            {
            }
            column(SendICDocument; "Send IC Document")
            {
            }
            column(SentasEmail; "Sent as Email")
            {
            }
            column(Ship; Ship)
            {
            }
            column(ShiptoAddress; "Ship-to Address")
            {
            }
            column(ShiptoAddress2; "Ship-to Address 2")
            {
            }
            column(ShiptoCity; "Ship-to City")
            {
            }
            column(ShiptoCode; "Ship-to Code")
            {
            }
            column(ShiptoContact; "Ship-to Contact")
            {
            }
            column(ShiptoCountryRegionCode; "Ship-to Country/Region Code")
            {
            }
            column(ShiptoCounty; "Ship-to County")
            {
            }
            column(ShiptoName; "Ship-to Name")
            {
            }
            column(ShiptoName2; "Ship-to Name 2")
            {
            }
            column(ShiptoPostCode; "Ship-to Post Code")
            {
            }
            column(ShipmentDate; "Shipment Date")
            {
            }
            column(ShipmentMethodCode; "Shipment Method Code")
            {
            }
            column(Shipped; Shipped)
            {
            }
            column(ShippedNotInvoiced; "Shipped Not Invoiced")
            {
            }
            column(ShippingAdvice; "Shipping Advice")
            {
            }
            column(ShippingAgentCode; "Shipping Agent Code")
            {
            }
            column(ShippingAgentServiceCode; "Shipping Agent Service Code")
            {
            }
            column(ShippingNo; "Shipping No.")
            {
            }
            column(ShippingNoSeries; "Shipping No. Series")
            {
            }
            column(ShippingTime; "Shipping Time")
            {
            }
            column(ShortcutDimension1Code; "Shortcut Dimension 1 Code")
            {
            }
            column(ShortcutDimension2Code; "Shortcut Dimension 2 Code")
            {
            }
            column(Status; Status)
            {
            }
            column(SystemCreatedAt; SystemCreatedAt)
            {
            }
            column(SystemCreatedBy; SystemCreatedBy)
            {
            }
            column(SystemId; SystemId)
            {
            }
            column(SystemModifiedAt; SystemModifiedAt)
            {
            }
            column(SystemModifiedBy; SystemModifiedBy)
            {
            }
            column(TaxAreaCode; "Tax Area Code")
            {
            }
            column(TaxLiable; "Tax Liable")
            {
            }
            column(TransactionSpecification; "Transaction Specification")
            {
            }
            column(TransactionType; "Transaction Type")
            {
            }
            column(TransportMethod; "Transport Method")
            {
            }
            column(VATBaseDiscount; "VAT Base Discount %")
            {
            }
            column(VATBusPostingGroup; "VAT Bus. Posting Group")
            {
            }
            column(VATCountryRegionCode; "VAT Country/Region Code")
            {
            }
            column(VATRegistrationNo; "VAT Registration No.")
            {
            }
            column(WorkDescription; "Work Description")
            {
            }
            column(YourReference; "Your Reference")
            {
            }
            trigger OnPreDataItem()
            begin
                CREATE(AppExcel);
                AppExcel.Visible := TRUE;
            end;

            trigger OnAfterGetRecord()
            begin

                SalesSetup.GET();
                Purchline.SETCURRENTKEY("Document Type", "Document No.", "Line No.");
                Purchline.SETRANGE("PWD Sales Type Doc Appeal tenders", "Document Type");
                Purchline.SETRANGE("PWD Sales No. Appeal Tenders", "No.");
                AppExcel.Workbooks.Add;
                IF Purchline.FIND('-') THEN BEGIN
                    Docno := Purchline."Document No.";
                    Docno := Purchline."Document No.";
                    Purchline.SETRANGE("Document No.", Docno);
                    AppExcel.ActiveCell.Value := Purchline."Document No.";
                    AppExcel.ActiveCell.Offset(1, 0).Value := "Sales Header"."Document Date";
                    AppExcel.ActiveCell.Offset(2, 0).Value := "Sales Header"."Sell-to Customer No.";
                    AppExcel.ActiveCell.Offset(2, 2).Value := "Sales Header"."Sell-to Customer Name";
                    AppExcel.ActiveCell.Offset(3, 0).Value := "Sales Header"."Sell-to Contact No.";
                    IF cont.GET("Sell-to Contact No.") THEN
                        AppExcel.ActiveCell.Offset(3, 2).Value := "Sales Header"."Sell-to Contact";

                    AppExcel.Range('A6').Select;
                    AppExcel.ActiveCell.Value := 'N° ligne';
                    AppExcel.ActiveCell.Offset(0, 1).Value := 'N° Article';
                    AppExcel.ActiveCell.Offset(0, 2).Value := 'Désignation';
                    AppExcel.ActiveCell.Offset(0, 3).Value := 'Quantité';
                    AppExcel.ActiveCell.Offset(0, 4).Value := 'Code Unité';
                    AppExcel.ActiveCell.Offset(0, 5).Value := 'Date de réception demandée';
                    AppExcel.ActiveCell.Offset(0, 6).Value := 'Prix Unitaire H.T.';
                    AppExcel.ActiveCell.Offset(0, 7).Value := 'Date Ferme proposée pour une livraison chez AVITA';
                    AppExcel.ActiveCell.Offset(0, 8).Value := 'Délai d''expédition';
                    AppExcel.ActiveCell.Offset(1, 0).Select;

                    Purchline2.SETRANGE("Document Type", Purchline."Document Type");
                    Purchline2.SETRANGE("Document No.", Purchline."Document No.");
                    Purchline2.SETRANGE("Document Type", Purchline."Document Type");
                    Purchline2.SETRANGE("Buy-from Vendor No.", Purchline."Buy-from Vendor No.");
                    IF Purchline2.FIND('-') THEN BEGIN
                        REPEAT
                            AppExcel.ActiveCell.Value := Purchline2."Line No.";
                            AppExcel.ActiveCell.Offset(0, 1).Value := Purchline2."No.";
                            AppExcel.ActiveCell.Offset(0, 2).Value := Purchline2.Description;
                            AppExcel.ActiveCell.Offset(0, 3).Value := Purchline2.Quantity;
                            AppExcel.ActiveCell.Offset(0, 4).Value := Purchline2."Unit of Measure Code";
                            AppExcel.ActiveCell.Offset(0, 5).Value := FORMAT(Purchline2."Requested Receipt Date");
                            AppExcel.ActiveCell.Offset(0, 6).NumberFormat('0,00');
                            AppExcel.ActiveCell.Offset(0, 7).Value := FORMAT(Purchline2."Promised Receipt Date");
                            AppExcel.ActiveCell.Offset(0, 8).Value := FORMAT(Purchline2."Lead Time Calculation");
                            AppExcel.ActiveCell.Offset(0, 9).Value := FORMAT(Purchline2."Buy-from Vendor No.");
                            AppExcel.ActiveCell.Offset(1, 0).Select;
                        UNTIL Purchline2.NEXT() = 0;
                        Purchline2.RESET();
                    END;
                    AppExcel.ActiveCell.CurrentRegion.Select;
                    AppExcel.ActiveCell.CurrentRegion.Borders.LineStyle := 1;
                    AppExcel.Cells.Select;
                    AppExcel.Cells.EntireColumn.AutoFit;
                    AppExcel.Range('A6').Select;
                    FileBat.CREATE('c:\Start.bat');
                    FileBat.TEXTMODE := TRUE;
                    FileBat.WRITEMODE := TRUE;
                    SLEEP(1000);
                    FileBat.OPEN('c:\Start.bat');
                    FileBat.WRITE := 'md ' +
                    '"' + SalesSetup."PWD Path xls File Export" + '\' + FORMAT(Purchline."Buy-from Vendor No.") + FORMAT(Purchline."Document No.") + '"';
                    FileBat.CLOSE;
                    SLEEP(1000);
                    SLEEP(1000);
                    CommandProcessor := 'c:\start.bat';
                    DosArgumentII := FORMAT(Purchline."Buy-from Vendor No.") + FORMAT(Purchline."Document No.");
                    SHELL(CommandProcessor);
                    SLEEP(2000);
                    AppExcel.ActiveWorkbook._SaveAs(SalesSetup."PWD Path xls File Export" + '\' + DosArgumentII + '\' +
                      FORMAT(Purchline."Buy-from Vendor No.") + FORMAT(Purchline."Document No."));
                    ERASE('c:\start.bat');
                    Purchline.SETRANGE("Document No.");
                    Docno := Purchline."Document No.";
                    REPEAT
                        AppExcel.Workbooks.Add;
                        IF Docno <> Purchline."Document No." THEN BEGIN
                            Docno := Purchline."Document No.";
                            Purchline.SETRANGE("Document No.", Docno);
                            AppExcel.ActiveCell.Value := Purchline."Document No.";
                            AppExcel.ActiveCell.Offset(1, 0).Value := "Sales Header"."Document Date";
                            AppExcel.ActiveCell.Offset(2, 0).Value := "Sales Header"."Sell-to Customer No.";
                            AppExcel.ActiveCell.Offset(2, 2).Value := "Sales Header"."Sell-to Customer Name";
                            AppExcel.ActiveCell.Offset(3, 0).Value := "Sales Header"."Sell-to Contact No.";
                            IF cont.GET("Sell-to Contact No.") THEN
                                AppExcel.ActiveCell.Offset(3, 2).Value := "Sales Header"."Sell-to Contact";

                            AppExcel.Range('A6').Select;
                            AppExcel.ActiveCell.Value := 'N° ligne';
                            AppExcel.ActiveCell.Offset(0, 1).Value := 'N° Article';
                            AppExcel.ActiveCell.Offset(0, 2).Value := 'Désignation';
                            AppExcel.ActiveCell.Offset(0, 3).Value := 'Quantité';
                            AppExcel.ActiveCell.Offset(0, 4).Value := 'Code Unité';
                            AppExcel.ActiveCell.Offset(0, 5).Value := 'Date de réception demandée';
                            AppExcel.ActiveCell.Offset(0, 6).Value := 'Prix Unitaire H.T.';
                            AppExcel.ActiveCell.Offset(0, 7).Value := 'Date Ferme proposée pour une livraison chez AVITA';
                            AppExcel.ActiveCell.Offset(0, 8).Value := 'Délai d''expédition';
                            AppExcel.ActiveCell.Offset(1, 0).Select;

                            Purchline2.SETRANGE("Document Type", Purchline."Document Type");
                            Purchline2.SETRANGE("Document No.", Purchline."Document No.");
                            Purchline2.SETRANGE("Document Type", Purchline."Document Type");
                            Purchline2.SETRANGE("Buy-from Vendor No.", Purchline."Buy-from Vendor No.");
                            IF Purchline2.FIND('-') THEN BEGIN
                                REPEAT
                                    AppExcel.ActiveCell.Value := Purchline2."Line No.";
                                    AppExcel.ActiveCell.Offset(0, 1).Value := Purchline2."No.";
                                    AppExcel.ActiveCell.Offset(0, 2).Value := Purchline2.Description;
                                    AppExcel.ActiveCell.Offset(0, 3).Value := Purchline2.Quantity;
                                    AppExcel.ActiveCell.Offset(0, 4).Value := Purchline2."Unit of Measure Code";
                                    AppExcel.ActiveCell.Offset(0, 5).Value := FORMAT(Purchline2."Requested Receipt Date");
                                    AppExcel.ActiveCell.Offset(0, 6).NumberFormat('0,00');
                                    AppExcel.ActiveCell.Offset(0, 7).Value := FORMAT(Purchline2."Promised Receipt Date");
                                    AppExcel.ActiveCell.Offset(0, 8).Value := FORMAT(Purchline2."Lead Time Calculation");
                                    AppExcel.ActiveCell.Offset(0, 9).Value := FORMAT(Purchline2."Buy-from Vendor No.");
                                    AppExcel.ActiveCell.Offset(1, 0).Select;
                                UNTIL Purchline2.NEXT() = 0;
                                Purchline2.RESET();
                            END;
                            AppExcel.ActiveCell.CurrentRegion.Select;
                            AppExcel.ActiveCell.CurrentRegion.Borders.LineStyle := 1;
                            AppExcel.Cells.Select;
                            AppExcel.Cells.EntireColumn.AutoFit;
                            AppExcel.Range('A6').Select;
                            FileBat.CREATE('c:\Start.bat');
                            FileBat.TEXTMODE := TRUE;
                            FileBat.WRITEMODE := TRUE;
                            SLEEP(1000);
                            FileBat.OPEN('c:\Start.bat');
                            FileBat.WRITE := 'md ' +
                            '"' + SalesSetup."PWD Path xls File Export" + '\' + FORMAT(Purchline."Buy-from Vendor No.") + FORMAT(Purchline."Document No.") + '"';
                            FileBat.CLOSE;
                            SLEEP(1000);
                            SLEEP(1000);
                            CommandProcessor := 'c:\start.bat';
                            DosArgumentII := FORMAT(Purchline."Buy-from Vendor No.") + FORMAT(Purchline."Document No.");
                            SHELL(CommandProcessor);
                            SLEEP(2000);

                            AppExcel.ActiveWorkbook._SaveAs(SalesSetup."PWD Path xls File Export" + '\' + DosArgumentII + '\' +
                              FORMAT(Purchline."Buy-from Vendor No.") + FORMAT(Purchline."Document No."));
                            Purchline.SETRANGE("Document No.");
                            Docno := Purchline."Document No.";
                            ERASE('c:\start.bat');
                        END;
                    UNTIL Purchline.NEXT() = 0;
                END;
                AppExcel.Quit;
            end;

            trigger OnPostDataItem()
            begin
                AppExcel.Quit;
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
    var
        cont: Record Contact;
        Purchline: Record "Purchase Line";
        Purchline2: Record "Purchase Line";
        SalesSetup: Record "Sales & Receivables Setup";
        AppExcel: automation;
        Docno: code[20];
        FileBat: file;
        CommandProcessor: Text[100];
        DosArgumentII: Text[100];

}
