package com.zerock.mapper;

import java.util.List;
import java.util.stream.IntStream;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.zerock.domain.Criteria;
import com.zerock.domain.ReplyVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = {com.zerock.config.RootConfig.class})
@Log4j
public class ReplyMapperTests {
	
	private Long[] bnoArr = {1L, 2L, 3L, 4L, 5L};
	
	@Setter(onMethod_= @Autowired)
	private ReplyMapper mapper;
	
	@Test
	public void testMapper() {
		log.info(mapper);
	}
	
	@Test
	public void testCreate() {
		IntStream.rangeClosed(1, 10).forEach(i -> {
			ReplyVO vo = new ReplyVO();
			log.info("i : " + i);
			
			vo.setBno(bnoArr[i%5]);
			vo.setReply("댓글 테스트" + i);
			vo.setReplyer("replyer" + i);
			
			mapper.insert(vo);
		});
	}
	
	@Test
	public void testRead() {
		Long targetBno = 5L;
		ReplyVO vo = mapper.read(targetBno);
		log.info(vo);
	}
	
	@Test
	public void testDelete() {
		Long targetBno = 1L;
		mapper.delete(targetBno);
	}
	
	@Test
	public void testUpdate() {
		Long targetBno = 10L;
		ReplyVO vo = mapper.read(targetBno);
		vo.setReply("Update Reply");
		int count = mapper.update(vo);
		log.info("Update Count : " + count);
	}
	
	@Test
	public void testList() {
		Criteria cri = new Criteria();
//		List<ReplyVO> replies = mapper.getListWithPaging(cri, bnoArr[0]);
		List<ReplyVO> replies = mapper.getListWithPaging(cri, 1L);
		replies.forEach(reply -> log.info(reply));
	}
	
}
