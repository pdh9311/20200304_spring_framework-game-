package vegas.koreate.util;

public class RoomCri {
	
	private int roomPage;				// 현재 페이지
	private int roomPerPageNum ;		// 한번에 보여줄 방의 개수

	public RoomCri() {
		this(1,10);
	}
	
	public RoomCri(int roomPage, int roomPerPageNum) {
		this.roomPage = roomPage;
		this.roomPerPageNum = roomPerPageNum;
	}

	public int getRoomPageStart() {
		return (this.roomPage-1)*roomPerPageNum;
	}

	public int getRoomPage() {
		return roomPage;
	}

	public void setRoomPage(int roomPage) {
		this.roomPage = roomPage;
	}

	public int getRoomPerPageNum() {
		return roomPerPageNum;
	}

	public void setRoomPerPageNum(int roomPerPageNum) {
		this.roomPerPageNum = roomPerPageNum;
	}

	@Override
	public String toString() {
		return "RoomCri [roomPage=" + roomPage + ", roomPerPageNum=" + roomPerPageNum + "]";
	}

}
