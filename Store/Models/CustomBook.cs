using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Xml.Linq;

namespace Store.Models
{
    [MetadataType(typeof(BookMetaData))]
    public partial class Book
    {
        public HttpPostedFileBase BookCoverFile { get; set; }
        public SelectList selectListItems { get; set; }
    }

    public class BookMetaData
    {
        [Display(Name = "Rating"), Range(0, 5, ErrorMessage = "max rating is 5 stars")]

        public double BookStar { get; set; }
        [Display(Name = "Book Name"), Required]
        public string Name { get; set; }
        [Required]
        public string Format { get; set; }
        [Required]
        public long ISBN { get; set; }
        [Required]
        public decimal Price { get; set; }
        [Required, DisplayName("Categroy")]
        public int CategoryId { get; set; }
        [Required, DisplayName("Author")]
        public int AuthorId { get; set; }
        [Required, DisplayFormat(DataFormatString = "{0:dd/MM/yyyy}"), DisplayName("Publication Date")]
        public System.DateTime PublicationYear { get; set; }

        [Required, Display(Name = "Quantity")]
        public int QuantityInStock { get; set; }
        [Display(Name = "Soft delete")]
        public bool IsDeleted { get; set; }
        [Display(Name = "Is Visible")]
        public bool IsVisible { get; set; }
        [DisplayFormat(DataFormatString = "{0:dd/MM/yyyy mm:HH}"),
            DisplayName("Creation Date")]
        public System.DateTime CreatedDate { get; set; }
        [DisplayFormat(DataFormatString = "{0:dd/MM/yyyy mm:HH}"),
            DisplayName("Last Edited")]
        public System.DateTime UpdatedDate { get; set; }

        [Display(Name = "Book Cover")]
        public HttpPostedFileBase BookCoverFile { get; set; }
        public SelectList selectListItems { get; set; }
    }
}