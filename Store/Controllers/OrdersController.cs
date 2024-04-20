using Store.HelperClasses;
using Store.Models;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Data.Entity.Migrations;
using System.IO;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;

namespace Store.Controllers
{
    [Authorize]
    public class OrdersController : Controller
    {
        private BookStore db = new BookStore();
        // GET: Orders

        public ActionResult ConfirmOrder(IEnumerable<CartItem> order)
        {

            var OrderItems = CartCookieHelper.GetCartItems(HttpContext);
            if (OrderItems.Count()==0)
            {
                RedirectToAction("Index", "Cart");
            }
            List<OrderItem> orderlist = new List<OrderItem>();
            foreach (var item in OrderItems)
            {
                Book book = db.Books.Where(b => b.Id==item.Key).Single();
                if (item.Value<=book.QuantityInStock)
                {
                    book.QuantityInStock = book.QuantityInStock-item.Value;
                    db.Entry(book).State = EntityState.Modified;
                    db.SaveChanges();
                }
                else 
                {
                    ViewBag.ErrorMessage = "unavailable Quantity";
                    return View("Error");
                }
                OrderItem OrderItem = new OrderItem();
                OrderItem.BookName = book.Name;
                OrderItem.Quantity = item.Value;
                OrderItem.Price = book.Price*item.Value;
                orderlist.Add(OrderItem);
            }

            Order orderData = new Order
            {
                UserId= db.Users.Where(u => u.Name==User.Identity.Name).Single().Id,
                OrderDate=DateTime.Now,
                TotalAmount =  orderlist.Select(n => n.Price).Sum()
            };

            db.Orders.Add(orderData);
            db.SaveChanges();
            foreach (var item in orderlist)
            {
                item.OrderTable=orderData;
            }
            db.OrderItems.AddRange(orderlist);
            db.SaveChanges();

            UpdateDataBase(order);
            CartCookieHelper.DeleteCookie(HttpContext);
            return View(orderlist);

        }
        [NonAction]
        public void UpdateDataBase(IEnumerable<CartItem> orderlist)
        {
            foreach (CartItem item in orderlist)
            {
                Book book = db.Books.Where(b => b.Id == item.BookID).Single();

                book.QuantityInStock -= item.Quantity;
                if (book.QuantityInStock == 0)
                {
                    book.IsVisible = false;
                }

                db.Books.AddOrUpdate(book);
                db.SaveChanges();
            }

        }


        // GET: Orders
        [Authorize(Roles = "Admin")]
        public ActionResult Index(DateTime? startDate, DateTime? endDate)
        {
            var orders = db.Orders.Include(o => o.OrderItems);

            // Filter orders by date if start and end dates are provided
            if (startDate != null && endDate != null)
            {
                orders = orders.Where(o => o.OrderDate >= startDate && o.OrderDate <= endDate);
            }

            return View(orders.ToList());
        }

        // GET: Order Details
        [Authorize(Roles = "Admin")]
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Order order = db.Orders.Find(id);
            /*order.OrderItems = db.OrderItems.Where(o => o.OrderID == order.OrderID).ToList();*/
            if (order == null)
            {
                return HttpNotFound();
            }
            return View(order);
        }
    }




}
