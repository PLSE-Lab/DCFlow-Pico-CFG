@license{
  Copyright (c) 2009-2014 CWI
  All rights reserved. This program and the accompanying materials
  are made available under the terms of the Eclipse Public License v1.0
  which accompanies this distribution, and is available at
  http://www.eclipse.org/legal/epl-v10.html
}
@contributor{Mark Hills - mhills@cs.ecu.edu (ECU)}
module lang::pico::util::Pico

import IO;
import ParseTree;
import demo::lang::Pico::Syntax;
import demo::lang::Pico::Abstract;
import demo::lang::Pico::Load;
import lang::dcflow::generate::GenerateAll;
import lang::dcflow::base::CFG;
import lang::pico::pp::PrettyPrinter;
import lang::dcflow::util::Visualize;

public PROGRAM getPicoProgram(loc l) {
	return implode(#PROGRAM, parse(#Program, l));;
}

public void generatePicoBuilder() {
	generateAll(|project://PicoCFG/src/lang/pico/cfg/Pico.cfg|, |project://PicoCFG/src|);
}

public void visualizeCFG(CFG c, loc writeTo, bool addTitle = false, str title = "") {
	renderCFGAsDot(c, writeTo, pp, addTitle = addTitle, title = title);
}
