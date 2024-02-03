using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Store.HelperClasses
{
    public class CartCookieHelper
    {
        public static void SetCartItems(HttpContextBase httpContext, Dictionary<int, int> items)
        {
            // Serialize and store the item IDs in a cookie
            var serializedItems = JsonConvert.SerializeObject(items);
            var cookie = new HttpCookie("CartItems", serializedItems);

            httpContext.Response.Cookies.Add(cookie);
        }

        public static Dictionary<int, int> GetCartItems(HttpContextBase httpContext)
        {
            // Deserialize and retrieve the item IDs from the cookie
            var cookie = httpContext.Request.Cookies["CartItems"];

            return (cookie != null)
                ? JsonConvert.DeserializeObject<Dictionary<int, int>>(cookie.Value)
                : new Dictionary<int, int>();
        }
        public static void DeleteCookie(HttpContextBase httpContext)
        {
            httpContext.Request.Cookies.Remove("CartItems");
            var cookie = new HttpCookie("CartItems")
            {
                Expires = DateTime.Now.AddYears(-1)
            };

            httpContext.Response.Cookies.Add(cookie);
        }
        public static void ClearCart(HttpContextBase httpContext)
        {
            httpContext.Response.Cookies.Clear();
        }
    }
}