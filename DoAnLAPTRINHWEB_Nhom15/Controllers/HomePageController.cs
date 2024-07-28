using DoAnLAPTRINHWEB_Nhom15.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using DoAnLAPTRINHWEB_Nhom15.Areas.Admin.Models;
using DoAnLAPTRINHWEB_Nhom15.Models;
using System.Data;
using System.Net.Mail;
using System.Net.Http;
using Newtonsoft.Json.Linq;

namespace DoAnLAPTRINHWEB_Nhom15.Controllers
{
 
    public class HomePageController : Controller
    {
        //
        // GET: /HomePage/
        ConnectProduct pro = new ConnectProduct();
        List<Products> listProduct = new List<Products>();

        ConnectGioHang connectGH = new ConnectGioHang();
        List<GioHang> listGioHang = new List<GioHang>();

        List<DonHang> listDonHang = new List<DonHang>();
        ConnectDonHang connectDH = new ConnectDonHang();

        List<ChiTietDonHang> listCTDonHang = new List<ChiTietDonHang>();
        ConnectChiTietDonHang connectCTDH = new ConnectChiTietDonHang();

        ConnectTaiKhoan connectTaiKhoan = new ConnectTaiKhoan();
        List<TaiKhoan> listTaiKhoan = new List<TaiKhoan>();

        LoginTest logintest = new LoginTest();
        string txtLoai;
        public ActionResult DangXuat()
        {
            Session.Abandon(); // Xóa toàn bộ session data, hoặc bạn có thể xóa các phần tử cụ thể khỏi session

            return RedirectToAction("PageHome", "HomePage");
        }
        public ActionResult PageHome()
        {
            listProduct = pro.getData().Take(4).ToList();
            return View(listProduct);
        }
        //------------------PRODUCT---------------------
        public ActionResult HomeProduct()
        {
            listProduct = pro.getData();
            ViewBag.SLSP = listProduct.Count();
            return View(listProduct);
        }
        [HttpPost]
        public ActionResult HomeProduct(string txtTenSP)
        {
            listProduct = pro.search(txtTenSP, "","" );

            ViewBag.mess = "";
            if (listProduct.Count == 0)
            {
                ViewBag.mess = "Không tìm thấy!";
            }
            ViewBag.txtTenSP = txtTenSP;
            ViewBag.SLSP = listProduct.Count();
            return View(listProduct);
        }
        public ActionResult ProductByType(string txtType)
        {
            ViewBag.Type = txtType;
            listProduct = pro.ProductByType(txtType);
            ViewBag.SLSP = listProduct.Count();
            return View(listProduct);
        }
        [HttpPost]
        public ActionResult ProductBySelected(string txtPrice)
        {
            string selectedsp = "";
            if (txtPrice == "ASC")
                selectedsp = "Theo giá: Thấp đến cao";
            if (txtPrice == "DESC")
                selectedsp = "Theo giá: Cao đến thấp";
            if (txtPrice == "Default")
                selectedsp = "Mặc định";
            if (txtPrice == "Popular")
                selectedsp = "Phổ biến";
            if (txtPrice == "ByTheMost")
                selectedsp = "Mua nhiều nhất";
            ViewBag.selected = selectedsp;
            string type = ViewBag.Type;
            listProduct = pro.ProductBySelected(txtPrice, type);
            ViewBag.SLSP = listProduct.Count();
            return View(listProduct);
        }

