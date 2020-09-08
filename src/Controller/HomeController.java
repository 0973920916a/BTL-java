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
import org.springframework.web.bind.annotation.RequestParam;

import Entity.Accounts;
import Entity.Carts;
import Entity.Products;

@Controller
public class HomeController {
	//add to cart
	@RequestMapping(value = "home", method = RequestMethod.POST)
	public String gotohome(ModelMap model,HttpServletRequest request,@RequestParam String action) {
		try {
			System.out.println("want to add: "+action);
			boolean b=addtocart(request, action);
			if(!b) {
				return "login";
			}
			ArrayList<Products> list=SelectSanpham("");
			request.setAttribute("list", list);
		}catch (Exception e) {
			System.out.println("Lỗi gotohome: "+e);
		}
		return "home";
	}
	@RequestMapping(value = "home")
	public String gotohome(ModelMap model,HttpServletRequest request) {
		try {
			ArrayList<Products> list=SelectSanpham("");
			request.setAttribute("list", list);
		} catch (Exception e) {
			System.out.println("Lỗi gotohome get method: "+e);
		}
		return "home";
	}
	@RequestMapping(value = "login")
	public String gototest() {
		return "login";
	}
	@RequestMapping(value = "logout")
	public String gotologout(HttpServletRequest request) {
		HttpSession ss=request.getSession();
		if(ss.getAttribute("user")!=null) {
			ss.removeAttribute("user");
		}
		ArrayList<Products> list=SelectSanpham("");
		request.setAttribute("list", list);
		return "home";
	}
	private boolean addtocart(HttpServletRequest request,String id) {
		boolean re=false;
		try {
			HttpSession session = request.getSession();
			if(session.getAttribute("user")!=null) {
				Accounts acc=(Accounts) session.getAttribute("user");
				String hql="from Carts where AccountId="+acc.getId()+" and ProductId="+id;
				System.out.println(hql);
				ArrayList<Carts> list=Select(hql);
				if(list.size()>0) {
					Carts cart=list.get(0);
					int quan=cart.getQuantity();
					cart.setQuantity(quan+1);
					boolean b=Update(cart);
					System.out.println(b);
					re=true;
				}else {
					Carts cart= new Carts();
					cart.setAccountId(acc.getId());
					cart.setQuantity(1);
					int idi=Integer.parseInt(id);
					cart.setProductId(idi);
					boolean b=Save(cart);
					System.out.println(b);
					re=true;
				}
			}
		} catch (Exception e) {
			System.out.println("Lỗi addtocart: "+e);
		}
		return re;
	}
	//csdl
	@Autowired
	SessionFactory factory;
	
	@Transactional
	public ArrayList<Carts> Select(String hql) {
		ArrayList<Carts> list = new ArrayList<Carts>();
		try {
			Session session = factory.openSession();
			Transaction t = session.beginTransaction();
			Query query= session.createQuery(hql);
			list=(ArrayList<Carts>) query.list();
		} catch (Exception e) {
			System.out.println("loi select cart : "+e);
		}
		return list;
	}
	
	@Transactional
	public boolean Save(Carts cart) {
		boolean re=false;
		Session session = factory.openSession();
		Transaction t=session.beginTransaction();
		try {
			session.save(cart);
			t.commit();
			re=true;
		} catch (Exception e) {
			t.rollback();
			System.out.println("loi save cart : "+e);
		}
		finally {
			session.close();
		}
		return re;
	}
	@Transactional
	public boolean Update(Carts cart) {
		boolean re=false;
		Session session = factory.openSession();
		Transaction t=session.beginTransaction();
		try {
			session.update(cart);
			t.commit();
			re=true;
		} catch (Exception e) {
			t.rollback();
			System.out.println("loi update cart : "+e);
		}
		finally {
			session.close();
		}
		return re;
	}
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
}
