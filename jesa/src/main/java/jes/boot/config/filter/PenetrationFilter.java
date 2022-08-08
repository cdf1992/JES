package jes.boot.config.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import jes.util.StringUtil;

/**
 * @作者 SUCH
 * @日期 2021年9月8日 下午6:24:11
 * @描述 渗透拦截器
 */
public class PenetrationFilter implements Filter {

	public void init(FilterConfig config) throws ServletException {
	}

	public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain chain) throws IOException, ServletException {
		HttpServletRequest request = (HttpServletRequest) servletRequest;
		HttpServletResponse response = (HttpServletResponse) servletResponse;

		// 安全响应头
		response.setHeader("X-Frame-Options", "SAMEORIGIN"); // 减少点击劫持 [DENY 不允许被任何页面嵌入 | SAMEORIGIN 不允许被本域以外的页面嵌入]
		response.setHeader("X-XSS-Protection", "1; mode=block"); // 减少点击劫持 [0 禁用 XSS 保护 | 1 启用 XSS 保护（1; mode=block）]
		// response.setHeader("X-Content-Type-Options", "nosniff"); // 关闭 MIME-sniffing 猜测资源类型

		// 处理跨域
		// 不使用 *，自动适配跨域域名，避免携带 Cookie 时失效
		String origin = request.getHeader("Origin");
		if (StringUtil.isNotBlank(origin)) {
			response.setHeader("Access-Control-Allow-Origin", origin);
		}
		// 自适应所有自定义头
		String headers = request.getHeader("Access-Control-Request-Headers");
		if (StringUtil.isNotBlank(origin)) {
			response.setHeader("Access-Control-Allow-Headers", headers);
			response.setHeader("Access-Control-Expose-Headers", headers);
		}
		// 允许跨域的请求方法类型
		response.setHeader("Access-Control-Allow-Methods", "*");
		// 预检命令（OPTIONS）缓存时间（秒）
		response.setHeader("Access-Control-Max-Age", "3600");
		// 明确许可客户端发送 Cookie，不允许删除字段即可
		response.setHeader("Access-Control-Allow-Credentials", "true");

		// 验证 HTTP referer 值，处理 CSRF 攻击 
		String referer = request.getHeader("referer");
		String checkReferer = new StringBuffer().append(request.getScheme()).append("://").append(request.getServerName()).toString();
		if (referer == null || "".equals(referer) || referer.startsWith(checkReferer)) {
			chain.doFilter(servletRequest, servletResponse);
		} else {
			response.sendRedirect("goLoginJsp.ajax?resultMessages=For illegal Referer sources, please log in the system through legitimate channels.");
		}
 	 }

	public void destroy() {
	}

}
