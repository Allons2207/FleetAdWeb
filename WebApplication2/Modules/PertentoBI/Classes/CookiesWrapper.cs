using System.ComponentModel;
using System;
using System.Web;
using PertentoBI.Classes;
using Microsoft.VisualBasic;
//**THIS FILE IS SHARED AMONGST MANY PROJECTS**

[Description("Provide access to cookies as if they were properties variables of a class.")]
public partial class CookiesWrapper
{

    #region Variables

    private static bool mGotNothing;

    private long mUserID;
    private System.Web.HttpRequest mRequest;
    private System.Web.HttpResponse mResponse;
    private string mSearchType;

    private static string NON_CLEARABLE_COOKIES = "ConnectionName,UserName,MemberType,SegregatedFundID";

    #endregion

    #region Properties
    [Description("Check whether last access was to an existing cookie or a default value was returned.")]
    public bool GotNothing
    {
        get
        {
            return mGotNothing;
        }
    }

    #endregion

    #region Subscription Cookies

    [Description("Gets or sets the ProcessID saved into the ProcessID cookie.")]
    public static long ProcessID
    {
        get
        {
            return Convert.ToInt64("ProcessID", 0);
        }
        set
        {
            AddCookie("ProcessID", value);
        }
    }

    [Description("Gets or sets the CategorySchemeID saved into the CategorySchemeID cookie.")]
    public static long CategorySchemeID
    {
        get
        {
            return Convert.ToInt64(GetCookie("CategorySchemeID", 0));
        }
        set { AddCookie("CategorySchemeID", value); }
    }

    [Description("Gets or sets the SubscriptionSchemeID saved into the SubscriptionSchemeID cookie.")]
    public static long SubscriptionSchemeID
    {
        get
        {
            return Convert.ToInt64(GetCookie("SubscriptionSchemeID", 0));
        }
        set { AddCookie("SubscriptionSchemeID", value); }
    }

    [Description("Gets or sets the Subscriptionid saved into the SubscriptionID cookie.")]
    public static long SubscriptionID
    {
        get
        {
            return Convert.ToInt64(GetCookie("SubscriptionID", 0));
        }
        set { AddCookie("SubscriptionID", value); }
    }

    [Description("Gets or sets the StatementHeaderID saved into the SubscriptionID cookie.")]
    public static long StatementHeaderID
    {
        get
        {
            return Convert.ToInt64(GetCookie("StatementHeaderID", 0));
        }
        set { AddCookie("StatementHeaderID", value); }
    }

    //<Description("Gets or sets the IsGeneratingBillingSchedule saved into the IsGeneratingBillingSchedule cookie.")> _
    // Public Shared Property IsGeneratingBillingSchedule() As Boolean
    //    Get
    //        Return GetCookie("IsGeneratingBillingSchedule", False)
    //    End Get
    //    Set(ByVal Value As Boolean)
    //        AddCookie("IsGeneratingBillingSchedule", Value)
    //    End Set
    //End Property

    #endregion

    #region User Cookies

    [Description("Gets or sets a ApplicationSkin saved into the ApplicationSkin cookie.")]
    public static string ApplicationSkin
    {
        get
        {
            return Convert.ToString(GetCookie("ApplicationSkin", "mms"));
        }
        set { AddCookie("ApplicationSkin", value); }
    }

    [Description("Gets or sets a ApplicationSkin saved into the ApplicationSkin cookie.")]
    public static string ApplicationSkinCSS
    {
        get
        {
            return Convert.ToString(GetCookie("ApplicationSkinCSS", "ApplicationSkins/mms/styles/mms.css"));
        }
        set { AddCookie("ApplicationSkinCSS", value); }
    }


    #endregion

    #region User Cookies

    [Description("Gets or sets a Connection Name saved into the ConnectionName cookie.")]
    public static string ConnectionName
    {
        get
        {
            return Convert.ToString(GetCookie("ConnectionName", "Test"));
        }
        set { AddCookie("ConnectionName", value); }
    }

    [Description("Gets or sets a AdHocMessage saved into the AdHocMessage cookie.")]
    public static string AdHocMessage
    {
        get
        {
            return Convert.ToString(GetCookie("AdHocMessage", "Test"));
        }
        set { AddCookie("AdHocMessage", value); }
    }

    [Description("Gets or sets the reportid saved into the ReportID cookie.")]
    public static long ReportID
    {
        get
        {
            return Convert.ToInt64(GetCookie("ReportID", "0"));
        }
        set { AddCookie("ReportID", value); }
    }

    [Description("Gets or sets a user id saved into the UserID cookie.")]
    public static long UserID
    {
        get
        {
            return Convert.ToInt64(GetCookie("UserID", 1));
        }
        set { AddCookie("UserID", value); }
    }