        public ActionResult HomeDetail(string masp)
        {
            ProductDetail a = pro.ChiTietSP(masp);
            ViewBag.MaLoai = pro.getMaLoai(masp).ToString();
            return View(a);
        }
        //------------------ĐĂNG NHẬP---------------------
        public ActionResult DangNhap()
        {
            return View();
        }
        [HttpPost]
        public ActionResult DangNhap(string UserName, string Email, string Password)
        {
            int loi = 0;
            ViewBag.UserName = UserName;
            if (String.IsNullOrEmpty(UserName))
            {
                ViewBag.LoiUserName = "Tài khoản không được để trống";
                loi++;
            }

            ViewBag.Email = Email;
            if (String.IsNullOrEmpty(Email))
            {
                ViewBag.LoiEmail = "Email không được để trống";
                loi++;
            }
            if (IsEmailAddress(Email) == false && Email.Length!=0)
            {
                ViewBag.LoiEmail = "Sai định dạng email";
                loi++;
            }

            ViewBag.Password = Password;
            if (Password.Length==0)
            {
                ViewBag.LoiPassword = "Mật khẩu không được để trống";
                loi++;
            }
            if(loi==0)
            {
                int kt = logintest.LoginTestt(UserName, Email, Password);
                if (kt == 1)
                {
                    Session["User"] = UserName;
                    return RedirectToAction("AdminHome", "Admin/HomeAdmin");
                }
                if (kt == 2)
                {
                    Session["User"] = UserName;
                    return RedirectToAction("PageHome", "HomePage");
                }
                if (kt == 0)
                {
                    Session["User"] = null;
                    ViewBag.LoiDangNhap = "Sai thông tin đăng nhập";
                    return View();
                }
            }

            //user = new DangNhap(UserName, Email, Password);
            return View();
        }
        public bool IsEmailAddress(string email)
        {
            try
            {
                if (email.Length > 0)
                {
                    MailAddress emailAddress = new MailAddress(email);
                    return true;
                }
                return false;
            }
            catch (FormatException)
            {
                return false;
            }
        }
        public ActionResult DangKy()
        {
            return View();
        }
        [HttpPost]
        public ActionResult DangKy(FormCollection f)
        {
            int loi = 0;
            TaiKhoan tk = new TaiKhoan();
            tk.Email = f["Email"].ToString();
            tk.HoTen = f["HoTen"].ToString();          
            tk.NgaySinh = f["NgaySinh"].ToString();
            tk.GioiTinh = f["GioiTinh"].ToString();
            tk.SoDienThoai = f["SoDienThoai"].ToString();
            tk.TenDN = f["TenDN"].ToString();
            tk.MatKhau = f["MatKhau"].ToString();

            ViewBag.Email = tk.Email;
            if (String.IsNullOrEmpty(tk.Email))
            {
                ViewBag.LoiEmail = "Email không được để trống";
                loi++;
            }
            if (IsEmailAddress(tk.Email)==false &&tk.Email!="")
            {
                ViewBag.LoiEmail = "Sai định dạng email";
                loi++;
            }

            ViewBag.HoTen = tk.HoTen;
            if (String.IsNullOrEmpty(tk.HoTen))
            {
                ViewBag.LoiHoTen = "Họ tên không được để trống";
                loi++;
            }

            ViewBag.NgaySinh = tk.NgaySinh;
            if (tk.NgaySinh.Length == 0)
            {
                ViewBag.LoiNgaySinh = "Ngày sinh không được để trống";
                loi++;
            }
            else
            {
                DateTime d = DateTime.Parse(tk.NgaySinh);
                if (d >= DateTime.Now)
                {
                    ViewBag.LoiNgaySinh = "Ngày sinh không hợp lệ";
                    loi++;
                }
            }

            ViewBag.GioiTinh = tk.GioiTinh;
            if (String.IsNullOrEmpty(tk.GioiTinh))
            {
                ViewBag.LoiGioiTinh = "Giới không được để trống";
                loi++;
            }

            ViewBag.SoDienThoai = tk.SoDienThoai;

            if (tk.SoDienThoai.Length != 10)
            {
                ViewBag.LoiSoDienThoai = "Sai định dạng số điện thoại";
                loi++;
            }
            if (String.IsNullOrEmpty(tk.SoDienThoai))
            {
                ViewBag.LoiSoDienThoai = "Số điện thoại được để trống";
                loi++;
            }

            ViewBag.TenDN = tk.TenDN;

            if (String.IsNullOrEmpty(tk.TenDN))
            {
                ViewBag.LoiTenDN = "Tài khoản không được để trống";
                loi++;
            }

            ViewBag.MatKhau = tk.MatKhau;
            if (String.IsNullOrEmpty(tk.MatKhau))
            {
                ViewBag.LoiMatKhau = "Mật khẩu không được để trống";
                loi++;
            }

            string MatKhauRetype= f["MatKhau2"].ToString();
            ViewBag.MatKhau2 = MatKhauRetype;
            if (MatKhauRetype != tk.MatKhau)
            {
                ViewBag.LoiMatKhau2 = "Mật khẩu nhập lại phải trùng với mật khẩu";
                loi++;
            }
            if (String.IsNullOrEmpty(MatKhauRetype))
            {
                ViewBag.LoiMatKhau2 = "Mật khẩu nhập lại không được để trống";
                loi++;
            }
  

            if (loi == 0)
            {
                int rs = connectTaiKhoan.TestDangKy(tk);
                return RedirectToAction("DangNhap");
            }
            return View();
        }
        public ActionResult ForgotPass()
        {
            return View();
        }

