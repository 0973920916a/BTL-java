package Controller;

import java.util.ArrayList;

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

import Entity.OrderDetails;
import Entity.Orders;
import Entity.Products;

@Controller
public class EmployeeController {
	@RequestMapping(value = "employee")
	public String employee(ModelMap model,HttpServletRequest request) {
		try {
			ArrayList<Orders> list =SelectOrders("from Orders");
			request.setAttribute("list", list);
		}catch (Exception e) {
			System.out.println("Lỗi employee: "+e);
		}
		return "employee";
	}
	@RequestMapping(value = "employee", method = RequestMethod.POST)
	public String employeepost(ModelMap model,HttpServletRequest request,@RequestParam String action) {
		try {
			ArrayList<OrderDetails> list = SelectOrderDetails("from OrderDetails where OrderId="+action);
			ArrayList<Products> listProduct=new ArrayList<>();
			int total=0;
			for (OrderDetails o : list) {
				total+=o.getPrice()*o.getQuantity();
				ArrayList<Products> abc=SelectProducts("from Products where Id="+o.getProductId());
				if(abc.size()>0) {
					listProduct.add(abc.get(0));
				}
			}
			ArrayList<Orders> list2=SelectOrders("from Orders where Id="+action);
			if(list2.size()>0) {
				request.setAttribute("order", list2.get(0));
			}
			request.setAttribute("list", list);
			request.setAttribute("listProduct", listProduct);
			request.setAttribute("total", total);
		}catch (Exception e) {
			System.out.println("Lỗi employee: "+e);
		}
		return "vieworder";
	}
	//csdl
	@Autowired
	SessionFactory factory;

	@Transactional
	public ArrayList<Orders> SelectOrders(String hql) {
		ArrayList<Orders> list = new ArrayList<Orders>();
		try {
			Session session = factory.openSession();
			Transaction t = session.beginTransaction();
			Query query = session.createQuery(hql);
			list = (ArrayList<Orders>) query.list();
		} catch (Exception e) {
			System.out.println("loi select cart cartmanager: " + e);
		}
		return list;
	}
	
	@Transactional
	public ArrayList<OrderDetails> SelectOrderDetails(String hql) {
		ArrayList<OrderDetails> list = new ArrayList<OrderDetails>();
		try {
			Session session = factory.openSession();
			Transaction t = session.beginTransaction();
			Query query = session.createQuery(hql);
			list = (ArrayList<OrderDetails>) query.list();
		} catch (Exception e) {
			System.out.println("loi select cart cartmanager: " + e);
		}
		return list;
	}
	
	
	@Transactional
	public ArrayList<Products> SelectProducts(String hql) {
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
