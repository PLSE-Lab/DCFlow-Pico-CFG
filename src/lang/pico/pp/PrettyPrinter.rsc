@license{
  Copyright (c) 2009-2014 CWI
  All rights reserved. This program and the accompanying materials
  are made available under the terms of the Eclipse Public License v1.0
  which accompanies this distribution, and is available at
  http://www.eclipse.org/legal/epl-v10.html
}
@contributor{Mark Hills - mhills@cs.ecu.edu (ECU)}
module lang::pico::pp::PrettyPrinter

import demo::lang::Pico::Abstract;
import demo::lang::Pico::Visualize;

public str pp(node n) {
	if (EXP e := n) {
		return make(e);
	} else if (asgStat(PicoId name, EXP exp) := n) {
		return "<name> := <make(exp)>";
	} else {
		return "";
	}
}