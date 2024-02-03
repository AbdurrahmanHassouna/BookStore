using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace Store.Models
{
    [MetadataType(typeof(CategoryMetaData))]
    public partial class Category
    {

    }
    public class CategoryMetaData
    {
        [Display(Name = "Category")]
        public string Name { get; set; }
    }
}