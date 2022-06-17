package kr.MS.vo;

import java.util.List;

public class PagingVO<T> {
	private List<T> list;
	
	private int totalCount;
	private int currentPage;
	private int pageSize;
	private int blockSize;
	
	private int totalPage;
	private int startNo;
	private int endNo;
	private int startPage;
	private int endPage;
	
	public PagingVO(int totalCount, int currentPage, int pageSize, int blockSize) {
		this.totalCount = totalCount;
		this.currentPage = currentPage;
		this.pageSize = pageSize;//한 페이지에 적을 수 있는 게시글 수
		this.blockSize = blockSize;//한 블록당 페이지 수
		calc();
	}

	private void calc() {
		if(totalCount < 0) totalCount = 0;//총 게시글수가 0보다 작아지면 0으로
		if(currentPage <= 0) currentPage = 1;//현재 페이지가 0보다 작아지면 1로
		if(pageSize <= 1 ) pageSize = 10;// 
		if(blockSize <= 1) blockSize = 10;
		
		if(totalCount > 0) {//총 게시글 수가 0보다 클떄
			totalPage = (totalCount - 1)/pageSize + 1;//총 페이지수 = (총 게시글 수 -1) / 
			startNo = (currentPage - 1) * pageSize + 1;//시작 번호 = (현재페이지-1) * 한 페이지 게시글 수 + 1
			endNo = startNo + pageSize - 1;//끝 번호 = 시작번호 + 페이지에 적을 수 있는 게시글의 수 - 1
			if(endNo > totalCount) endNo = totalCount;//끝번호가 총 게시글 수보다 크면? -> 끝번호에 총 게시글 수를 넣는다
			startPage = (currentPage - 1)/blockSize * blockSize + 1;//시작 페이지 번호 = (현재페이지 -1)/한 블록당 페이지 수 * 한 블록당 페이지 수 +1
			endPage = startPage + blockSize - 1;//마지막 페이지 번호 = 시작 페이지 번호 + 한 블록당 페이지 수 - 1
			if(endPage > totalPage) endPage = totalPage;//마지막 페이지 번호가 총 페이지 수보다 크면? -> 마지막 페이지 번호에 총 페이지수를 넣는다
		}
	}

	public List<T> getList() {
		return list;
	}

	public void setList(List<T> list) {
		this.list = list;
	}

	public int getTotalCount() {
		return totalCount;
	}

	public int getCurrentPage() {
		return currentPage;
	}

	public int getPageSize() {
		return pageSize;
	}

	public int getBlockSize() {
		return blockSize;
	}

	public int getTotalPage() {
		return totalPage;
	}

	public int getStartNo() {
		return startNo;
	}

	public int getEndNo() {
		return endNo;
	}

	public int getStartPage() {
		return startPage;
	}

	public int getEndPage() {
		return endPage;
	}
	
	public String getPageInfo() {
		String info = "전체: " + totalCount + "개";
		if(totalCount > 0) {
			info += "(" + currentPage + "/" + totalPage + "Page)";
		}
		return info;
	}
	
	public String getPageList() {
		String pageList = "";
		
		//시작 페이지가 1보다 크면 이전이 있다
		if(startPage > 1) {
			//이전 페이지로 이동하는 링크 작성
			pageList = "[<a href='?p=" + (startPage - 1) + "&s=" + pageSize + "&b=" + blockSize + "'>이전</a>]";
		}
		
		//페이지 번호를 찍자
		for(int i = startPage; i <= endPage; i++) {//해당 블록의 시작페이지 번호에서 마지막 페이지 번호까지
			if(i == currentPage) {//현재페이지에는 링크를 걸지 않는다
				pageList += "[" + i + "]";
			}else {
				//해당 블록의 페이지로 이동하는 링크
				pageList += "[<a href='?p=" + i + "&s=" + pageSize + "&b=" + blockSize + "'>" + i + "</a>]";
			}
		}
		
		//마지막 페이지가 전체 페이지 보다 적다면 다음이 있다
		if(endPage < totalPage) {
			pageList += "[<a href='?p=" + (endPage + 1) + "&s=" + pageSize + "&b=" + blockSize + "'>다음</a>]";
		}
		return pageList;
	}

	@Override
	public String toString() {
		return "PagingVO [list=" + list + ", totalCount=" + totalCount + ", currentPage=" + currentPage + ", pageSize="
	+ pageSize + ", blockSize=" + blockSize + ", totalPage=" + totalPage + ", startNo=" + startNo 
	+ ", endNo=" + endNo + ", startPage=" + startPage + ", endPage=" +endPage + "]";
	}
}