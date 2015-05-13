@license{
  Copyright (c) 2009-2014 CWI
  All rights reserved. This program and the accompanying materials
  are made available under the terms of the Eclipse Public License v1.0
  which accompanies this distribution, and is available at
  http://www.eclipse.org/legal/epl-v10.html
}
@contributor{Mark Hills - mhills@cs.ecu.edu (ECU)}
module lang::dcflow::demo::Pico

import demo::lang::Pico::Abstract;

public void demo() {
	generateLabeler(|project://CFG/src/generated/LabelPicoAST.rsc|, "LabelPicoAST", ["List","demo::lang::Pico::Abstract"], {"EXP"}, "PROGRAM");
}