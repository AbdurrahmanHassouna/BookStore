using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using System.Web.UI.WebControls;
using Store.Models;
using PagedList;
using System.IO;
using System.Data.Entity.Migrations;

namespace Store.Controllers
{
    [Authorize]
    public class BooksController : Controller
    {
        public BookStore db = new BookStore();

        public JsonResult AutoComplete(string term)
        {
            List<string> result = db.Books.Where(b => b.Name.StartsWith(term)).Select(n => n.Name).ToList();
            result.AddRange(db.Books.Where(b => b.Name.Contains(term) && !b.Name.StartsWith(term)).Select(n => n.Name));
            return Json(result, JsonRequestBehavior.AllowGet);
        }
        // GET: Books
        public JsonResult Name(string Name)
        {
            return Json(db.Books.Any(b => b.Name==Name), JsonRequestBehavior.AllowGet);
        }
        public ActionResult Index(int? page)
        {
            var books = db.Books.Include(b => b.Author).Include(b => b.Category).OrderBy(b => b.Name);
            return View(books.ToPagedList(page ?? 1, 25));
        }
        [HttpPost]
        public ActionResult Index(int? page, string Search, bool? outOfStock)
        {
            List<Book> books;
            if (!outOfStock==true)
            {
                books = db.Books.Include(b => b.Author).Include(b => b.Category).Where(b => b.Name.StartsWith(Search)).OrderBy(b => b.Name).ToList();
                books.AddRange(db.Books.Include(b => b.Author).Include(b => b.Category).Where(b => b.Name.Contains(Search)&& !b.Name.StartsWith(Search)).OrderBy(b => b.Name));
            }
            else
            {
                books = db.Books.Include(b => b.Author).Include(b => b.Category).Where(b => b.Name.StartsWith(Search) && b.QuantityInStock != 0).OrderBy(b => b.Name).ToList();
                books.AddRange(db.Books.Include(b => b.Author).Include(b => b.Category).Where(b => b.Name.Contains(Search)&& !b.Name.StartsWith(Search) && b.QuantityInStock != 0).OrderBy(b => b.Name));
            }
            return View(books.ToPagedList(page ?? 1, 25));
        }


        // GET: Books/Details/5

        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Book book = db.Books.Find(id);
            if (book == null)
            {
                return HttpNotFound();
            }
            return View(book);
        }

        // GET: Books/Create

        [Authorize(Roles = "Admin")]
        public ActionResult Create()
        {
            ViewBag.AuthorId = new SelectList(db.Authors, "Id", "Name");
            ViewBag.CategoryId = new SelectList(db.Categories, "Id", "Name");
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "Name,Format,BookStar,ISBN,Price,BookCoverFile,CategoryId,AuthorId")] Book book)
        {
            if (ModelState.IsValid)
            {
                if (book.BookCoverFile != null && book.BookCoverFile.ContentLength > 0)
                {
                    string fileName = Path.GetFileName(book.BookCoverFile.FileName);
                    string filePath = Path.Combine(Server.MapPath("~/book-covers/UploadedCovers"), fileName);
                    book.BookCoverFile.SaveAs(filePath);
                    book.img_path = "~/book-covers/UploadedCovers/"+fileName;
                }
                book.IsDeleted=false;
                book.IsVisible=true;

                book.CreatedDate = DateTime.Now;
                book.UpdatedDate = DateTime.Now;

                db.Books.Add(book);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.AuthorId = new SelectList(db.Authors, "Id", "Name", book.AuthorId);
            ViewBag.CategoryId = new SelectList(db.Categories, "Id", "Name", book.CategoryId);
            return View(book);
        }

        // GET: Books/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Book book = db.Books.Find(id);
            if (book == null)
            {
                return HttpNotFound();
            }
            ViewBag.AuthorId = new SelectList(db.Authors, "Id", "Name", book.AuthorId);
            ViewBag.CategoryId = new SelectList(db.Categories, "Id", "Name", book.CategoryId);
            return View(book);
        }

        // POST: Books/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "Id,Name,QuantityInStock,BookStar,Format,ISBN,Price,CategoryId,AuthorId,IsDeleted,IsVisible")] Book book)
        {
            Book bookData = db.Books.Where(b => b.Id == book.Id).FirstOrDefault();
            book.CreatedDate= bookData.CreatedDate;
            book.UpdatedDate=DateTime.Now;
            book.img_path = bookData.img_path;
            book.Description=bookData.Description;
            if (book.IsDeleted == null)
            {
                book.IsDeleted= bookData.IsDeleted;
            }
            book.PublicationYear= bookData.PublicationYear;

            if (ModelState.IsValid)
            {
                db.Books.AddOrUpdate(book);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.AuthorId = new SelectList(db.Authors, "Id", "Name", book.AuthorId);
            ViewBag.CategoryId = new SelectList(db.Categories, "Id", "Name", book.CategoryId);
            return View(book);
        }

        // GET: Books/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Book book = db.Books.Find(id);
            if (book == null)
            {
                return HttpNotFound();
            }
            return View(book);
        }

        // POST: Books/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {

            Book book = db.Books.Find(id);
            db.Books.Remove(book);
            db.SaveChanges();
            try
            {
                /*string fileName = Path.GetFileName(book.img_path.Split('/').Last());*/
                string filePath = Path.Combine(Server.MapPath(book.img_path));
                FileInfo fileInfo = new FileInfo(filePath);
                fileInfo.Delete();
            }
            catch (Exception ex)
            {
                // what to write 18:31
            }
            return RedirectToAction("Index");
        }
        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }
        public static int stock(int id)
        {
            BookStore db = new BookStore();
            int num = db.Books.Where(d => d.Id == id).Single().QuantityInStock;
            return num;
        }
    }

}
