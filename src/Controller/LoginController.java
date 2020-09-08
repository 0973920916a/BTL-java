package Controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import Entity.Accounts;
import Entity.Products;

@Controller
public class LoginController {
	@RequestMapping(value="login",method= RequestMethod.POST)
	public String xulidangnhap(ModelMap model,HttpServletRequest request) {
		String re="home";
		try {
			boolean isSuccess=false;
			String id=request.getParameter("username");
			String pa=request.getParameter("password");
			ArrayList<Accounts> list = SelectThanhVien("");
			System.out.println("so luong:"+list.size());
			for(Accounts t:list) {
				if(t.getName().equals(id)&&t.getPassword().equals(pa)) {
					isSuccess=true;
					makeuser(request, t);
					break;
				}
			}
			if(isSuccess==false) {
				request.setAttribute("message", "Tên tài khoản hoặc mật khẩu sai");
				re="login";
			}else {
				ArrayList<Products> list2=SelectSanpham("");
				request.setAttribute("list", list2);
			}
			
		} catch (Exception e) {
			System.out.println("loin xulidangnhap :"+e);
		}
		return re;
	};
	
	
	@Autowired
	SessionFactory factory;
	
	@Transactional
	public ArrayList<Products> SelectSanpham(String addmore) {
		ArrayList<Products> list = new ArrayList<Products>();
		try {
			Session session = factory.openSession();
			Transaction t = session.beginTransaction();
			String hql= "FROM Products "+addmore;
			Query query= session.createQuery(hql);
			list=(ArrayList<Products>) query.list();
		} catch (Exception e) {
			System.out.println("loi select san pham : "+e);
		}
		return list;
	}
	@Transactional
	public ArrayList<Accounts> SelectThanhVien(String addmore) {
		ArrayList<Accounts> list = new ArrayList<Accounts>();
		try {
			Session session = factory.openSession();
			Transaction t = session.beginTransaction();
			String hql= "FROM Accounts "+addmore;
			Query query= session.createQuery(hql);
			list=(ArrayList<Accounts>) query.list();
		} catch (Exception e) {
			System.out.println("loi select thanh vien : "+e);
		}
		return list;
	}
	
	public void makeuser(HttpServletRequest request,Accounts tv) {
		HttpSession session = request.getSession();
		try {
			session.setAttribute("user", tv);
		} catch (Exception e) {
			System.out.println("tao ss sai: "+e);
		}
	}
}
