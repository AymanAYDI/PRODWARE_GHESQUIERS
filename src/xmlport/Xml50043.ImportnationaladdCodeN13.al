xmlport 50043 "Import national add. Code N13"
{
    Caption = 'Import national add. Code N13';
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
            tableelement(PWDNationalAddCode; "PWD National Add. Code")
            {
                fieldelement(NationalAddCode; PWDNationalAddCode."National Add. Code")
                {
                }
                fieldelement(Description; PWDNationalAddCode.Description)
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