        public ActionResult DiaChi()
        {
            DiaChi dc = new DiaChi();
            string TenDN2 = Session["User"].ToString();
            dc = connectTaiKhoan.ShowDiaChi(TenDN2);
            ViewBag.DiaChi = dc.ChiTietDiaChi;
            ViewBag.DiaChi2 = dc.ChiTietDiaChi2;
            return View();
        }
        //[HttpPost]
        //public ActionResult DiaChi(FormCollection f)
        //{
        //   string TenDN2 = Session["User"].ToString();
        //    DiaChi dc = new DiaChi();          

        //    dc.ChiTietDiaChi = f["ChiTietDiaChi"].ToString();
        //    dc.ChiTietDiaChi2 = f["ChiTietDiaChi2"].ToString();
        //    int rs = connectTaiKhoan.AddDiaChi(TenDN2,dc);

        //    return RedirectToAction("ShowTaiKhoanUser");
        //}

        public ActionResult UpDateDiaChi(string id,string text)
        {
            Session["idDiaChi"] = id;
            Session["text"] = text;
            return View();
        }
        [HttpPost]
        public ActionResult UpDateDiaChi( FormCollection f)
        {
            string tinhhuyenxa = f["hiddenResult"];
            string duong = f["duong"].ToString();
            string diachinumber = Session["idDiaChi"].ToString();// kiểm tra xem đang sửa ở địa chỉ 1 hay 2 bên connect
            string TenDN2 = Session["User"].ToString();
            string diachi = duong + ", " + tinhhuyenxa;
            int rs = connectTaiKhoan.IUDiaChi(TenDN2, diachinumber, diachi);
            return RedirectToAction("DiaChi");
        }
        //------------------GIỎ HÀNG---------------------
        public ActionResult HomeGioHang()
        {
            if (Session["User"] == null)
                return RedirectToAction("DangNhap");
            else
            {
                ViewBag.User = Session["User"];
                string TenDN = Session["User"].ToString();
                listGioHang = connectGH.layGioHang(TenDN);
                Session["GioHang"] = listGioHang;
                DiaChi dc = new DiaChi();
                dc = connectTaiKhoan.ShowDiaChi(TenDN);
                ViewBag.DiaChi = dc.ChiTietDiaChi;
                ViewBag.DiaChi2 = dc.ChiTietDiaChi2;

                TaiKhoan tk = new TaiKhoan();
                tk = connectTaiKhoan.getTaiKhoan(TenDN);
                ViewBag.HoTen = tk.HoTen;
                ViewBag.SoDT = tk.SoDienThoai;

                return View(listGioHang);
            }
        }
        public ActionResult AddGioHang(string MaSP)
        {
            if (Session["User"] == null)
                return RedirectToAction("DangNhap");
            else
            {
                string TenDN = Session["User"].ToString();
                int rs = connectGH.ThemGioHang(MaSP, TenDN);
                return RedirectToAction("HomeProduct");
            }
        }
        public ActionResult AddGioHang2(string MaSP, FormCollection f)
        {
            if (Session["User"] == null)
                return RedirectToAction("DangNhap");
            else
            {
                string TenDN = Session["User"].ToString();
                string soluong = f["SoLuong"].ToString();
                int rs = connectGH.ThemGioHang2(MaSP, TenDN, soluong);
                return RedirectToAction("HomeGioHang");
            }
        }
        public ActionResult DeleteGioHang(string MaSP)
        {
            string TenDN = Session["User"].ToString();
            int rs = connectGH.XoaGioHang(MaSP, TenDN);
            return RedirectToAction("HomeGioHang");
        }
        public ActionResult UpdateSoLuongGH(string MaSP, FormCollection f)
        {
            int SoLuong = int.Parse(f["SoLuong"].ToString());
            string TenDN = Session["User"].ToString();
            int rs = connectGH.UpdateSoLuong(MaSP, TenDN, SoLuong);
            return RedirectToAction("HomeGioHang");
        }

        public ActionResult ViewTongSoLuong()
        {
            ViewBag.TongSL = TongSoLuong();
            return PartialView();
        }
        public int TongSoLuong()
        {
            int tsl = 0;
            var listGioHang = Session["GioHang"] as List<GioHang>;
            if (listGioHang != null)
            {
                tsl = listGioHang.Sum(sp => sp.SoLuong);
            }
            return tsl;
        }

