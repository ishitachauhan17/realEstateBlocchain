// GPL-3.0
//SPDX-License-Identifier: Unlicense
pragma solidity >=0.7.0 <0.9.0;
contract student_reg{
    struct student{
        uint roll;
        string name;
        int mark1;
        int mark2;
        int mark3;
        int per;
        bool reg_status;
    }
    uint roll1 =0;
    int per1=0;
    bool reg_status1= false;

    mapping  (uint=>student) public studentdetails;

    function enrollStudent(string memory n, int m1, int m2, int m3) public
    {
        per1 = (m1+m2+m3)/3;
        if(per1>=60)
        {
            roll1++;
            studentdetails[roll1] = student(roll1, n, m1,m2, m3, per1,true);
        }

    }

    function mantainMembership(uint r,int m1, int m2, int m3) public
    {

         per1 = (m1+m2+m3)/3;

          student memory student_ref= studentdetails[r];
          student_ref.mark1 = m1;
          student_ref.mark2 = m2;
          student_ref.mark3 = m2;
          student_ref.per = per1;
          if(per1<60)
         {
             student_ref.reg_status = false;
 
         }
         else{
             student_ref.reg_status = true;
          }

          studentdetails[r] = student_ref;
    }

}