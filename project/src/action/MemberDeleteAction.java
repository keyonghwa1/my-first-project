package action;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.MemberDAO;

/**
 * Servlet implementation class MemberDeleteAction
 */
@WebServlet("/movie/member_del.korea")
public class MemberDeleteAction extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		String strIdx = request.getParameter("idx");
		//
		int idx = Integer.parseInt(strIdx);
		
		//DAO에서 해당 idx의 행을 지우는 작업을 완료한 뒤, 결과 값을 받는다.
		int res = MemberDAO.getInstance().delete(idx);
		//1이면 성공, 0이면 실패
		
		//json 반환
		String result = String.format("[{'res':'%d'},{'idx':'%d'}]",res,idx);
		response.getWriter().println(result);
	}

}
