xmlport 50004 "Import Fiscal Caption For CIEL"
{
    Caption = 'Import Fiscal Caption For CIEL';
    Direction = Import;
    FieldDelimiter = '<None>';
    FieldSeparator = '<;>';
    Format = VariableText;
    TextEncoding = WINDOWS;
    UseRequestPage = true;
    schema
    {
        textelement(RootNodeName)
        {
            tableelement(PWDFiscalCaption; "PWD Fiscal Caption")
            {
                fieldelement(Name; PWDFiscalCaption.Name)
                {
                }
                fieldelement(Description; PWDFiscalCaption.Description)
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
