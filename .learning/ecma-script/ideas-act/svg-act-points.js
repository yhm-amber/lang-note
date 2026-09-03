///:	Produced with AI (deepseek-chat) support.

//..	<script type="text/javascript"><![CDATA[
//// Produced with AI (deepseek-chat) support.
(function() {
	'use strict';
	// const NS = 'http://www.w3.org/2000/svg';
	
	//: ---------- 纯函数 - 几何计算 ----------
	
	//: 解析 rotate 变换 ; 返回 { angle/radians(弧度), cx, cy } 或 null
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
	
	//: 从 SVG line 元素获取实际线段端点 ; 考虑 transform
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
	
	//: 计算两条无限直线的交点 ; 返回 {x,y} 或 null
	const intersectLines = (lineA, lineB) => 
	{
		const geomA = getLineGeometry(lineA);
		const geomB = getLineGeometry(lineB);
		if (!geomA || !geomB) return null;
		
		const { pA: p1, pB: p2 } = geomA;
		const { pA: p3, pB: p4 } = geomB;
		
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
	
	//: ---------- 解析函数 - 从元素提取约束，返回要设置的属性 ----------
	
	//: 解析 data-intersection-of ; 返回 {cx, cy} 或 null
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
	
	//: 从点元素中提取坐标 ; 优先使用 cx/cy (圆|椭圆) ; 否则回退到 x/y
	const getPointXY = (el) => 
	{
		const x = +(el.getAttribute('cx') ?? el.getAttribute('x') ?? 0);
		const y = +(el.getAttribute('cy') ?? el.getAttribute('y') ?? 0);
		return { x, y };
	};
	
	//: 从点元素中提取原始坐标字符串 ; 用于 path 的 d 构建
	const getPointRawXY = (el) => {
		const { x: x, y: y } = getPointXY(el);
		return `${x},${y}`;
	};
	
	//: 解析 data-endpoints="point-id-1 point-id-2" ; 返回 {x1,y1,x2,y2} 或 null
	const resolveEndpointLine = (line) => 
	{
		const attr = line.getAttribute('data-endpoints');
		if (!attr) return null;
		
		const ids = attr.trim().split(/\s+/);
		if (ids.length !== 2) return null;
		
		const p1 = document.getElementById(ids[0]);
		const p2 = document.getElementById(ids[1]);
		if (!p1 || !p2) return null;
		
		const { x: x1, y: y1 } = getPointXY(p1);
		const { x: x2, y: y2 } = getPointXY(p2);
		return { x1, y1, x2, y2 };
	};
	
	//: 解析 data-center="point-id" ; 返回 {cx, cy} 或 null
	const resolveCircleCenter = (el) => 
	{
		//: 如果同时有 data-radius-point ，交给 resolveCircleFromPoints
		if (el.hasAttribute('data-radius-point')) return null;
		
		const pointId = el.getAttribute('data-center');
		if (!pointId) return null;
		
		const point = document.getElementById(pointId);
		if (!point) return null;
		
		const { x: cx, y: cy } = getPointXY(point);
		return { cx, cy };
	};
	
	//: 解析 data-center + data-radius-point ; 返回 { cx, cy, r } 或 null
	const resolveCircleRadiusPoint = (el) => 
	{
		const centerId = el.getAttribute('data-center');
		const rimId = el.getAttribute('data-radius-point');
		if (!centerId || !rimId) return null;
		
		const centerPoint = document.getElementById(centerId);
		const rimPoint = document.getElementById(rimId);
		if (!centerPoint || !rimPoint) return null;
		
		const { x: cx, y: cy } = getPointXY(centerPoint);
		const { x: rx, y: ry } = getPointXY(rimPoint);
		
		const r = Math.hypot(rx - cx, ry - cy);
		
		return { cx, cy, r };
	};
	
	//: 解析 data-path-spell ; 返回 { d } 或 null
	const resolvePathSpell = (el) => 
	{
		const spell = el.getAttribute('data-path-spell');
		if (!spell) return null;
		const tokens = spell.trim().split(/[\s,]+/).map(tok => tok.trim()).filter(Boolean);
		const SPELL_DICTS = 
		[
			{ keys: ['始','開','初'], d: 'M', expectPoint: true },
			{ keys: ['連'], d: 'L', expectPoint: true },
			{ keys: ['迴'], d: 'A 1,1 720 1,1', expectPoint: true },
			{ keys: ['返'], d: 'A 1,1 360 1,0', expectPoint: true },
			{ keys: ['還'], d: 'A 1,1 720 0,1', expectPoint: true },
			{ keys: ['退'], d: 'A 1,1 360 0,0', expectPoint: true },
			{ keys: ['終','畢','止'], d: 'Z', expectPoint: false },
		];
		const CONTROL_MAP = new Map
		(
			SPELL_DICTS.flatMap( 
				({ keys, d, expectPoint }) =>
					keys.map(key => [key, { d, expectPoint }]) )
		);
		const parsed = tokens.reduce(
			(acc, token) => 
			{
				if (acc === null) /* 输入失败 - 输出失败 */ return null;
				
				if (acc.expectPoint) 
				{
					const point = document.getElementById(token);
					if (!point) /* 点不存在 - 整体失败 */ return null;
					return { d: [...acc.d, getPointRawXY(point)], expectPoint: false };
				}
				
				// switch (token) 
				// {
				// 	case '始': return { d: [...acc.d, 'M'], expectPoint: true };
				// 	case '連': return { d: [...acc.d, 'L'], expectPoint: true };
				// 	case '迴': return { d: [...acc.d, 'A 1,1 720 1,1'], expectPoint: true };
				// 	case '返': return { d: [...acc.d, 'A 1,1 360 1,0'], expectPoint: true };
				// 	case '還': return { d: [...acc.d, 'A 1,1 720 0,1'], expectPoint: true };
				// 	case '退': return { d: [...acc.d, 'A 1,1 360 0,0'], expectPoint: true };
				// 	case '止': return { d: [...acc.d, 'Z'], expectPoint: false };
				// 	default: /* 未知指令 - 跳过 */ return acc;
				// }
				
				const as = CONTROL_MAP.get(token);
				return as ? 
					{ d: [...acc.d, as.d], expectPoint: as.expectPoint } : 
					/* 未知标记 - 跳过 */ acc ;
			},
			{ d: [], expectPoint: false },
		);
		if (!parsed) /* 若 reduce 中途返回 null - 则函数返回 null */ return null;
		return { d: parsed.d.map(tok => tok.trim()).join(' ') };
	};
	
	//: ---------- 主流程 - 收集操作并统一执行 ----------
	
	const applyConstraints = () => 
	{
		const pointResolvers = [
			//: 交点圆 intersectionEls
			{ selector: '[data-intersection-of]', resolve: resolveIntersection },
			//: 普通圆心 centerEls
			{ selector: 'circle[data-center], ellipse[data-center]', resolve: resolveCircleCenter },
		];
		const lineResolvers = [
			//: 连接线 endpointLines
			{ selector: 'line[data-endpoints]', resolve: resolveEndpointLine },
		];
		const radiusResolvers = [
			//: 規心定圆 ...
			{ selector: 'circle[data-radius-point], ellipse[data-radius-point]', resolve: resolveCircleRadiusPoint },
		];
		const pathResolvers = [
			{ selector: 'path[data-path-spell]', resolve: resolvePathSpell },
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
		
		//: 定点
		executeResolvers(pointResolvers);
		//: 畫影
		executeResolvers(lineResolvers);
		//: 朙眼
		executeResolvers(radiusResolvers);
		//: 見面
		executeResolvers(pathResolvers);
	};
	
	
	//: ---------- 交互 - 键盘或点击 ----------
	
	const initInteraction = () => 
	{
		const boneElements = [...document.querySelectorAll('.龍骨')];
		const faceElements = [...document.querySelectorAll('.色面')];
		/* 状态 -- 0: 都显示, 1: 隐藏龍骨, 2: 隐藏色面 */
		let state = 0;
		/* 状态应用之操作 */
		const applyState = () => 
		{
			const showFace = state !== 2;
			const showBones = state !== 1;
			faceElements.forEach(el => { el.style.display = showFace ? '' : 'none' });
			boneElements.forEach(el => { el.style.display = showBones ? '' : 'none' });
		};
		/* 切换状态并应用 */
		const advanceState = () => 
		{
			state = (state + 1) % 3;
			applyState();
		};
		const handlers = 
		{
			keydown: (stateApplier) => (event) => 
			{
				if (event.code === 'Space' || event.key === ' ') {
					/* 阻止空格滚动页面 */ event.preventDefault();
					stateApplier();
				} else {
				}
			},
			click: (stateApplier) => (_event) => 
			{
				stateApplier();
			},
		}
		document.addEventListener('keydown', handlers.keydown(advanceState));
		document.getElementById('觸用').addEventListener('click', handlers.click(advanceState));
	};
	
	
	//: ---------- 应用 - 转换与交互 ----------
	
	// window.addEventListener('DOMContentLoaded', applyConstraints);
	
	if (document.readyState === 'loading') {
		document.addEventListener('DOMContentLoaded', () => {
			applyConstraints();
			initInteraction();
		});
	} else {
		applyConstraints();
		initInteraction();
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
