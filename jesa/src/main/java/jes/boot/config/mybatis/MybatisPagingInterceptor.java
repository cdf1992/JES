package jes.boot.config.mybatis;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Map;
import java.util.Properties;
import org.apache.ibatis.executor.Executor;
import org.apache.ibatis.executor.parameter.ParameterHandler;
import org.apache.ibatis.executor.resultset.ResultSetHandler;
import org.apache.ibatis.executor.statement.StatementHandler;
import org.apache.ibatis.mapping.BoundSql;
import org.apache.ibatis.mapping.MappedStatement;
import org.apache.ibatis.plugin.Interceptor;
import org.apache.ibatis.plugin.Intercepts;
import org.apache.ibatis.plugin.Invocation;
import org.apache.ibatis.plugin.Plugin;
import org.apache.ibatis.plugin.Signature;
import org.apache.ibatis.reflection.MetaObject;
import org.apache.ibatis.reflection.SystemMetaObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import jes.mybatis.ext.pagehelper.PageInfo;

/**
 * @author SUCH
 * <pre>
 * MyBatis 分页拦截器
 * 适用 MyBatis 版本 3.4.6+
 * 
 * 拦截器属性列表
 *   statementSuffix statementId 匹配后缀，以指定后缀结尾的 statementId 才会拦截 [默认值为 ByPage]
 *   pageIndex 当前页 [默认值为 1] [下标为 1]
 *   pageIndexKey 当前页在参数列表中的 key [默认值为 pageIndex]
 *   pageLimit 当前页数据量 [默认值为 20]
 *   pageLimitKey 当前页数据量在参数列表中的 key [默认值为 pageLimit]
 * 
 * Intercepts 标注为拦截器
 * Signature 拦截器签名
 * type：拦截对象类型 [{@link Executor} | {@link ResultSetHandler} | {@link ParameterHandler} | {@link StatementHandler}]
 * method：指定对象类型中需要拦截的方法
 * args：指定拦截方法的入参列表
 * </pre>
 */
@Intercepts({@Signature(type = StatementHandler.class, method = "prepare", args = { Connection.class, Integer.class }) })
public class MybatisPagingInterceptor implements Interceptor {

	private static final Logger log = LoggerFactory.getLogger(MybatisPagingInterceptor.class);

	private String statementSuffix;
	private int start;
	private String startKey;
	private int limit;
	private String limitKey;

	@Override
	public Object intercept(Invocation invocation) throws Throwable {
		// 获取 RoutingStatementHandler 并转换为接口 StatementHandler（在注解中拦截器指定了拦截的类型为
		// StatementHandler）
		StatementHandler statementHandler = (StatementHandler) invocation.getTarget();
		// 获取 StatementHandler 元信息
		MetaObject metaObject = SystemMetaObject.forObject(statementHandler);
		// 分离代理对象链
		while (metaObject.hasGetter("h")) {
			Object obj = metaObject.getValue("h");
			metaObject = SystemMetaObject.forObject(obj);
		}
		while (metaObject.hasGetter("target")) {
			Object obj = metaObject.getValue("target");
			metaObject = SystemMetaObject.forObject(obj);
		}
		// 获取查询接口映射的相关信息
		MappedStatement mappedStatement = (MappedStatement) metaObject.getValue("delegate.mappedStatement");
		String statementId = mappedStatement.getId();
		// 拦截以 statementSuffix 结尾的请求
		if (statementId.endsWith(this.statementSuffix)) {
			Object[] args = invocation.getArgs();
			// 获取请求参数
			ParameterHandler parameterHandler = (ParameterHandler) metaObject.getValue("delegate.parameterHandler");
			Map<String, Object> params = (Map<String, Object>) parameterHandler.getParameterObject();
			// 获取 sql
			BoundSql boundSql = (BoundSql) metaObject.getValue("delegate.boundSql");
			// 分页参数作为参数对象parameterObject的一个属性  
			String sql = boundSql.getSql();
			int start = this.start;
			int limit = this.limit;
			Object startObj = params.get(this.startKey);
			Object limitObj = params.get(this.limitKey);
			if (startObj != null) {
				start = Integer.valueOf(startObj.toString());
			}
			if (limitObj != null) {
				limit = Integer.valueOf(limitObj.toString());
			}
			String pageSql = concatPageSql(sql, start, limit);
			metaObject.setValue("delegate.boundSql.sql", pageSql);

			PageInfo pageInfo = (PageInfo) params.get("pageInfo");
			if (pageInfo != null) {
				String countSql = concatCountSql(sql);
				Connection connection = (Connection) invocation.getArgs()[0];
				PreparedStatement ps = null;
				ResultSet rs = null;
				int totalCount = 0;
				try {
					ps = connection.prepareStatement(countSql);
					rs = ps.executeQuery();
					if (rs.next()) {
						totalCount = rs.getInt(1);
					}
				} catch (SQLException e) {
					log.warn("Ignore this exception", e);
				} finally {
					try {
						rs.close();
						ps.close();
					} catch (SQLException e) {
						log.warn("Ignore this exception", e);
					}
				}
				pageInfo.setTotal(totalCount);
			}
		}
		// 进入责任链的下一级
		return invocation.proceed();
	}

	@Override
	public Object plugin(Object target) {
		return Plugin.wrap(target, this);
	}

	@Override
	public void setProperties(Properties properties) {
		this.statementSuffix = properties.getProperty("statementSuffix", "ForPage");
		this.start = Integer.valueOf(properties.getProperty("start", "0"));
		this.startKey = properties.getProperty("startKey", "start");
		this.limit = Integer.valueOf(properties.getProperty("limit", "20"));
		this.limitKey = properties.getProperty("limitKey", "limit");
	}

	public String concatCountSql(String sql) {
		sql = sql.toLowerCase();

		StringBuffer countSql = new StringBuffer("select count(*) from ");
		if (sql.lastIndexOf("order") > sql.lastIndexOf(")")) {
			countSql.append(sql.substring(sql.indexOf("from") + 4, sql.lastIndexOf("order")));
		} else {
			countSql.append(sql.substring(sql.indexOf("from") + 4));
		}
		return countSql.toString();
	}

	public String concatPageSql(String sql,int start,int limit) {
		StringBuffer pageSql = new StringBuffer();
		pageSql.append(sql).append(" limit ").append(start).append(", ").append(limit);
		return pageSql.toString();
	}

}
