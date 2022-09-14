table 70102 "Purchase Requistion Line"
{
    Caption = 'Purchase Requisition Line';
    DrillDownPageID = "Purchase Requistion Lines";
    LookupPageID = "Purchase Requistion Lines";

    fields
    {

        field(1; "PR No."; Code[20])
        {
            Caption = 'Header No.';
            TableRelation = "Purchase Requisition Header"."PR No.";
        }
        field(2; "No."; Integer)
        {
            Caption = 'No.';
            DataClassification = CustomerContent;

        }
        field(3; "Line No."; Integer)
        {
            Caption = 'Line No.';
            AutoIncrement = true;
            DataClassification = CustomerContent;

        }
        field(4; "Item Type"; Option)
        {
            Caption = 'Type';
            OptionMembers = Item;

        }
        field(5; "Item No"; Code[20])
        {
            Caption = 'Item No';
            NotBlank = true;



        }
        field(6; "Description"; Text[120])
        {
            Caption = 'Description';
        }
        field(7; "Quantity"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Quantity';
            DecimalPlaces = 0 : 5;


        }
        field(8; "Location Code"; Text[25])
        {
            Caption = 'Location Code';
            DataClassification = ToBeClassified;


        }

        field(9; "UOM"; Text[10])
        {
            TableRelation = "Unit of Measure";
            Caption = 'Unit of Measure';


        }

        field(10; "Department Code"; Text[20])
        {
            Caption = 'Department Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1),
                                                          Blocked = CONST(false));
            ;

        }

        field(11; "Vendor No"; Code[20])
        {
            Caption = 'Vendor No';
            DataClassification = ToBeClassified;


        }
        field(12; "Vendor Name"; Code[120])
        {
            Caption = 'Vendor Name';
            DataClassification = ToBeClassified;


        }
        field(13; "Amount"; Decimal)
        {
            Caption = 'Amount';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;

        }
        field(14; "Net Amount"; Decimal)
        {
            Caption = 'Net Amount';
            DecimalPlaces = 0 : 5;


        }
        field(15; "PO No."; Code[20])
        {
            Caption = 'PO No.';
            DataClassification = CustomerContent;
        }


    }

    keys
    {
        key(PK; "PR No.", "No.")
        {
            Clustered = true;
        }
    }

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