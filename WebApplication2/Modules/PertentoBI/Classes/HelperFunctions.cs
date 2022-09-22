using System;
using System.Collections.Generic;
using System.Configuration;
using System.Drawing;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;


namespace PertentoBI.Classes
{
    public static class HelperFunctions
    {
        

        public static string CleanupFilename(ref string ProposedName, string CharToRemove = "[^\\w _\\.\\-\\u0028\\u0029\\u002C\\u0021\\u003D\\u003B\\u002B\\u005D\\u005B\\u002A\\u2731\\*]")
        {

            //clean up the file name by taking out anythign thats NOT in one of the following
            //\w      :  alphanumeric char          _   :  underscore
            //        :  space  
            //\.      :  dot                       \-   :  minus or dash
            //\u0028  :  (  open bracket       \u0029   :  ) close bracket
            //\u005B  :  (  open bracket       \u005D   :  ) close bracket
            //\u002C  :  ,  comma              \u0021   :  ! exclamation mark 
            //\u003D   :  ; semicolon
            //\u003B  :  =  equal sign         \u002B   :  + plus sign

            //\u0027  :  '  apostrophe  is not cleaned out

            try
            {

                ProposedName = ProposedName.Replace(Environment.NewLine, "").Replace("\t", "").Replace("*", "");
                ProposedName = System.Text.RegularExpressions.Regex.Replace(ProposedName, CharToRemove, "");

                return ProposedName;

            }
            catch (Exception ex)
            {
             
                return ProposedName;

            }

        }

        public static object Catchnull(object objOld, object objNew, bool CheckEmptyString = false)
        {
            if (Convert.IsDBNull(objOld) || objOld == null || (CheckEmptyString && (string.IsNullOrEmpty(objOld.ToString().Trim()))))
            {
                return objNew;
            }
            else
            {
                return objOld;
            }
        }



    }

    public static class NumericHelper
    {
        public static bool IsNumeric(object expression)
        {
            if (expression == null)
                return false;

            double testDouble;
            if (expression is string)
            {
                CultureInfo provider;
                if (((string)expression).StartsWith("$"))
                    provider = new CultureInfo("en-US");
                else
                    provider = CultureInfo.InvariantCulture;

                if (double.TryParse((string)expression, NumberStyles.Any, provider, out testDouble))
                    return true;
            }
            else
            {
                if (double.TryParse(expression.ToString(), out testDouble))
                    return true;
            }

            //VB's 'IsNumeric' returns true for any boolean value:
            bool testBool;
            if (bool.TryParse(expression.ToString(), out testBool))
                return true;

            return false;
        }

        public static double Val(string expression)
        {
            if (expression == null)
                return 0;

            //try the entire string, then progressively smaller substrings to replicate the behavior of VB's 'Val', which ignores trailing characters after a recognizable value:
            for (int size = expression.Length; size > 0; size--)
            {
                double testDouble;
                if (double.TryParse(expression.Substring(0, size), out testDouble))
                    return testDouble;
            }

            //no value is recognized, so return 0:
            return 0;
        }

        public static double Val(object expression)
        {
            if (expression == null)
                return 0;

            double testDouble;
            if (double.TryParse(expression.ToString(), out testDouble))
                return testDouble;

            //VB's 'Val' function returns -1 for 'true':
            bool testBool;
            if (bool.TryParse(expression.ToString(), out testBool))
                return testBool ? -1 : 0;

            //VB's 'Val' function returns the day of the month for dates:
            DateTime testDate;
            if (DateTime.TryParse(expression.ToString(), out testDate))
                return testDate.Day;

            //no value is recognized, so return 0:
            return 0;
        }

        public static int Val(char expression)
        {
            int testInt;
            if (int.TryParse(expression.ToString(), out testInt))
                return testInt;
            else
                return 0;
        }

        public static Guid long2Guid(long value)
        {
            byte[] bytes = new byte[16];
            BitConverter.GetBytes(value).CopyTo(bytes, 0);
            return new Guid(bytes);
        }

        public static long Guid2long(Guid value)
        {
            byte[] b = value.ToByteArray();
            long bint = BitConverter.ToInt64(b, 0);
            return bint;
        }
    }

    public class General
    {
        

        public static string getServerName()
        {

            return ConfigurationManager.AppSettings["servername"].ToString();

        }

        public static string dataviewPage()
        {

            return ConfigurationManager.AppSettings["dataviewpage"].ToString();

        }

        public static string ImageToBase64(string ImagePath)
        {
            try
            {
                using (FileStream fs = new FileStream(ImagePath, FileMode.Open))
                {
                    System.IO.BinaryReader br = new System.IO.BinaryReader(fs);
                    byte[] bytes = br.ReadBytes((int)fs.Length);
                    string base64String = Convert.ToBase64String(bytes, 0, bytes.Length);
                    return base64String;
                }


                //Using ms As New MemoryStream(ImagePath)
                //    ' Convert Image to byte[] image.Save(ms, format)
                //    Dim imageBytes As Byte() = ms.ToArray()
                //    Dim base64String As String = Convert.ToBase64String(imageBytes)
                //    Return base64String
                //End Using

            }
            catch (Exception ex)
            {
            
                return string.Empty;
            }
        }


        public static string Base64ToImageString(string base64String)
        {
            try
            {
                // Convert Base64 String to byte[] 
                byte[] imageBytes = Convert.FromBase64String(base64String);
                MemoryStream ms = new MemoryStream(imageBytes, 0, imageBytes.Length);

                // Convert byte[] to Image
                ms.Write(imageBytes, 0, imageBytes.Length);
                System.IO.BinaryReader br = new System.IO.BinaryReader(ms);
                byte[] bytes = br.ReadBytes((int)ms.Length);
                string base64String2 = Convert.ToBase64String(bytes, 0, bytes.Length);
                return base64String2;

            }
            catch (Exception ex)
            {
            
                return null;
            }
        }
        public static Image Base64ToImage(string base64String)
        {
            try
            {
                // Convert Base64 String to byte[] 
                byte[] imageBytes = Convert.FromBase64String(base64String);
                MemoryStream ms = new MemoryStream(imageBytes, 0, imageBytes.Length);

                // Convert byte[] to Image
                ms.Write(imageBytes, 0, imageBytes.Length);
                Image ConvertedBase64Image = Image.FromStream(ms, true);
                return ConvertedBase64Image;

            }
            catch (Exception ex)
            {
             
                return null;
            }

        }


    }



}
