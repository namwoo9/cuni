
package com.sbs.cuni.controller;

import java.util.Map;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sbs.cuni.dto.Member;
import com.sbs.cuni.service.MemberService;

@Controller
public class MemberController {

	@Autowired
	private MemberService memberService;

	@RequestMapping("member/login")
	public String showLogin() {
		return "member/login";
	}

	@RequestMapping("member/findInfo")
	public String findInfo() {
		return "member/findInfo";
	}

	@RequestMapping("member/doLogin")
	public String doLogin(@RequestParam Map<String, Object> param, HttpSession session, Model model) {
		Map<String, Object> rs = memberService.login(param);

		String resultCode = (String) rs.get("resultCode");
		String msg = (String) rs.get("msg");

		model.addAttribute("alertMsg", msg);

		String redirectUrl = (String) param.get("redirectUrl");

		if (redirectUrl == null || redirectUrl.length() == 0) {
			redirectUrl = "/";
		}

		if (resultCode.startsWith("S-")) {
			model.addAttribute("redirectUrl", redirectUrl);
			session.setAttribute("loginedMemberId", rs.get("loginedMemberId"));
		} else {
			model.addAttribute("historyBack", true);
		}

		return "common/redirect";
	}

	@RequestMapping("member/join")
	public String showJoin() {
		return "member/join";
	}

	@RequestMapping(value = "/user/idCheck", method = RequestMethod.GET)
	@ResponseBody
	public int idCheck(@RequestParam("loginId") String loginId) {

		return memberService.userIdCheck(loginId);
	}
	
	@RequestMapping(value = "/user/nameCheck", method = RequestMethod.GET)
	@ResponseBody
	public int nameCheck(@RequestParam("name") String name) {

		return memberService.userNameCheck(name);
	}
	
	@RequestMapping("member/doJoin")
	public String doJoin(Model model, @RequestParam Map<String, Object> param, HttpSession session) {

		Map<String, Object> rs = memberService.doubleCheck(param);

		String resultCode = (String) rs.get("resultCode");

		String redirectUrl = (String) param.get("redirectUrl");

		if (redirectUrl == null || redirectUrl.length() == 0) {
			redirectUrl = "/member/login";
		}

		String msg = (String) rs.get("msg");

		model.addAttribute("alertMsg", msg);

		if (resultCode.startsWith("S-")) {
			model.addAttribute("redirectUrl", redirectUrl);
		} else {
			model.addAttribute("historyBack", true);
		}

		return "common/redirect";

	}

	@RequestMapping("member/doLogout")
	public String doLogout(HttpSession session, Model model) {
		session.removeAttribute("loginedMemberId");
		model.addAttribute("alertMsg", "안녕히가세요!");
		model.addAttribute("redirectUrl", "/member/login");
		return "common/redirect";
	}

	@RequestMapping("member/myPage")
	public String myPage(Model model, HttpSession session) {
		long loginedMemberId = (long) session.getAttribute("loginedMemberId");
		Member member = memberService.getOne(loginedMemberId);
		model.addAttribute("member", member);
		return "member/myPage";
	}

	@RequestMapping("member/modify")
	public String modify() {
		return "member/modify";
	}

