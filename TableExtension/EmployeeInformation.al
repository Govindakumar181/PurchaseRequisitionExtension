tableextension 70106 EmployeeInformation extends Employee
{

    fields
    {
        field(50000; "User Id"; Code[30])
        {
            // Set links to the "User ID" from the User table.
            Caption = 'User';

        }
    }
}