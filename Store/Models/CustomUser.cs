using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Store.Models
{
    [MetadataType(typeof(UserMetaData))]
    public partial class User
    {


    }
    public class UserMetaData
    {
        [Remote("IsUserNameAvailable", "Account", ErrorMessage = "User Name already Used")]
        [Required, MinLength(5)]
        public string Name { get; set; }
        [Required, MinLength(4), DataType(DataType.Password)]
        public string Password { get; set; }
    }
}