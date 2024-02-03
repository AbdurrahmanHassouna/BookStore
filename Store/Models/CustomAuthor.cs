using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace Store.Models
{
    [MetadataType(typeof(AuthorMetaData))]
    public partial class Author
    {
    }
    public class AuthorMetaData
    {
        [DisplayName("Author")]
        public string Name { get; set; }
    }
}