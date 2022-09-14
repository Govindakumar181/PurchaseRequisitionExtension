table 70107 ApprovalTemp

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