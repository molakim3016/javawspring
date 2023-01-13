package com.spring.javawspring.service;

import java.util.ArrayList;
import java.util.List;

import com.spring.javawspring.vo.BoardReplyVO;
import com.spring.javawspring.vo.BoardVO;
import com.spring.javawspring.vo.GoodVO;

public interface BoardService {

	public List<BoardVO> getBoardList(int startIndexNo, int pageSize, String part, String searchString);

	public int setBoardInput(BoardVO vo);

	public BoardVO getBoardContent(int idx);

	public void setBoardReadNum(int idx);

	public void setBoardGood(int idx, int inde);

	public GoodVO getBoardGoodCheck(int partIdx, String part, String mid);

	public ArrayList<BoardVO> getPrevNext(int idx);

	public void setBoardDBGood(String part, int partIdx, String mid);

	public void setBoardDBGoodDelete(int idx);

	public void imgCheck(String content);

	public void setBoardDeleteOk(int idx);

	public void imgDelete(String content);

	public void imgCheckUpdate(String content);

	public void setBoardUpdateOk(BoardVO vo);

	public void setBoardReplyInput(BoardReplyVO replyVo);

	public List<BoardReplyVO> getBoardReply(int idx);

	public void setBoardReplyDeleteOk(int idx);

	public String getMaxLevelOrder(int boardIdx);

	public void setLevelOrderPlusUpdate(BoardReplyVO replyVo);

	public void setBoardReplyInput2(BoardReplyVO replyVo);

	public void setBoardReplyUpdate(int idx, String content);

}
