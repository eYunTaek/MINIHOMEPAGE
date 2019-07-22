package project03.vo;

public class Item {
	private int mem_no,item_no,x,y;
	private String mitem_type,filename,item_file;
	private String item_name;
	private String item_type;
	private int item_price;
	
	public String getFilename() {
		return filename;
	}
	public void setFilename(String filename) {
		this.filename = filename;
	}
	
	
	
	public String getItem_name() {
		return item_name;
	}
	public void setItem_name(String item_name) {
		this.item_name = item_name;
	}
	public String getItem_type() {
		return item_type;
	}
	public void setItem_type(String item_type) {
		this.item_type = item_type;
	}
	public int getItem_price() {
		return item_price;
	}
	public void setItem_price(int item_price) {
		this.item_price = item_price;
	}
	public Item() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Item(int item_no, String item_name, String item_type, int item_price) {
		super();
		this.item_no = item_no;
		this.item_name = item_name;
		this.item_type = item_type;
		this.item_price = item_price;
	}
	public Item(String mitem_type,int mem_no) {
		super();
		this.mem_no = mem_no;
		this.mitem_type = mitem_type;
	}
	public Item(int item_no, String filename) {
		super();
		this.item_no = item_no;
		this.filename = filename;
	}
	public Item(int mem_no, int item_no, String mitem_type) {
		super();
		this.mem_no = mem_no;
		this.item_no = item_no;
		this.mitem_type = mitem_type;
	}
	public Item(int mem_no, int item_no, int x, int y) {
		super();
		this.mem_no = mem_no;
		this.item_no = item_no;
		this.x = x;
		this.y = y;
	}
	//item_no,x,y,item_file
	
	public Item(int item_no, String item_file, int x, int y) {
		this.item_no = item_no;
		this.item_file = item_file;
		this.x = x;
		this.y = y;
	}
	
	public Item(String item_file, String item_name) {
		super();
		this.item_file = item_file;
		this.item_name = item_name;
	}
	public String getItem_file() {
		return item_file;
	}
	public void setItem_file(String item_file) {
		this.item_file = item_file;
	}
	public int getMem_no() {
		return mem_no;
	}
	public void setMem_no(int mem_no) {
		this.mem_no = mem_no;
	}
	public int getItem_no() {
		return item_no;
	}
	public void setItem_no(int item_no) {
		this.item_no = item_no;
	}
	public String getMitem_type() {
		return mitem_type;
	}
	public void setMitem_type(String mitem_type) {
		this.mitem_type = mitem_type;
	}
	public int getX() {
		return x;
	}
	public void setX(int x) {
		this.x = x;
	}
	public int getY() {
		return y;
	}
	public void setY(int y) {
		this.y = y;
	}

}
