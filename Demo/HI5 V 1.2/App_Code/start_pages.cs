using System;
using System.Collections.Generic;
using System.Text;

public class start_pages
{
    public string url { get; set; }
    public string page_names_sno { get; set; }
    public string pagestatus { get; set; }
    public string page_id { get; set; }

}
public class head_login
{
    public string logintype { get; set; }
}
public class institute_data
{
    public string idinstitute_info { get; set; }
    public List<branches_data> branches = new List<branches_data>();
    public List<departments_data> departments = new List<departments_data>();
    public List<employees_data> employees = new List<employees_data>();
}
public class branches_data
{
    public string branch_name { get; set; }
    public string branch_sno { get; set; }
}
public class departments_data
{
    public string employee_dept { get; set; }
    public string depart_name { get; set; }
}
public class employees_data
{
    public string idemployees { get; set; }
    public string employee_num { get; set; }
    public string fullname { get; set; }
    public string password { get; set; }
    public string emp_login_sno { get; set; }
}