	@RequestMapping("/member/doModify")
	@ResponseBody
	public String doModify(Model model, @RequestParam Map<String, Object> param, HttpSession session,
			HttpServletRequest request) {
		long loginedMemberId = (long) session.getAttribute("loginedMemberId");

		param.put("id", loginedMemberId);

		String name = request.getParameter("name");

//		String name = request.getParameter("name");
//
//		if (name == null) {
//			response.getWriter().append("<script> alert('title을 입력해주세요.'); history.back(); </script>");
//			return name;
//		}
//
		name = name.trim();
//  
//		if (name.length() == 0 && name.matches("[0-9|a-z|A-Z|가-힣|]*")) {
//			response.getWriter().append("<script> alert('title을 입력해주세요.'); history.back(); </script>");
//			return name;
//		}
		StringBuilder sb2 = new StringBuilder();
		if (name.length() == 0) {
			sb2.append("<script>");
			sb2.append("alert('닉네임을 입력해주세요');");
			sb2.append("history.back();");
			sb2.append("</script>");
			return sb2.toString();
		}
		if (!Pattern.matches("^[0-9|a-z|A-Z|가-힣|]*$", name)) {
			sb2.append("<script>");
			sb2.append("alert('특수문자와 자음은 사용할 수 없습니다.');");
			sb2.append("history.back();");
			sb2.append("</script>");
			return sb2.toString();
		}

		if (name.length() <= 1) {
			sb2.append("<script>");
			sb2.append("alert('닉네임은 2자리 이상 입력해주세요');");
			sb2.append("history.back();");
			sb2.append("</script>");
			return sb2.toString();
		}

//		if (boardId == 2) {
//
//		} else {
//			sb2.append("<script>");
//			sb2.append("alert('권한이 없습니다.");
//			sb2.append("history.back();");
//			sb2.append("</script>");
//			return sb2.toString();
//		}

		Map<String, Object> updateRs = memberService.update(param);

		StringBuilder sb = new StringBuilder();
		sb.append("<script>");

		String msg = (String) updateRs.get("msg");

		sb.append("alert('" + msg + "');");

		if (((String) updateRs.get("resultCode")).startsWith("S-")) {
			sb.append("location.replace('./myPage');");
		} else {
			sb.append("history.back();");
		}

		sb.append("</script>");

		return sb.toString();
	}

	private void append(String string) {
		// TODO Auto-generated method stub

	}

	@RequestMapping("member/confirm")
	public String confirm(@RequestParam Map<String, Object> param, Model model) {
		Map<String, Object> rs = memberService.updateAuthStatus(param);
		String msg = (String) rs.get("msg");
		String resultCode = (String) rs.get("resultCode");

		model.addAttribute("alertMsg", msg);

		String redirectUrl = "/member/login";
		model.addAttribute("redirectUrl", redirectUrl);

		return "common/redirect";
	}

	@RequestMapping("member/doSecession")
	public String secession(@RequestParam Map<String, Object> param, Model model, HttpSession session) {
		long loginedMemberId = (long) session.getAttribute("loginedMemberId");
		param.put("id", loginedMemberId);
		Map<String, Object> rs = memberService.updateDelStatus(param);
//		session.removeAttribute("loginedMemberId");

		String msg = (String) rs.get("msg");
		String resultCode = (String) rs.get("resultCode");

		model.addAttribute("alertMsg", msg);

		String redirectUrl = "/member/login";
		model.addAttribute("redirectUrl", redirectUrl);

		return "common/redirect";
	}

	@RequestMapping("member/doSearchId")
	public String doSearchId(@RequestParam Map<String, Object> param, HttpSession session, Model model) {
		Map<String, Object> rs = memberService.searchId(param);

		String resultCode = (String) rs.get("resultCode");

		String msg = (String) rs.get("msg");

		model.addAttribute("alertMsg", msg);

		String redirectUrl = (String) param.get("redirectUrl");

		if (redirectUrl == null || redirectUrl.length() == 0) {
			redirectUrl = "/member/login";
		}

		if (resultCode.startsWith("S-")) {
			model.addAttribute("redirectUrl", redirectUrl);
			session.setAttribute("loginedMemberId", rs.get("loginedMemberId"));
		} else {
			model.addAttribute("historyBack", true);
		}

		return "common/redirect";
	}

	@RequestMapping("member/doSearchPw")
	public String doSearchPw(@RequestParam Map<String, Object> param, HttpSession session, Model model) {
		Map<String, Object> rs = memberService.searchPw(param);

		String resultCode = (String) rs.get("resultCode");

		String msg = (String) rs.get("msg");

		model.addAttribute("alertMsg", msg);

		String redirectUrl = (String) param.get("redirectUrl");

		if (redirectUrl == null || redirectUrl.length() == 0) {
			redirectUrl = "/member/login";
		}

		if (resultCode.startsWith("S-")) {
			model.addAttribute("redirectUrl", redirectUrl);
			session.setAttribute("loginedMemberId", rs.get("loginedMemberId"));
		} else {
			model.addAttribute("historyBack", true);
		}

		return "common/redirect";
	}
}
