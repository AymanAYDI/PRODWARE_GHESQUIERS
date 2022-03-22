codeunit 60002 "PWD CduEvents"
{
    //--Page10--

    [EventSubscriber(ObjectType::Page, 10, 'OnOpenPageEvent', '', false, false)]
    procedure PAG010_OnOpenPageEvent_CountriesRegions(var Rec: Record "Country/Region")
    var
        PagCountriesRegions: Page "Countries/Regions";
    begin
        IF PagCountriesRegions.LOOKUPMODE THEN PagCountriesRegions.EDITABLE(FALSE);
    end;
    //--Page22--
    [EventSubscriber(ObjectType::Page, 22, 'OnOpenPageEvent', '', false, false)]
    procedure PAG022_OnOpenPageEvent_CustomerList(var Rec: Record Customer)
    VAR
        TxtGAddressList: Text[1024];
        RecLCustomer: Record Customer;
        RecLCustomer2: Record Customer;
    BEGIN
        RecLCustomer.RESET();
        RecLCustomer.SETCURRENTKEY("PWD Group In EMail");
        RecLCustomer.SETRANGE("PWD Group In EMail", TRUE);
        IF RecLCustomer.FINDFIRST() THEN
            REPEAT
                RecLCustomer2.GET(RecLCustomer."No.");
                RecLCustomer2."PWD Group In EMail" := FALSE;
                RecLCustomer2.MODIFY();
            UNTIL RecLCustomer.NEXT() = 0;
        TxtGAddressList := '';
    END;
}