        //------------------ĐẶT HÀNG---------------------
        public ActionResult DatHang(FormCollection f)
        {
            string TenDN = Session["User"].ToString();
            DonHang dh = new DonHang();
            dh.TenDN = TenDN;
            dh.NgayDat = DateTime.Now.ToString("yyyy/MM/dd hh:mm:ss");//Thay đổi NgayDat Date; trong Database thành DateTime
            string httt = f["thanhtoan"].ToString();
            if (httt == "1")
                dh.HinhThucThanhToan = "Ví điện tử";
            else if (httt == "2")
                dh.HinhThucThanhToan = "Thẻ tín dụng";
            else
                dh.HinhThucThanhToan = "Thanh toán khi nhận hàng";
            dh.ChiTietDiaChi = f["ChiTietDiaChi"].ToString();
            if(dh.ChiTietDiaChi.Length==0)
            {
                ViewBag.LoiDiaChi = "Vui lòng chọn địa chỉ";
                return RedirectToAction("HomeGioHang");
            }    
            dh.HoTen= f["HoTen"].ToString();
            dh.SoDienThoai= f["SoDienThoai"].ToString();

            int rs = connectDH.ThemDonHang(dh);
            dh.MaDonHang = connectDH.LayMaDH(TenDN, dh.NgayDat);
            var listGH = Session["GioHang"] as List<GioHang>;
            foreach(var item in listGH)
            {
                ChiTietDonHang ctdh = new ChiTietDonHang();
                ctdh.MaDonHang = dh.MaDonHang;
                ctdh.MaSanPham = item.MaSanPham;
                ctdh.SoLuong = item.SoLuong;
                int k = connectCTDH.themChiTietDonHang(ctdh);
             
            }
            connectDH.update1DonHang(dh.MaDonHang);
            connectGH.XoaTatCaGioHang(TenDN);
            return RedirectToAction("HomeGioHang");
        }
        //------------------ĐƠN HÀNG---------------------
        public ActionResult ShowDonHangByTenDN(string TenDN)
        {
            TenDN = Session["User"].ToString();
            listDonHang = connectDH.ShowDonHangByTenDN(TenDN);
            ViewBag.TongDH = listDonHang.Count();
            return View(listDonHang);
        }
        public ActionResult ShowCTDonHangByTenDN(string MaDH)
        {
            List<ChiTietDonHang> lstCTDH = new List<ChiTietDonHang>();         
            lstCTDH = connectCTDH.getCTHDByTenDN(MaDH) ;         
            return View(lstCTDH);
        }
        public ActionResult DeleteDonHangByTenDN(int MaDH,FormCollection f)
        {
           
            int rs = connectDH.deleteDonHang(MaDH);
            return RedirectToAction("ShowDonHangByTenDN");
        }
        //------------------USER---------------------
        public ActionResult ShowTaiKhoanUser(string Tendn)
        {
            Tendn = Session["User"].ToString();
            TaiKhoan taikhoan = new TaiKhoan();
            taikhoan = connectTaiKhoan.getTaiKhoan(Tendn);
            Session["AnhUser"] = taikhoan.AnhBiaUser;
            return View(taikhoan);
        }
        public ActionResult UpdateTaiKhoan(string TenDN, FormCollection f)
        {
            TaiKhoan tk = new TaiKhoan();
            tk.HoTen = f["HoTen"].ToString();
            tk.Email = f["Email"].ToString();
            tk.NgaySinh = f["NgaySinh"].ToString();
            tk.GioiTinh = f["GioiTinh"].ToString();
            tk.SoDienThoai = f["SoDienThoai"].ToString();
            tk.TenDN = Session["User"].ToString();
            int rs = connectTaiKhoan.UpdateTaiKhoan(tk);
            return RedirectToAction("ShowTaiKhoanUser");
        }

        public ActionResult UpdateMatKhau()
        {
            return View();
        }
        [HttpPost]
        public ActionResult UpdateMatKhau(string TenDN, FormCollection f)
        {
            TenDN = Session["User"].ToString();
            string mk = f["MatKhau"].ToString();
            connectTaiKhoan.updateMatKhau(TenDN,mk);
            return RedirectToAction("ShowTaiKhoanUser");
        }
    }
}