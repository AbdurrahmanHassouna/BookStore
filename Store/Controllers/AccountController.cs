using Store.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;
using Store.HelperClasses;
using System.Web.Configuration;
using System.Xml.Linq;
namespace Store.Controllers
{
    public class AccountController : Controller
    {
        private readonly BookStore _dbContext;

        public AccountController()
        {
            _dbContext = new BookStore();
        }
        public ActionResult SignUp()
        {
            return View();
        }
        [HttpPost]
        public ActionResult SignUp(User model)
        {

            if (_dbContext.Users.Select(u => u.Name).Contains(model.Name))
            {
                ModelState.AddModelError("Name", "Used User Name");
                return View(model);
            }
            if (ModelState.IsValid)
            {
                _dbContext.Users.Add(new User { Name = model.Name, Password = model.Password });
                _dbContext.SaveChanges();
                _dbContext.UserRolesMappings.Add(new UserRolesMapping
                {
                    UserID = _dbContext.Users.Where(u => u.Name == model.Name).Select(u => u.Id).Single()
                    ,
                    RoleID = _dbContext.RoleMasters.Where(u => u.RollName=="Customer").Select(u => u.ID).Single()
                });
                _dbContext.SaveChanges();


                FormsAuthentication.SetAuthCookie(model.Name, false);

                return RedirectToAction("Index", "Home");
            }
            return View(model);
        }
        /*public JsonResult IsUserNameAvailable(string Name)
        {
            return Json(!_dbContext.Users.Any(u => u.Name == Name), JsonRequestBehavior.AllowGet);
        }*/
        public ActionResult Login()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Login(User model)
        {
            if (ModelState.IsValid)
            {
                var user = _dbContext.Users.SingleOrDefault(u => u.Name == model.Name);


                if (user == null)
                {
                    ModelState.AddModelError("Name", "Invalid username");

                    return View(model);
                }
                if (user.Password !=  model.Password)
                {
                    ModelState.AddModelError("Password", "wrong password");
                    return View(model);
                }


                FormsAuthentication.SetAuthCookie(model.Name, false);
                return RedirectToAction("Index", "Home");
            }
            return View(model);
        }
        public ActionResult Logout()
        {

            CartCookieHelper.DeleteCookie(HttpContext);
            FormsAuthentication.SignOut();
            return RedirectToAction("Index", "Home");
        }
    }
}