    [Description("Gets or sets a user id saved into the PBI_UserID cookie.")]
    public static Guid PBI_UserID
    {
        get
        {
            return NumericHelper.long2Guid(Convert.ToInt64(GetCookie("UserID", 1)));
        }
        set { AddCookie("UserID", value); }
    }
    [Description("Gets or sets a Connection Name saved into the ConnectionName cookie.")]
    public static string thisConnectionName
    {
        get
        {
            return Convert.ToString(GetCookie("thisConnectionName", "Test"));
        }
        set
        {
            AddCookie("thisConnectionName", value);
        }
    }


    [Description("Gets or sets a user id saved into the LogID cookie.")]
    public static long LogID
    {
        get
        {
            return Convert.ToInt64(GetCookie("LogID", 1));
        }
        set { AddCookie("LogID", value); }
    }

    [Description("Gets or sets a user name saved into the UserFullName cookie.")]
    public static string UserFullName
    {
        get
        {
            return Convert.ToString(GetCookie("UserFullName", ""));
        }
        set { AddCookie("UserFullName", value); }
    }

    [Description("Gets or sets a user name saved into the UserName cookie.")]
    public static string UserName
    {
        get
        {
            return Convert.ToString(GetCookie("UserName", ""));
        }
        set { AddCookie("UserName", value); }
    }

    [Description("Gets or sets a User Groups saved into the UserGroups cookie.")]
    public static string UserGroups
    {
        get
        {
            return Convert.ToString(GetCookie("UserGroups", ""));
        }
        set { AddCookie("UserGroups", value); }
    }

    [Description("Gets or sets a Search type saved into the Searchtype cookie.")]
    public static string SearchType
    {
        get
        {
            return Convert.ToString(GetCookie("SearchType", ""));
        }
        set { AddCookie("SearchType", value); }
    }

    [Description("Gets or sets a user id saved into the UserID cookie.")]
    public static long thisUserID
    {
        get
        {
            return Convert.ToInt64(GetCookie("thisUserID", 1));
        }
        set
        {
            AddCookie("thisUserID", value);
        }
    }

    #endregion

    #region Member Cookies

    [Description("Gets or sets the SegregatedFundID saved into the SegregatedFundID cookie.")]
    public static long SegregatedFundID
    {
        get
        {
            return Convert.ToInt64(GetCookie("SegregatedFundID", 0));
        }
        set { AddCookie("SegregatedFundID", value); }
    }

    [Description("Gets or sets a Member id saved into the MemberID cookie.")]
    public static long MemberID
    {
        get
        {
            string tmp = Convert.ToString(GetCookie("MemberID", 0));
            return (NumericHelper.IsNumeric(tmp) ? Convert.ToInt64(tmp) : 0);
        }
        set
        {
            AddCookie("MemberID", value);
        }
    }

    [Description("Gets or sets a category id saved into the CategoryID cookie.")]
    public static long CategoryID
    {
        get
        {
            return Convert.ToInt64(GetCookie("CategoryID", -1));
        }
        set { AddCookie("CategoryID", value); }
    }

    [Description("Gets or sets a Member No saved into the MemberNo cookie.")]
    public static string MemberNo
    {
        get
        {
            return Convert.ToString(GetCookie("MemberNo", -1));
        }
        set { AddCookie("MemberNo", value); }
    }

    [Description("Gets or sets a member image File path saved into the FilePath cookie.")]
    public static string FileFrom
    {
        get
        {
            return Convert.ToString(GetCookie("FileFrom", ""));
        }
        set { AddCookie("FileFrom", value); }
    }

    [Description("Gets or sets a MemberEmailAddress path saved into the MemberEmailAddress cookie.")]
    public static string MemberEmailAddress
    {
        get
        {
            return Convert.ToString(GetCookie("MemberEmailAddress", ""));
        }
        set { AddCookie("MemberEmailAddress", value); }
    }

    [Description("Gets or sets the document URL e.g Birth Certificate, and saved into the DocumentURL cookie.")]
    public static string DocumentURL
    {
        get
        {
            return Convert.ToString(GetCookie("DocumentURL", ""));
        }
        set { AddCookie("DocumentURL", value); }
    }

    [Description("Gets or sets a member type saved into the MemberType cookie.")]
    public static string MemberType
    {
        get
        {
            return Convert.ToString(GetCookie("MemberType", ""));
        }
        set { AddCookie("MemberType", value); }
    }

    [Description("Gets or sets a member image File path saved into the FileTo cookie.")]
    public static string FileTo
    {
        get
        {
            return Convert.ToString(GetCookie("FileTo", ""));
        }
        set { AddCookie("FileTo", value); }
    }

    [Description("Gets or sets a member image File URL saved into the FilePath cookie.")]
    public static string FileUrl
    {
        get
        {
            return Convert.ToString(GetCookie("FileUrl", ""));
        }
        set { AddCookie("FileUrl", value); }
    }

    [Description("Gets or sets a member status saved into the MemberStatus cookie.")]
    public static string MemberStatus
    {
        get
        {
            return Convert.ToString(GetCookie("MemberStatus", ""));
        }
        set { AddCookie("MemberStatus", value); }
    }

