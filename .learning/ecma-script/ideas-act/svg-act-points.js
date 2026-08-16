///:	Produced by AI (deepseek-chat) support.

//..	<script type="text/javascript"><![CDATA[
(function() {
	'use strict';
	// const NS = 'http://www.w3.org/2000/svg';
	
	//: ---------- 纯函数：几何计算 ----------
	
	//: 解析 rotate 变换，返回 { angle/radians(弧度), cx, cy } 或 null
	const parseRotate = (transform) => 
	{
		if (!transform) return null;
		const m = transform.match(
			/rotate\((-?\d+(?:\.\d+)?)\s+(-?\d+(?:\.\d+)?)[,\s]+(-?\d+(?:\.\d+)?)\)/
		);
		if (!m) return null;
		
		const radians = +m[1] * Math.PI / 180;
		const cx = m[2] !== undefined ? +m[2] : 0;
		const cy = m[3] !== undefined ? +m[3] : 0;
		
		return { radians: radians, cx: cx, cy: cy };
	};
	
	//: 对点 {x,y} 应用旋转变换
	const transformPoint = (x, y, t) => 
	{
		const dx = x - t.cx;
		const dy = y - t.cy;
		const cos = Math.cos(t.radians);
		const sin = Math.sin(t.radians);
		
		const X = t.cx + dx * cos - dy * sin;
		const Y = t.cy + dx * sin + dy * cos;
		
		return { x: X, y: Y };
	};
	
	//: 从 SVG line 元素获取实际线段端点（考虑 transform）
	const getLineGeometry = (line) => 
	{
		const x1 = line.getAttribute('x1');
		const y1 = line.getAttribute('y1');
		const x2 = line.getAttribute('x2');
		const y2 = line.getAttribute('y2');
		if ([x1, y1, x2, y2].some(v => 
			v === null || 
			v === undefined || 
			Number.isNaN(+v)
		)) return null;
		
		const t = parseRotate(line.getAttribute('transform'));
		const pA = t ? transformPoint(+x1, +y1, t) : { x: +x1, y: +y1 };
		const pB = t ? transformPoint(+x2, +y2, t) : { x: +x2, y: +y2 };
		
		return { pA, pB };
	};
	
	//: 计算两条无限直线的交点，返回 {x,y} 或 null
	const intersectLines = (lineA, lineB) => 
	{
		const geomA = getLineGeometry(lineA);
		const geomB = getLineGeometry(lineB);
		if (!geomA || !geomB) return null;
		
		const { pA: p1, pB: p2 } = geomA;
		const { pA: p3, pB: p4 } = geomB;
		
		// const { pA: p1, pB: p2 } = getLineGeometry(lineA);
		// const { pA: p3, pB: p4 } = getLineGeometry(lineB);
		
		const X_1_2 = p1.x - p2.x;
		const Y_1_2 = p1.y - p2.y;
		const X_3_4 = p3.x - p4.x;
		const Y_3_4 = p3.y - p4.y;
		
		const den = (X_1_2 * Y_3_4) - (Y_1_2 * X_3_4);
		if (Math.abs(den) < 1e-9) return null;
		
		const XY_1_2 = (p1.x * p2.y) - (p1.y * p2.x);
		const XY_3_4 = (p3.x * p4.y) - (p3.y * p4.x);
		
		const px = ((XY_1_2 * X_3_4) - (X_1_2 * XY_3_4)) / den;
		const py = ((XY_1_2 * Y_3_4) - (Y_1_2 * XY_3_4)) / den;
		
		return { x: px, y: py };
	};
	
	//: ---------- 解析函数：从元素提取约束，返回要设置的属性 ----------
	
	//: 解析 data-intersection-of，返回 {cx, cy} 或 null
	const resolveIntersection = (el) => 
	{
		const tag = el.tagName.toLowerCase();
		if (tag !== 'circle' && tag !== 'ellipse') return null;
		
		const attr = el.getAttribute('data-intersection-of');
		if (!attr) return null;
		
		const ids = attr.trim().split(/\s+/);
		if (ids.length !== 2) return null;
		
		const lineA = document.getElementById(ids[0]);
		const lineB = document.getElementById(ids[1]);
		if (
			!lineA || !lineB ||
			lineA.tagName.toLowerCase() !== 'line' ||
			lineB.tagName.toLowerCase() !== 'line'
		) return null;
		
		const point = intersectLines(lineA, lineB);
		if (!point) return null;
		
		return { cx: point.x, cy: point.y };
	};
	
	//: 从点元素中提取坐标，优先使用 cx/cy（圆/椭圆），否则回退到 x/y
	const getPointXY = (el) => 
	{
		const x = +(el.getAttribute('cx') ?? el.getAttribute('x') ?? 0);
		const y = +(el.getAttribute('cy') ?? el.getAttribute('y') ?? 0);
		return { x, y };
	};
	
	//: 解析 data-endpoints="点id1 点id2"，返回 {x1,y1,x2,y2} 或 null
	const resolveEndpointLine = (line) => 
	{
		const attr = line.getAttribute('data-endpoints');
		if (!attr) return null;
		
		const ids = attr.trim().split(/\s+/);
		if (ids.length !== 2) return null;
		
		const p1 = document.getElementById(ids[0]);
		const p2 = document.getElementById(ids[1]);
		if (!p1 || !p2) return null;
		
		// const x1 = p1.getAttribute('cx') || p1.getAttribute('x') || 0;
		// const y1 = p1.getAttribute('cy') || p1.getAttribute('y') || 0;
		// const x2 = p2.getAttribute('cx') || p2.getAttribute('x') || 0;
		// const y2 = p2.getAttribute('cy') || p2.getAttribute('y') || 0;
		
		const { x: x1, y: y1 } = getPointXY(p1);
		const { x: x2, y: y2 } = getPointXY(p2);
		
		return { x1, y1, x2, y2 };
	};
	
	//: 解析 data-center="点id"，返回 {cx, cy} 或 null
	const resolveCircleCenter = (el) => 
	{
		const pointId = el.getAttribute('data-center');
		if (!pointId) return null;
		
		const point = document.getElementById(pointId);
		if (!point) return null;
		
		// const cx = point.getAttribute('cx') || point.getAttribute('x') || 0;
		// const cy = point.getAttribute('cy') || point.getAttribute('y') || 0;
		
		const { x: cx, y: cy } = getPointXY(point);
		
		return { cx, cy };
	};
	
	//: ---------- 主流程：收集操作并统一执行 ----------
	
	const applyConstraints = () => 
	{
		const pointResolvers = [
			//: 交点圆/椭圆 intersectionEls
			{ selector: '[data-intersection-of]', resolve: resolveIntersection },
			//: 圆心 centerEls
			{ selector: 'circle[data-center], ellipse[data-center]', resolve: resolveCircleCenter },
		];
		const lineResolvers = [
			//: 连接线 endpointLines
			{ selector: 'line[data-endpoints]', resolve: resolveEndpointLine },
		];
		
		
		const executeResolvers = (resolverList) => 
		{
			const operations = [].concat(...resolverList.map(
				({ selector, resolve }) =>
					//: 收集所有相关元素
					[...document.querySelectorAll(selector)]
						//: 对每个元素生成一个操作（如果解析成功）
						.map(el => ({ element: el, attributes: resolve(el) }))
						.filter(op => op.attributes)
			));
			//: 统一应用所有属性
			operations.forEach(
				({ element, attributes }) => Object.entries(attributes).forEach(
					([key, value]) => element.setAttribute(key, value)));
		};
		
		//: 先解析并写入点坐标
		executeResolvers(pointResolvers);
		//: 再解析并写入线端点
		executeResolvers(lineResolvers);
	};
	
	// window.addEventListener('DOMContentLoaded', applyConstraints);
	//: 如果脚本位于 SVG 末尾，也可以直接调用
	// applyConstraints();
	
	if (document.readyState === 'loading') {
		document.addEventListener('DOMContentLoaded', applyConstraints);
	} else {
		applyConstraints();
	}
})();
//..	]]></script>

//..	<g class="layer">
//..	 <title>动态交点示例</title>
//..	 <!-- 定义两个交点（圆点样式类似 svg_99） -->
//..	 <ellipse id="p1" data-intersection-of="svg_107 svg_27" rx="2" ry="2" fill="#000000"/>
//..	 <ellipse id="p2" data-intersection-of="svg_111 svg_26" rx="2" ry="2" fill="#000000"/>
//..	 <!-- 连接这两个交点的线 -->
//..	 <line data-endpoints="p1 p2" stroke="#000000" stroke-width="0.25"/>
//..	</g>
