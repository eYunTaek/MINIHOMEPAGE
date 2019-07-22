package project03.vo;

public class Music {
	
	private int music_no,mem_no;
	private String music_title;
	private String music_genre;
	private int music_price;
	private String music_file;
	
	
	public int getMem_no() {
		return mem_no;
	}
	public void setMem_no(int mem_no) {
		this.mem_no = mem_no;
	}
	public Music() {
		super();
	}
	public Music(int music_no, String music_title, String music_genre, int music_price, String music_file) {
		super();
		this.music_no = music_no;
		this.music_title = music_title;
		this.music_genre = music_genre;
		this.music_price = music_price;
		this.music_file = music_file;
	}
	public Music(String music_file) {
		super();
		this.music_file = music_file;
	}
	
	public int getMusic_no() {
		return music_no;
	}
	public void setMusic_no(int music_no) {
		this.music_no = music_no;
	}
	public String getMusic_title() {
		return music_title;
	}
	public void setMusic_title(String music_title) {
		this.music_title = music_title;
	}
	public String getMusic_genre() {
		return music_genre;
	}
	public void setMusic_genre(String music_genre) {
		this.music_genre = music_genre;
	}
	public int getMusic_price() {
		return music_price;
	}
	public void setMusic_price(int music_price) {
		this.music_price = music_price;
	}
	public String getMusic_file() {
		return music_file;
	}
	public void setMusic_file(String music_file) {
		this.music_file = music_file;
	}
	
}
