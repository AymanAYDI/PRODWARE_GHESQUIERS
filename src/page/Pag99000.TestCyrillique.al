page 99000 "PWD Test Cyrillique"
{
    PageType = Card;

    layout
    {
        area(content)
        {
            field(TestFrappe; TestFrappe)
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
            action(OK)
            {
                Caption = 'OK';
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    CLEAR(Excel);
                    CREATE(Excel);
                    Excel.LanguageSettings;


                    Book := Excel.Workbooks.Add;
                    NomFeuilleExcel := '';
                    Sheet := Excel.ActiveSheet;
                    Sheet.Activate;

                    Excel.ActiveCell.Value := TestFrappe;

                    Excel.Visible := TRUE;
                end;
            }
        }
    }

    // Could not resolve the usercontrol owning 'Sheet@1000000004::SelectionChange@1543'
    //trigger SelectionChange(Target: Automation )
    //begin
    /*
    */
    //end;

    // Could not resolve the usercontrol owning 'Sheet@1000000004::BeforeDoubleClick@1537'
    //trigger BeforeDoubleClick(Target: Automation ;var Cancel: Boolean)
    //begin
    /*
    */
    //end;

    // Could not resolve the usercontrol owning 'Sheet@1000000004::BeforeRightClick@1534'
    //trigger BeforeRightClick(Target: Automation ;var Cancel: Boolean)
    //begin
    /*
    */
    //end;

    // Could not resolve the usercontrol owning 'Sheet@1000000004::Activate@304'
    //trigger Activate()
    //begin
    /*
    */
    //end;

    // Could not resolve the usercontrol owning 'Sheet@1000000004::Deactivate@1530'
    //trigger Deactivate()
    //begin
    /*
    */
    //end;

    // Could not resolve the usercontrol owning 'Sheet@1000000004::Calculate@279'
    //trigger Calculate()
    //begin
    /*
    */
    //end;

    // Could not resolve the usercontrol owning 'Sheet@1000000004::Change@1545'
    //trigger Change(Target: Automation )
    //begin
    /*
    */
    //end;

    // Could not resolve the usercontrol owning 'Sheet@1000000004::FollowHyperlink@1470'
    //trigger FollowHyperlink(Target: Automation )
    //begin
    /*
    */
    //end;

    // Could not resolve the usercontrol owning 'Book@1000000005::Open@682'
    //trigger Open()
    //begin
    /*
    */
    //end;

    // Could not resolve the usercontrol owning 'Book@1000000005::Activate@304'
    //trigger Activate()
    //begin
    /*
    */
    //end;

    // Could not resolve the usercontrol owning 'Book@1000000005::Deactivate@1530'
    //trigger Deactivate()
    //begin
    /*
    */
    //end;

    // Could not resolve the usercontrol owning 'Book@1000000005::BeforeClose@1546'
    //trigger BeforeClose(var Cancel: Boolean)
    //begin
    /*
    */
    //end;

    // Could not resolve the usercontrol owning 'Book@1000000005::BeforeSave@1547'
    //trigger BeforeSave(SaveAsUI: Boolean;var Cancel: Boolean)
    //begin
    /*
    */
    //end;

    // Could not resolve the usercontrol owning 'Book@1000000005::BeforePrint@1549'
    //trigger BeforePrint(var Cancel: Boolean)
    //begin
    /*
    */
    //end;

    // Could not resolve the usercontrol owning 'Book@1000000005::NewSheet@1550'
    //trigger NewSheet(Sh: Automation )
    //begin
    /*
    */
    //end;

    // Could not resolve the usercontrol owning 'Book@1000000005::AddinInstall@1552'
    //trigger AddinInstall()
    //begin
    /*
    */
    //end;

    // Could not resolve the usercontrol owning 'Book@1000000005::AddinUninstall@1553'
    //trigger AddinUninstall()
    //begin
    /*
    */
    //end;

    // Could not resolve the usercontrol owning 'Book@1000000005::WindowResize@1554'
    //trigger WindowResize(Wn: Automation )
    //begin
    /*
    */
    //end;

    // Could not resolve the usercontrol owning 'Book@1000000005::WindowActivate@1556'
    //trigger WindowActivate(Wn: Automation )
    //begin
    /*
    */
    //end;

    // Could not resolve the usercontrol owning 'Book@1000000005::WindowDeactivate@1557'
    //trigger WindowDeactivate(Wn: Automation )
    //begin
    /*
    */
    //end;

    // Could not resolve the usercontrol owning 'Book@1000000005::SheetSelectionChange@1558'
    //trigger SheetSelectionChange(Sh: Automation ;Target: Automation )
    //begin
    /*
    */
    //end;

    // Could not resolve the usercontrol owning 'Book@1000000005::SheetBeforeDoubleClick@1559'
    //trigger SheetBeforeDoubleClick(Sh: Automation ;Target: Automation ;var Cancel: Boolean)
    //begin
    /*
    */
    //end;

    // Could not resolve the usercontrol owning 'Book@1000000005::SheetBeforeRightClick@1560'
    //trigger SheetBeforeRightClick(Sh: Automation ;Target: Automation ;var Cancel: Boolean)
    //begin
    /*
    */
    //end;

    // Could not resolve the usercontrol owning 'Book@1000000005::SheetActivate@1561'
    //trigger SheetActivate(Sh: Automation )
    //begin
    /*
    */
    //end;

    // Could not resolve the usercontrol owning 'Book@1000000005::SheetDeactivate@1562'
    //trigger SheetDeactivate(Sh: Automation )
    //begin
    /*
    */
    //end;

    // Could not resolve the usercontrol owning 'Book@1000000005::SheetCalculate@1563'
    //trigger SheetCalculate(Sh: Automation )
    //begin
    /*
    */
    //end;

    // Could not resolve the usercontrol owning 'Book@1000000005::SheetChange@1564'
    //trigger SheetChange(Sh: Automation ;Target: Automation )
    //begin
    /*
    */
    //end;

    // Could not resolve the usercontrol owning 'Book@1000000005::SheetFollowHyperlink@1854'
    //trigger SheetFollowHyperlink(Sh: Automation ;Target: Automation )
    //begin
    /*
    */
    //end;

    // Could not resolve the usercontrol owning 'Excel@1000000006::NewWorkbook@1565'
    //trigger NewWorkbook(Wb: Automation )
    //begin
    /*
    */
    //end;

    // Could not resolve the usercontrol owning 'Excel@1000000006::SheetSelectionChange@1558'
    //trigger SheetSelectionChange(Sh: Automation ;Target: Automation )
    //begin
    /*
    */
    //end;

    // Could not resolve the usercontrol owning 'Excel@1000000006::SheetBeforeDoubleClick@1559'
    //trigger SheetBeforeDoubleClick(Sh: Automation ;Target: Automation ;var Cancel: Boolean)
    //begin
    /*
    */
    //end;

    // Could not resolve the usercontrol owning 'Excel@1000000006::SheetBeforeRightClick@1560'
    //trigger SheetBeforeRightClick(Sh: Automation ;Target: Automation ;var Cancel: Boolean)
    //begin
    /*
    */
    //end;

    // Could not resolve the usercontrol owning 'Excel@1000000006::SheetActivate@1561'
    //trigger SheetActivate(Sh: Automation )
    //begin
    /*
    */
    //end;

    // Could not resolve the usercontrol owning 'Excel@1000000006::SheetDeactivate@1562'
    //trigger SheetDeactivate(Sh: Automation )
    //begin
    /*
    */
    //end;

    // Could not resolve the usercontrol owning 'Excel@1000000006::SheetCalculate@1563'
    //trigger SheetCalculate(Sh: Automation )
    //begin
    /*
    */
    //end;

    // Could not resolve the usercontrol owning 'Excel@1000000006::SheetChange@1564'
    //trigger SheetChange(Sh: Automation ;Target: Automation )
    //begin
    /*
    */
    //end;

    // Could not resolve the usercontrol owning 'Excel@1000000006::WorkbookOpen@1567'
    //trigger WorkbookOpen(Wb: Automation )
    //begin
    /*
    */
    //end;

    // Could not resolve the usercontrol owning 'Excel@1000000006::WorkbookActivate@1568'
    //trigger WorkbookActivate(Wb: Automation )
    //begin
    /*
    */
    //end;

    // Could not resolve the usercontrol owning 'Excel@1000000006::WorkbookDeactivate@1569'
    //trigger WorkbookDeactivate(Wb: Automation )
    //begin
    /*
    */
    //end;

    // Could not resolve the usercontrol owning 'Excel@1000000006::WorkbookBeforeClose@1570'
    //trigger WorkbookBeforeClose(Wb: Automation ;var Cancel: Boolean)
    //begin
    /*
    */
    //end;

    // Could not resolve the usercontrol owning 'Excel@1000000006::WorkbookBeforeSave@1571'
    //trigger WorkbookBeforeSave(Wb: Automation ;SaveAsUI: Boolean;var Cancel: Boolean)
    //begin
    /*
    */
    //end;

    // Could not resolve the usercontrol owning 'Excel@1000000006::WorkbookBeforePrint@1572'
    //trigger WorkbookBeforePrint(Wb: Automation ;var Cancel: Boolean)
    //begin
    /*
    */
    //end;

    // Could not resolve the usercontrol owning 'Excel@1000000006::WorkbookNewSheet@1573'
    //trigger WorkbookNewSheet(Wb: Automation ;Sh: Automation )
    //begin
    /*
    */
    //end;

    // Could not resolve the usercontrol owning 'Excel@1000000006::WorkbookAddinInstall@1574'
    //trigger WorkbookAddinInstall(Wb: Automation )
    //begin
    /*
    */
    //end;

    // Could not resolve the usercontrol owning 'Excel@1000000006::WorkbookAddinUninstall@1575'
    //trigger WorkbookAddinUninstall(Wb: Automation )
    //begin
    /*
    */
    //end;

    // Could not resolve the usercontrol owning 'Excel@1000000006::WindowResize@1554'
    //trigger WindowResize(Wb: Automation ;Wn: Automation )
    //begin
    /*
    */
    //end;

    // Could not resolve the usercontrol owning 'Excel@1000000006::WindowActivate@1556'
    //trigger WindowActivate(Wb: Automation ;Wn: Automation )
    //begin
    /*
    */
    //end;

    // Could not resolve the usercontrol owning 'Excel@1000000006::WindowDeactivate@1557'
    //trigger WindowDeactivate(Wb: Automation ;Wn: Automation )
    //begin
    /*
    */
    //end;

    // Could not resolve the usercontrol owning 'Excel@1000000006::SheetFollowHyperlink@1854'
    //trigger SheetFollowHyperlink(Sh: Automation ;Target: Automation )
    //begin
    /*
    */
    //end;

    var
        Book: Automation;
        Excel: Automation;
        Sheet: Automation;
        NomFeuilleExcel: Text[50];
        TestFrappe: Text[250];
}

