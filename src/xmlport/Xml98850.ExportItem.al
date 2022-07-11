xmlport 98850 "PWD ExportItem"
{
    Format = xml;
    Caption = 'ExportItem';
    schema
    {
        textelement(RootNodeName)
        {
            tableelement(Item; Item)
            {
                SourceTableView = WHERE ("No." = FILTER ('1BA1020601B|1EP1060400'));
                XmlName = 'Items';
                fieldelement(No; Item."No.")
                {
                }
                fieldelement(Description; Item.Description)
                {
                }
            }
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
}
