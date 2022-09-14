tableextension 70107 fieldExtension extends "Purchase Header"
{
    fields
    {
        // Add changes to table fields here
        field(50001; "Purchase Requisition"; Code[50])
        {
            Caption = 'Purchase Requisition';
        }
    }

    var
        myInt: Integer;
}