using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using DevExpress.Web;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.Owin;

namespace PertentoBI {
    public partial class AccountMaster : System.Web.UI.MasterPage {
        protected void Page_Load(object sender, EventArgs e) {           
        }

                protected void LoggedInMenuMenu_ItemClick(object source, DevExpress.Web.Bootstrap.BootstrapMenuItemEventArgs e) {
            if(e.Item.Name == "Logout") {
                var AuthenticationManager = HttpContext.Current.GetOwinContext().Authentication;
                AuthenticationManager.SignOut();

                Response.Redirect("~/Account/Login.aspx");
            }
        }
            }
}