pageextension 70106 EmployeeInformation extends "Employee Card"
{
    layout
    {

        addlast(General)
        {
            field("User Id"; Rec."User Id")
            {
                ApplicationArea = All;
                TableRelation = User."User Name";

            }
        }
    }
}