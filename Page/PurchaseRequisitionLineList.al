page 70103 "Purchase Requistion Lines"
{

    ApplicationArea = All;
    Caption = 'Purchase Requisition Lines';
    PageType = List;
    SourceTable = "Purchase Requistion Line";
    UsageCategory = Lists;


    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;

                field("Line No."; Rec."Line No.")
                {
                    Caption = 'Line No.';
                    ApplicationArea = All;

                }
                field("PR No."; Rec."PR No.")
                {
                    Caption = 'Header No';
                    ApplicationArea = Suite;
                }
                field("Item Type"; Rec."Item Type")
                {
                    Caption = 'Item Type';
                    ApplicationArea = Basic, Suite;
                }
                field("Item No"; Rec."Item No")
                {
                    Caption = 'Item No';
                    ApplicationArea = Basic, Suite;
                }
                field("Description"; Rec."Description")
                {
                    Caption = 'Description';
                    ApplicationArea = Basic, Suite;
                }
                field("Quantity"; Rec."Quantity")
                {
                    Caption = 'Quantity';
                    ApplicationArea = Basic, Suite;
                }
                field("Location Code"; Rec."Location Code")
                {
                    Caption = 'Location Code';
                    ApplicationArea = Basic, Suite;
                }
                field("UOM"; Rec."UOM")
                {
                    Caption = 'UOM';
                    ApplicationArea = Basic, Suite;
                }
                field("Department Code"; Rec."Department Code")
                {
                    Caption = 'Department Code';
                    ApplicationArea = Basic, Suite;
                }

                field("Vendor No"; Rec."Vendor No")
                {
                    Caption = 'Vendor No';
                    ApplicationArea = Basic, Suite;
                }
                field("Vendor Name"; Rec."Vendor Name")
                {
                    Caption = 'Vendor Name';
                    ApplicationArea = Basic, Suite;
                }
                field("Amount"; Rec."Amount")
                {
                    Caption = 'Amount';
                    ApplicationArea = Basic, Suite;
                }
                field("Net Amount"; Rec."Net Amount")
                {
                    Caption = 'Net Amount';
                    ApplicationArea = Basic, Suite;

                }
                field("PO No."; Rec."PO No.")
                {
                    ApplicationArea = All;

                }
            }
        }
    }




}