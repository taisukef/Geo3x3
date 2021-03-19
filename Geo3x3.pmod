string encode(float lat, float lng, int level) {
	if (level < 1) {
		return "";
	}
	string res = "E";
	if (lng < 0) {
		res = "W";
		lng += 180.0;
	}
	lat += 90.0; // 180:the North Pole,  0:the South Pole
	float unit = 180.0;
	for (int i = 1; i < level; i++) {
		unit /= 3.0;
		int x = (int)(lng / unit);
		int y = (int)(lat / unit);
		res += x + y * 3 + 1;
		lng -= x * unit;
		lat -= y * unit;
	}
	return res;
}
array(float) decode(string code) {
	if (strlen(code) == 0) {
		return ({});
	}
	bool flg = code[0] == 'W';
	float unit = 180.0;
	float lat = 0.0;
	float lng = 0.0;
	int level = 1;
	for (int i = 1; i < strlen(code); i++) {
		int n = search("0123456789", code[i]);
		if (n == 0) {
			break;
		}
		unit /= 3.0;
		n--;
		lng += (n % 3) * unit;
		lat += (int)(n / 3) * unit;
		level++;
	}
	lat += unit / 2.0;
	lng += unit / 2.0;
	lat -= 90.0;
	if (flg) {
		lng -= 180.0;
	}
	return ({ lat, lng, (float)level, unit });
}
