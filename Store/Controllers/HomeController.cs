using PagedList;
using Store.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Data.Entity;

namespace Store.Controllers
{
    public class HomeController : Controller
    {
        private BookStore db = new BookStore();


        public JsonResult AutoComplete(string term)
        {
            List<string> result = db.Books.Where(b => b.Name.StartsWith(term)&& b.IsVisible==true).Select(n => n.Name).ToList();
            result.AddRange(db.Books.Where<Book>(b => b.Name.Contains(term) && !b.Name.StartsWith(term)).Select(n => n.Name));
            return Json(result, JsonRequestBehavior.AllowGet);
        }
        public ActionResult Index(int? page)
        {
            var books = db.Books.Where(b => b.IsVisible==true).Include(b => b.Author).Include(b => b.Category).OrderBy(b => b.Name);
            return View(books.ToPagedList(page ?? 1, 25));
        }
        [HttpPost]
        public ActionResult Index(int? page, string Search)
        {
            var books = db.Books.Include(b => b.Author).Include(b => b.Category).Where(b => b.Name.StartsWith(Search)&& b.IsVisible==true).OrderBy(b => b.Name).ToList();
            books.AddRange(db.Books.Include(b => b.Author).Include(b => b.Category).Where(b => b.Name.Contains(Search)&& b.IsVisible==true && !b.Name.StartsWith(Search)).OrderBy(b => b.Name));
            return View(books.ToPagedList(page ?? 1, 25));
        }
        public ActionResult IndexAuthor(int authorId)
        {
            var books = db.Books.Where(b => b.AuthorId==authorId && b.IsVisible==true).OrderBy(b => b.Name);
            return View("Index", books.ToPagedList(1, 25));
        }
        public ActionResult IndexCategory(int CategoryId)
        {
            var books = db.Books.Where(b => b.CategoryId==CategoryId && b.IsVisible==true).OrderBy(b => b.Name);
            return View("Index", books.ToPagedList(1, 25));
        }

    }
}