package Entity;



import java.sql.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "Products")
public class Products {
		@Id
		@GeneratedValue
		int Id;
		String Name;
		String Image;
		int Price;
		Date CreateDate;
		
		public int getId() {
			return Id;
		}
		public void setId(int id) {
			Id = id;
		}
		
		public String getName() {
			return Name;
		}
		public void setName(String name) {
			Name = name;
		}
		public String getImage() {
			return Image;
		}
		public void setImage(String image) {
			Image = image;
		}
		public int getPrice() {
			return Price;
		}
		public void setPrice(int price) {
			Price = price;
		}
		public Date getCreateDate() {
			return CreateDate;
		}
		public void setCreateDate(Date createDate) {
			CreateDate = createDate;
		}
		
}
