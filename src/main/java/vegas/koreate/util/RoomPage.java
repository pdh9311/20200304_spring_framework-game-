package vegas.koreate.util;

public class RoomPage {

	private int roomMaxPage;			// 최대 페이지
	private boolean roomPrev;			// 이전 페이지
	private boolean roomNext;			// 다음 페이지
	private int roomTotalCount;			// 방의 총 개수
	private RoomCri roomCri;	
	
	public RoomPage() {
		this(0);
	}
	
	public RoomPage(int roomTotalCount) {
		this(roomTotalCount,new RoomCri());
	}

	public RoomPage(int roomTotalCount, RoomCri roomCri) {
		this.roomTotalCount = roomTotalCount;
		this.roomCri = roomCri;
	}	
	
	public void roomCalcPaging() {
		roomMaxPage = (roomTotalCount % roomCri.getRoomPerPageNum() == 0 ) ? roomTotalCount/roomCri.getRoomPerPageNum() : (roomTotalCount/roomCri.getRoomPerPageNum())+1;
		roomPrev = (roomCri.getRoomPage() <= 1) ? false : true;
		roomNext = (roomCri.getRoomPage() >= roomMaxPage) ? false :true;
	}

	public int getRoomMaxPage() {
		return roomMaxPage;
	}

	public void setRoomMaxPage(int roomMaxPage) {
		this.roomMaxPage = roomMaxPage;
	}

	public boolean isRoomPrev() {
		return roomPrev;
	}

	public void setRoomPrev(boolean roomPrev) {
		this.roomPrev = roomPrev;
	}

	public boolean isRoomNext() {
		return roomNext;
	}

	public void setRoomNext(boolean roomNext) {
		this.roomNext = roomNext;
	}

	public int getRoomTotalCount() {
		return roomTotalCount;
	}

	public void setRoomTotalCount(int roomTotalCount) {
		this.roomTotalCount = roomTotalCount;
		roomCalcPaging();
	}

	public RoomCri getRoomCri() {
		return roomCri;
	}

	public void setRoomCri(RoomCri roomCri) {
		this.roomCri = roomCri;
		roomCalcPaging();
	}

	@Override
	public String toString() {
		return "RoomPage [roomMaxPage=" + roomMaxPage + ", roomPrev=" + roomPrev + ", roomNext=" + roomNext
				+ ", roomTotalCount=" + roomTotalCount + ", roomCri=" + roomCri + "]";
	}
	
	
}
