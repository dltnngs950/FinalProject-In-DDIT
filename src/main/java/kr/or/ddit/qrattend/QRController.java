package kr.or.ddit.qrattend;

import javax.annotation.Resource;
import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.groupware.contoller.OnoffController;
import kr.or.ddit.groupware.model.EmpVo;
import kr.or.ddit.groupware.service.EmpService;
import kr.or.ddit.groupware.service.OnOffService;
import kr.or.ddit.util.AriaUtil;

@RequestMapping("QR")
@Controller
public class QRController {
	 
	private static final Logger logger = LoggerFactory.getLogger(OnoffController.class);
	// 암호화 복호화를 위한 aria 유틸
	private AriaUtil aria;
	private String QRKey = "DDITQRMASTERKEY123"; // 암,복호화 MaterKey

	@Resource(name="onoffService")
	private OnOffService onoffService;
	
	@Resource(name="empService")
	private EmpService empService;
	
	//시큐리티 pw암호화
	@Inject
	BCryptPasswordEncoder pwdEncode;
	
	// QR 로그인 페이지 이동
	@RequestMapping("loginView")
	public String loginView() {
		
		return "QR/QRlogin";
	}
	
	// QR로그인 프로세스
	@RequestMapping("dologin")
	public String QRLogin(EmpVo empVo, HttpServletRequest req,HttpSession session, Model model, RedirectAttributes ra) {
		
		EmpVo dbUser = empService.selectUser(empVo.getEmp_id());
		if(dbUser == null) {
			return "redirect:/QR/loginView";
		}
		logger.debug("dbUserPass:{}", dbUser.getPass());
		
		//암호화 pw체크
		boolean pwdMatch = pwdEncode.matches(empVo.getPass(), dbUser.getPass());
		logger.debug("pwdMatch:{}", pwdMatch);

		if(dbUser != null && pwdMatch == true) {
			
			String originalEmpno = dbUser.getEmp_no()+"";
			// 파라미터인 사원번호를 양방향 암호화 하기 위한 master Key
			
			aria = new AriaUtil(QRKey);
			
			// 암호화
			String encryedEmpno = aria.Encrypt(originalEmpno);
			
			logger.debug("encryedEmpno : {}", encryedEmpno);
			
			// 암호화 된 사원번호 (emp_no) 를 세션 추가후 세션의 제한시간을 15초로 함.
			session.setAttribute("QR_empno", encryedEmpno);
			
			req.getServletContext().setAttribute("QR_USER", dbUser);
			
			session.setMaxInactiveInterval(15);
					
			return "redirect:/QR/QRdclz";
								
		}else {	
			return "redirect:/QR/loginView";
		}

	}
	
	// 출, 퇴근 처리를 위한 url for parameter
	@RequestMapping("QRdclz")
	public String QRdclz(Model model) {
		
		String url = "http:192.168.0.146/QR/QRattend";
		
		model.addAttribute("url", url);
		
		return "QR/QRDCLZ";
	}
	
	// QR 출석체크 프로세스
	@RequestMapping("QRattend")
	public String doattend(String emp_no, HttpServletRequest req,  Model model) {
		
		logger.debug("QRattend Do ============================= () \n");

		logger.debug("emp_no : {}", emp_no);

		EmpVo empinfo = (EmpVo)req.getServletContext().getAttribute("QR_USER");
		
		EmpVo empVo = empService.selectUser(empinfo.getEmp_id());
		// 복호화
		aria = new AriaUtil(QRKey); // 복호화를 위한 MasterKey
		String decryptedEmpno = aria.Decrypt(emp_no);
		
		logger.debug("decryptedEmpno : {}", decryptedEmpno);
		logger.debug("empVo.getEmp_no : {}", empVo.getEmp_no());
		
		boolean checkQrEmpno = true;
		
		// 복호화 한 사원번호와 empVo에 담겨있는 사원번호가 일치하다면 true
		if(decryptedEmpno.equals(empVo.getEmp_no()+"")) {
			checkQrEmpno = true;
		}else{
			checkQrEmpno = false;
		}
				
		logger.debug("checkQrEmpno : {}", checkQrEmpno);
		
		int checkAttend = onoffService.checkAttendCnt(empVo.getEmp_no());
		
		// true이고 출근을 하지 않았으면 출근완료, 출근을 했다면 퇴근시간 계속 업데이트
		if(checkQrEmpno == true) {
			
			logger.debug("checkAttend : {}", checkAttend);
			
			if(checkAttend == 0) {
				int insertCnt = onoffService.insertAttend(empVo.getEmp_no());
				logger.debug("insertCnt : {}", insertCnt);
				
				if(insertCnt == 1) {
					model.addAttribute("qrattendcheck", 1);
				}else {
					model.addAttribute("qrattendcheck", 0);
				}
				
				return "QR/QRattendCheck";
				
			}else {
				
				int updateCnt = onoffService.updateOffwork(empVo.getEmp_no());
				
				logger.debug("updateCnt", updateCnt);
				
				if(updateCnt == 1) {
					model.addAttribute("qroffworkcheck", 1);
				}else {
					model.addAttribute("qroffworkcheck", 0);
				}
				return "QR/QRoffworkCheck";
			}
		}else {
				if(checkAttend == 0) {
					
					model.addAttribute("checkempno", 0);
					
					return "QR/QRattendCheck";
					
				}else {
					
					model.addAttribute("checkempno", 0);
					
					return "QR/QRoffworkCheck";
			}	
		}	
	}
	
	// QR코드를 생성하는 ModelAndView
	@RequestMapping("CreateQRCode")
	public ModelAndView CreateQR(String content, Model model) {
		
		logger.debug("content : {}", content);
		
		return new ModelAndView("qrcodeview", "content", content);
	}
		
	
}
