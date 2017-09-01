<?php
	function checkParenthesis($str) {
		if (!is_null($str)) {
			$cnt1 = substr_count($str, "(");
			$cnt2 = substr_count($str, ")");
			if ($cnt1 == 0 and $cnt2 == 0)
				return "No parenthesis in string";
			if ($cnt1 == $cnt2) {
				return "Yes";
			}
			return "No";
		}
		return "No string for checking. Enter argument";
	}
	
	$arr = $_SERVER['argv'];
	echo checkParenthesis($arr[1]);
?>
