table 70105 "Purchase Requisition History"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Integer)
        {
            Caption = 'No.';
            AutoIncrement = true;
            DataClassification = CustomerContent;

        }
        field(2; "PR No"; Code[20])
        {
            Caption = 'Header No.';
            DataClassification = CustomerContent;

        }

        field(3; "Email"; Text[50])
        {
            Caption = 'Email';
            DataClassification = CustomerContent;

        }
        field(4; "Status From"; Text[20])
        {
            Caption = 'Status From';
            DataClassification = CustomerContent;

        }
        field(5; "Status To"; Text[20])
        {
            Caption = 'Status To';
            DataClassification = CustomerContent;

        }
        field(6; "Modified By"; Text[50])
        {
            Caption = 'Modified By';
            DataClassification = CustomerContent;

        }
        field(7; "Modified Date"; Date)
        {
            Caption = 'Modified Date';
            DataClassification = CustomerContent;

        }
        field(8; "Approver Comments"; Text[100])
        {
            Caption = 'Approver Comments';
            DataClassification = CustomerContent;

        }

    }

    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}