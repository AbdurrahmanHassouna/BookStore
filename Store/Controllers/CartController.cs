using Microsoft.AspNet.Identity;
using Store.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.Mvc;
using System.Web.Security;
using Store.HelperClasses;
using System.Runtime.Remoting.Messaging;

namespace Store.Controllers
{
    [Authorize]
    public class CartController : Controller
    {
        private BookStore db = new BookStore();

        public JsonResult AutoComplete(string term)
        {
            List<string> result = db.Books.Where(b => b.Name.StartsWith(term)).Select(n => n.Name).ToList();
            result.AddRange(db.Books.Where(b => b.Name.Contains(term)).Select(n => n.Name));
            return Json(result, JsonRequestBehavior.AllowGet);
        }
        [HttpPost]
        public ActionResult AddToCart(int Id)
        {
            if (!User.Identity.IsAuthenticated)
            {
                return new HttpUnauthorizedResult();
            }
            var carItems = CartCookieHelper.GetCartItems(HttpContext);

            if (!carItems.ContainsKey(Id))
            {
                carItems.Add(Id, 1);
            }
            else
            {
                carItems[Id] += 1;
            }
            CartCookieHelper.SetCartItems(HttpContext, carItems);
            int cartCount = (carItems.Count);

            return PartialView("_CartCount", cartCount);
        }
        public void AddToCartp(int[] ids)
        {
            foreach (int id in ids)
            {
                AddToCart(id);
            }
        }

        [HttpPost]
        public ActionResult UpdateCart(int Quantity, int Id)
        {
            if (!User.Identity.IsAuthenticated)
            {
                return new HttpUnauthorizedResult();
            }
            var cartItems = CartCookieHelper.GetCartItems(HttpContext);
            if (Quantity == 0)
            {
                cartItems.Remove(Id);
            }
            else
            {
                if (!cartItems.ContainsKey(Id))
                {
                    cartItems.Add(Id, Quantity);
                }
                else
                {
                    cartItems[Id] = Quantity;
                }
            }
            CartCookieHelper.SetCartItems(HttpContext, cartItems);
            Cart cart = new Cart();
            List<CartItem> cartlist = new List<CartItem>();
            foreach (var item in cartItems)
            {
                CartItem cartItem = new CartItem();
                cartItem.Book = db.Books.Where(b => b.Id == item.Key).Single();
                cartItem.Quantity = item.Value;
                cartItem.Price = cartItem.Book.Price*cartItem.Quantity;
                int maxQuantity = Math.Min(cartItem.Book.QuantityInStock, 10);
                var quantityList = Enumerable.Range(1, maxQuantity).Select(x => new SelectListItem
                {
                    Text = x.ToString(),
                    Value = x.ToString()
                });
                cartItem.Book.selectListItems = new SelectList(quantityList, "Value", "Text", cartItem.Quantity);

                cart.CartItems.Add(cartItem);

            }
            return PartialView("_Cart", cart.CartItems);
        }
        public ActionResult Index()
        {
            var cartItems = CartCookieHelper.GetCartItems(HttpContext);
            List<CartItem> cartlist = new List<CartItem>();
            foreach (var item in cartItems)
            {
                CartItem cartItem = new CartItem();
                cartItem.Book = db.Books.Where(b => b.Id == item.Key).Single();
                cartItem.Quantity = item.Value;
                cartItem.Price = cartItem.Book.Price*cartItem.Quantity;
                int maxQuantity = Math.Min(cartItem.Book.QuantityInStock, 10);
                var quantityList = Enumerable.Range(1, maxQuantity).Select(x => new SelectListItem
                {
                    Text = x.ToString(),
                    Value = x.ToString()
                });
                cartItem.Book.selectListItems = new SelectList(quantityList, "Value", "Text", cartItem.Quantity);
                cartlist.Add(cartItem);
            }
            return View(cartlist);
        }
        [HttpPost]
        public ActionResult Delete(int id)
        {
            Dictionary<int, int> cartItems = CartCookieHelper.GetCartItems(HttpContext);
            cartItems.Remove(id);
            List<CartItem> cartlist = new List<CartItem>();
            foreach (var item in cartItems)
            {
                CartItem cartItem = new CartItem();
                cartItem.Book = db.Books.Where(b => b.Id == item.Key).Single();
                cartItem.Quantity = item.Value;
                cartItem.Price = cartItem.Book.Price*cartItem.Quantity;
                int maxQuantity = Math.Min(cartItem.Book.QuantityInStock, 10);
                var quantityList = Enumerable.Range(1, maxQuantity).Select(x => new SelectListItem
                {
                    Text = x.ToString(),
                    Value = x.ToString()
                });
                cartItem.Book.selectListItems = new SelectList(quantityList, "Value", "Text", cartItem.Quantity);
                cartlist.Add(cartItem);
            }
            CartCookieHelper.SetCartItems(HttpContext, cartItems);
            return PartialView("_Cart", cartlist);
        }
    }
}