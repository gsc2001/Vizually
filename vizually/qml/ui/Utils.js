
function getHeight(par) {
	var vis_cnt = 0
	if (par.visible == 0) {
		return 30
	}
	for(var i=1; i<par.children.length; i++){
		if(par.children[i].visible == 1){
			vis_cnt++
		}
	}
	return 48 * vis_cnt + 90
}