    [Description("Gets or sets the query for the Last Searched Member saved into the LastMemberSearch cookie.")]
    public static string LastMemberSearch
    {
        get
        {
            string s = Convert.ToString(HttpContext.Current.Session["LastMemberSearch"]);
            if (string.IsNullOrEmpty(s))
            {
                return "";
            }
            else
            {
                return s;
            }
        }
        set
        {
            HttpContext.Current.Session["LastMemberSearch"] = value;
        }
    }

    [Description("Gets or sets a member search information saved into the MemberStatus cookie.")]
    public static string MemberSearchResults
    {
        get
        {
            return Convert.ToString(GetCookie("MemberSearchResults", ""));
        }
        set { AddCookie("MemberSearchResults", value); }
    }

    [Description("Gets or sets the Company ID saved into the CompanyID cookie.")]
    public static string CompanyID
    {
        get
        {
            return Convert.ToString(GetCookie("CompanyID", ""));
        }
        set { AddCookie("CompanyID", value); }
    }

    [Description("Gets or sets the Provider ID saved into the ProviderID cookie.")]
    public static string ProviderID
    {
        get
        {
            return Convert.ToString(GetCookie("ProviderID", ""));
        }
        set { AddCookie("ProviderID", value); }
    }

    [Description("Gets or sets the query for the Effective change date saved into the ChangeEffectiveDate cookie.")]
    public static DateTime ChangeEffectiveDate
    {
        get
        {
            return Convert.ToDateTime(GetCookie("ChangeEffectiveDate", DateTime.Now.ToLongDateString()));
        }
        set { AddCookie("ChangeEffectiveDate", value); }
    }

    #endregion

    #region Dashboard Cookies


    public static string SourceType
    {
        get
        {
            return Convert.ToString(GetCookie("SourceType", ""));
        }
        set { AddCookie("SourceType", value); }
    }

    #endregion

    #region Document Cookies

    [Description("Gets or sets a DocumentID saved into the DocumentID cookie.")]
    public static long DocumentID
    {
        get
        {
            string tmp = Convert.ToString(GetCookie("DocumentID", 0));
            return (NumericHelper.IsNumeric(tmp) ? Convert.ToInt64(tmp) : 0);
        }

        set { AddCookie("DocumentID", value); }
    }

    #endregion

    #region ListManagement Cookies

    [Description("Gets or sets a ListID saved into the ListID cookie.")]
    public static long ListID
    {
        get
        {
            string tmp = Convert.ToString(GetCookie("ListID", 0));
            return (NumericHelper.IsNumeric(tmp) ? Convert.ToInt64(tmp) : 0);
        }
        set { AddCookie("ListID", value); }
    }

    #endregion

    #region Custom Field Cookies
    [Description("Gets or sets a owner id saved into the OwnerID cookie.")]
    public static long OwnerID
    {
        get
        {
            return Convert.ToInt64(GetCookie("OwnerID", -1));
        }
        set { AddCookie("OwnerID", value); }
    }

    [Description("Gets or sets an owner type saved into the OwnerType cookie.")]
    public static string OwnerType
    {
        get
        {
            return Convert.ToString(GetCookie("OwnerType", ""));
        }
        set { AddCookie("OwnerType", value); }
    }
    #endregion

    #region Reports Cookies

    [Description("Gets or sets the Report Name saved into the Report Name cookie.")]
    public static string ReportName
    {
        get
        {
            return Convert.ToString(GetCookie("ReportName", ""));
        }
        set { AddCookie("ReportName", value); }
    }

    [Description("Gets or sets the DiskFileName saved into the DiskFileName cookie.")]
    public static string DiskFileName
    {
        get
        {
            return Convert.ToString(GetCookie("DiskFileName", ""));
        }
        set { AddCookie("DiskFileName", value); }
    }

    #endregion

    public static void AddCookie(object Key, object Value)
    {
        var objCookie = new HttpCookie(Convert.ToString(Key));
        objCookie.Value = Convert.ToString(Value);
        objCookie.Expires = DateAndTime.Now.AddDays(3d);
        HttpContext.Current.Response.Cookies.Add(objCookie);
    }

    public static object GetCookie(object Key, object ValueIfNothing)
    {
        object tempGetCookie = null;
        if (HttpContext.Current.Request.Cookies[Convert.ToString(Key)] == null)
        {
            mGotNothing = true;
            tempGetCookie = ValueIfNothing;
        }
        else
        {
            mGotNothing = false;
            tempGetCookie = HttpContext.Current.Request.Cookies[Convert.ToString(Key)].Value;
        }
        return tempGetCookie;
    }

    public static void ClearCookies()
    {

        try
        {

            foreach (HttpCookie objCookie in HttpContext.Current.Request.Cookies)
            {

                if (CanClearCookie(objCookie.Name))
                {

                    HttpContext.Current.Request.Cookies.Remove(objCookie.Name);
                    HttpContext.Current.Response.Cookies.Remove(objCookie.Name);

                }

            }

        }
        catch
        {
        }

    }
    private static bool CanClearCookie(string CookieName)
    {

        return !(Array.IndexOf(NON_CLEARABLE_COOKIES.Split(','), CookieName) >= 0);

    }

}

