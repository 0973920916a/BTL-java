package Controller;

import java.util.ArrayList;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;

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

import Entity.Carts;
import Entity.Products;
@Controller
public class ManagerController {
	@RequestMapping(value = "manager")
	public String get(ModelMap model, HttpServletRequest request) {
		ArrayList<Products> list =SelectProduct("from Products");
		request.setAttribute("list",list);
		return "manager";
	}
	@RequestMapping(value = "manager",method = RequestMethod.POST)
	public String post(ModelMap model, HttpServletRequest request) {	
		try {
			String name=request.getParameter("name").toString();
			
			String image=request.getParameter("image").toString();
			
			String price=request.getParameter("price").toString();
			
			String val= validate(name, image, price);
			if(val.length()==0) {
				int iprice=Integer.parseInt(price);
				Date date = new Date();
				java.sql.Date sqlDate = new java.sql.Date(date.getTime());
				Products p= new Products();
				p.setCreateDate(sqlDate);
				p.setName(name);
				p.setImage(image);
				p.setPrice(iprice);
				boolean b=Save(p);
				System.out.println("luu san pham: " + b);
			}else {
				request.setAttribute("message",val);
			}
			//
			ArrayList<Products> list =SelectProduct("from Products");
			request.setAttribute("list",list);
		} catch (Exception e) {
			System.out.println("loi post manager: " + e);
		}
		return "manager";
	}
	private String validate(String name,String  image,String  price) {
		String re="";
		try {
			if(name.length()==0) {
				re="Tên để rỗng";
			}
			if(image.length()==0) {
				if(re.length()>0) {
					re+=", link ảnh rỗng";
				}else {
					re="Link ảnh rỗng";
				}
			}
			if(price.length()==0) {
				if(re.length()>0) {
					re+=", chưa chọn giá";
				}else {
					re="Chưa chọn giá";
				}
			}
		} catch (Exception e) {
			// TODO: handle exception
		}
		return re;
	}
	
	@RequestMapping(value = "editproduct",method = RequestMethod.GET) 
	public String getedit(ModelMap model, HttpServletRequest request, @RequestParam String action) {
		try {
			if(!action.endsWith("delete")) {
				ArrayList<Products> list =SelectProduct("from Products where Id="+action);
				if(list.size()>0) {
					Products p= list.get(0);
					request.setAttribute("product", p);
				}
			}else {
				int ind = action.indexOf("delete");
				String id = action.substring(0, ind);
				ArrayList<Products> list =SelectProduct("from Products where Id="+id);
				if(list.size()>0) {
					Products p= list.get(0);
					Delete(p);
					ArrayList<Products> list2 =SelectProduct("from Products");
					request.setAttribute("list",list2);
					return "manager";
				}
			}
			
		} catch (Exception e) {
			// TODO: handle exception
		}
		return "editproduct";
	}
	@RequestMapping(value = "editproduct",method = RequestMethod.POST) 
	public String geteditpost(ModelMap model, HttpServletRequest request) {
		try {
			String id=request.getParameter("id").toString();
			ArrayList<Products> list =SelectProduct("from Products where Id="+id);
			if(list.size()>0) {
				Products product=list.get(0);
				String name=request.getParameter("name").toString();
				String price=request.getParameter("price").toString();
				String image=request.getParameter("image").toString();
				String val=validate(name, image, price);
				if(val.length()==0) {
					product.setName(name);
					int pr=Integer.parseInt(price);
					product.setPrice(pr);
					product.setImage(image);
					boolean b=Update(product);
					request.setAttribute("product", product);
				}else {
					request.setAttribute("message", val);
				}
			}
			
		} catch (Exception e) {
			System.out.println("loi editproduct post : " + e);
		}
		return "editproduct";
	}
	
	
	
	
	//csdl
	@Autowired
	SessionFactory factory;
	
	@Transactional
	public boolean Delete(Object cart) {
		boolean re = false;
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		try {
			session.delete(cart);
			t.commit();
			re = true;
		} catch (Exception e) {
			t.rollback();
			System.out.println("loi xoa cart cartmanager csdl : " + e);
		} finally {
			session.close();
		}
		return re;
	}
	@Transactional
	public boolean Update(Object cart) {
		boolean re = false;
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		try {
			session.update(cart);
			t.commit();
			re = true;
		} catch (Exception e) {
			t.rollback();
			System.out.println("loi update cart cartmanager csdl : " + e);
		} finally {
			session.close();
		}
		return re;
	}
	@Transactional
	public boolean Save(Object Orders) {
		boolean re = false;
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		try {
			session.save(Orders);
			t.commit();
			re = true;
		} catch (Exception e) {
			t.rollback();
			System.out.println("loi save Orders cartmanager csdl : " + e);
		} finally {
			session.close();
		}
		return re;
	}
	@Transactional
	public ArrayList<Products> SelectProduct(String hql) {
		ArrayList<Products> list = new ArrayList<Products>();
		try {
			Session session = factory.openSession();
			Transaction t = session.beginTransaction();
			Query query = session.createQuery(hql);
			list = (ArrayList<Products>) query.list();
		} catch (Exception e) {
			System.out.println("loi select cart cartmanager: " + e);
		}
		return list;
	}
}

