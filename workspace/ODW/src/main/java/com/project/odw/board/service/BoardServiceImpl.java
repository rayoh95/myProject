package com.project.odw.board.service;

import java.io.File;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.project.odw.board.dao.BoardDao;
import com.project.odw.board.dto.BoardDto;

import net.coobird.thumbnailator.Thumbnails;

@Service
public class BoardServiceImpl implements BoardService {

	@Autowired
	private BoardDao boardDao;
	
	public static String BOARD_IMAGE_REPO;	
	static {
		BOARD_IMAGE_REPO = "/Users/oseunghwan/Desktop/Spring_project/workspace/ODW/src/main/webapp/WEB-INF/views/board/board_images/";
	}

	@Override
	public void insertBoard(BoardDto boardDto, HttpServletRequest request, MultipartHttpServletRequest mul) throws Exception {
		
		MultipartFile file = mul.getFile("file");
		
		if(!file.isEmpty()) {
			
			UUID fileUuId = UUID.randomUUID();
			
			String fileName = fileUuId + "_" + file.getOriginalFilename();
			
			boardDto.setImage(fileName);
			
			File saveFile = new File(BOARD_IMAGE_REPO + fileName);
			
			file.transferTo(saveFile);
		}
		
		HttpSession session = request.getSession();
		boardDto.setWriter((String)session.getAttribute("loginUser"));
		
		boardDao.insert(boardDto);
	}

	@Override
	public void getBoardList(Model model, int page) throws Exception {
		
		int allCount = boardDao.getCount();
		
		int pageLetter = 10;						// 한 페이지에 몇 개의 개시물을 설정할 것인가.
		int repeat = allCount / pageLetter;
		
		if (allCount % pageLetter != 0) repeat += 1;
		
		int end = page * pageLetter;
		int start = end - pageLetter + 1;
		
		HashMap<String, Integer> map = new HashMap<>();
		
        map.put("start", start);
        map.put("end", end);
		
		model.addAttribute("repeat", repeat);
		model.addAttribute("boardList", boardDao.selectAll(map));
	}

	@Override
	public void getImage(OutputStream out, String filePath) throws Exception {
		
		File image = new File(filePath);
		if (image.exists()) { 
			Thumbnails.of(image).size(256,300).outputFormat("jpg").toOutputStream(out);
		}
		byte[] buffer = new byte[1024 * 8];
		out.write(buffer);
		out.close();
	}

	@Override
	public BoardDto getOneBoard(int num) throws Exception {
		
		boardDao.updateReadCount(num);
		return boardDao.selectOne(num);
	}

	@Override
	public void updateBoard(BoardDto boardDto, MultipartHttpServletRequest mul) throws Exception {
		
		BoardDto dbBoardDto = boardDao.selectOne(boardDto.getNum());
		MultipartFile file = mul.getFile("file");
		
		if(!file.isEmpty() && boardDto.getImage() != dbBoardDto.getImage()) {
			
			File preFile = new File(BOARD_IMAGE_REPO + dbBoardDto.getImage());
			
			if (preFile.exists()) { preFile.delete(); }	// 파일 삭제.
			
			UUID fileUuId = UUID.randomUUID();
			
			String fileName = fileUuId + "_" + file.getOriginalFilename();
			
			boardDto.setImage(fileName);
			
			File saveFile = new File(BOARD_IMAGE_REPO + fileName);
			
			file.transferTo(saveFile);
		}
		
		boardDao.updateBoard(boardDto);
	}

	@Override
	public void deleteBoard(int num) throws Exception {
		boardDao.deleteBoard(num);
	}
}
