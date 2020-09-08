package Controller;

import java.util.ArrayList;
import java.util.Date;

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
import Entity.OrderDetails;
import Entity.Orders;
import Entity.Products;

@Controller
public class CartController {
	@RequestMapping(value = "cart")
	public String gotocart(ModelMap model, HttpServletRequest request) {
		loadcart(model, request);
		return "cart";
	}

	@RequestMapping(value = "cart", method = RequestMethod.POST)
	public String gotocart2(ModelMap model, HttpServletRequest request, @RequestParam String action) {
		try {
			if (action.equals("pay")) {
				String address = request.getParameter("address").toString();
				String email = request.getParameter("email").toString();
				String phone = request.getParameter("phone").toString();
				String name = request.getParameter("name").toString();

				String validate = validate(address, phone, email, name);
				if (validate == null) {
					HttpSession ss = request.getSession();
					if (ss.getAttribute("user") != null) {
						Accounts acc = (Accounts) ss.getAttribute("user");
						ArrayList<Carts> list = Select("from Carts where AccountId=" + acc.getId());
						if(list.size()>0) {
							Orders o = getOrder(request, address, phone, email, name,acc);
							if(o!=null) {
								int price=0;
								int quanti=0;
								for (Carts c : list) {
									ArrayList<Products> listP=SelectProducts("from Products where Id="+c.getProductId());
									if(listP.size()>0) {
										c.setPrice(listP.get(0).getPrice());
									}
									price+=c.getPrice()*c.getQuantity();
									quanti+=c.getQuantity();
									
									OrderDetails od= new OrderDetails();
									od.setOrderId(o.getId());
									ArrayList<Products> listp = SelectProducts("from Products where Id=" + c.getProductId());
									if(listp.size()>0) {
										od.setPrice(listp.get(0).getPrice()*c.getQuantity());
									}
									od.setProductId(c.getProductId());
									od.setQuantity(c.getQuantity());
									Save(od);
									Delete(c);
								}
								o.setPrice(price);
								o.setQuantity(quanti);
								Update(o);
							}
						}else {
							request.setAttribute("message", "Không đủ số hàng để thanh toán");
						}
					}else {
						return "login";
					}
				} else {
					request.setAttribute("message", validate);
				}

			} else {
				if (action.endsWith("update")) {
					int ind = action.indexOf("update");
					String sid = action.substring(0, ind);
					String squan = request.getParameter("quantity").toString();
					int quan = Integer.parseInt(squan);
					if (quan > 0) {
						update(action, quan, sid);
					} else {
						delete(model, request, action);
					}

				} else {
					delete(model, request, action);
				}
				
			}
			loadcart(model, request);
		} catch (Exception e) {
			System.out.println("loi gotocart2: " + e);
		}
		return "cart";
	}

	// method
	private Orders getOrder(HttpServletRequest request, String address, String phone, String email, String name,Accounts acc) {
		Orders re = null;
		try {
			Orders o = new Orders();
			o.setAddress(address);
			o.setCustomerId(acc.getId());
			Date date = new Date();
			java.sql.Date sqlDate = new java.sql.Date(date.getTime());
			o.setDate(sqlDate);
			o.setEmail(email);
			o.setName(name);
			o.setPhone(phone);
			Save(o);
			ArrayList<Orders> list2 = SelectOrders("from Orders");
			if (list2.size() > 0) {
				re = list2.get(list2.size() - 1);
			}
		} catch (Exception e) {
			System.out.println("loi tao hoa don cartmanager: " + e);
		}
		return re;
	}

	private String validate(String address, String phone, String email, String name) {
		String re = null;
		try {
			if (address.length() == 0) {
				re = "Địa chỉ rỗng";
			}
			if (!phone.matches("^\\d{10}$")) {
				if(re.length()>0) {
					re += ", số điện thoại sai";
				}else {
					re = "Số điện thoại sai";
				}
			}
			if (!email.contains("@")) {
				if(re.length()>0) {
					re += ", email sai";
				}else {
					re = "Email sai";
				}
			}
			if (name.length() == 0) {
				if(re.length()>0) {
					re += ", tên rỗng";
				}else {
					re = "Tên rỗng";
				}
			}
		} catch (Exception e) {
			System.out.println("loi validate: " + e);
		}
		return re;
	}

	private void update(String action, int iquan, String id) {
		try {
			ArrayList<Carts> list = Select("from Carts where Id=" + id);
			if (list.size() > 0) {
				Carts c = list.get(0);
				c.setQuantity(iquan);
				boolean b = Update(c);
				System.out.println("update : " + b);
			}
		} catch (Exception e) {
			System.out.println("loi xoa cart cartmanager: " + e);
		}
	}

	private void delete(ModelMap model, HttpServletRequest request, String action) {
		try {
			HttpSession ss = request.getSession();
			if (ss.getAttribute("user") != null) {
				Accounts acc = (Accounts) ss.getAttribute("user");
				ArrayList<Carts> list = Select("from Carts where AccountId=" + acc.getId());
				if (list.size() > 0) {
					for (Carts c : list) {
						String id = c.getId() + "";
						if (id.equals(action)) {
							boolean b = Delete(c);
							System.out.println(b);
						}
					}
				}
			}
		} catch (Exception e) {
			System.out.println("loi xoa cart cartmanager: " + e);
		}
	}

	private void loadcart(ModelMap model, HttpServletRequest request) {
		try {
			HttpSession ss = request.getSession();
			if (ss.getAttribute("user") != null) {
				Accounts acc = (Accounts) ss.getAttribute("user");
				ArrayList<Carts> list = Select("from Carts where AccountId=" + acc.getId());
				if (list.size() > 0) {
					int tt = 0;
					for (Carts c : list) {
						ArrayList<Products> listp = SelectProducts("from Products where Id=" + c.getProductId());
						if (listp.size() > 0) {
							Products p = listp.get(0);
							c.setPrice(p.getPrice());
							c.setName(p.getName());
							c.setImage(p.getImage());
							// c.setProduct(listp.get(0));
						}
						int tong = c.getPrice() * c.getQuantity();
						tt += tong;
					}
					request.setAttribute("list", list);
					request.setAttribute("total", tt);
				}
			}
		} catch (Exception e) {
			System.out.println("loi load cart cartmanager: " + e);
		}
	}

	// co so du lieu
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
	public ArrayList<Carts> Select(String hql) {
		ArrayList<Carts> list = new ArrayList<Carts>();
		try {
			Session session = factory.openSession();
			Transaction t = session.beginTransaction();
			Query query = session.createQuery(hql);
			list = (ArrayList<Carts>) query.list();
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
			System.out.println("loi select product cartmanager : " + e);
		}
		return list;
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
	public boolean Delete(Carts cart) {
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
}
