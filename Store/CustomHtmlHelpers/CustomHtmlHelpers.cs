using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Store.CustomHtmlHelpers
{
    public static class CustomHtmlHelpers
    {
        public static IHtmlString Image(this HtmlHelper helper,string src, string alt = " alternative text ",  object htmlAttributes = null)
        {
            TagBuilder tagBuilder = new TagBuilder("img");
            tagBuilder.Attributes.Add("src", VirtualPathUtility.ToAbsolute(src));
            tagBuilder.Attributes.Add("alt",alt);
            if(htmlAttributes != null) {
            tagBuilder.MergeAttributes(HtmlHelper.AnonymousObjectToHtmlAttributes(htmlAttributes)); }
            
            return new MvcHtmlString(tagBuilder.ToString(TagRenderMode.SelfClosing));
        }
    }
}