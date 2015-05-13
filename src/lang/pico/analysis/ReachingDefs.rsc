@license{
  Copyright (c) 2009-2014 CWI
  All rights reserved. This program and the accompanying materials
  are made available under the terms of the Eclipse Public License v1.0
  which accompanies this distribution, and is available at
  http://www.eclipse.org/legal/epl-v10.html
}
@contributor{Mark Hills - mhills@cs.ecu.edu (ECU)}
module lang::pico::ReachingDefs

import lang::dcflow::base::CFG;
import lang::dcflow::base::CFGUtils;
import lang::dcflow::base::FlowEdge;
import lang::dcflow::base::Label;
import generated::BuildPicoCFG;
import demo::lang::Pico::Abstract;
import lang::dcflow::base::BasicBlocks;
import lang::dcflow::util::Pico;

import Set;
import List;
import Relation;

public CFG getPicoCFG(loc l) {
	return getOneFrom(createCFG(getPicoProgram(l))<1>);
}

public CFG useBasicBlocks(CFG c) = createBasicBlocks(c);

public rel[PicoId,Lab] computeDefs(CFG c) = 
	{ < name, l > | cfgNode(asgStat(PicoId name, _),l) <- c.nodes<1> };

public set[Lab] gen(cfgNode(asgStat(PicoId name, _),l)) = { l };
public default set[Lab] gen(CFGNode n) = { };

public set[Lab] kill(cfgNode(asgStat(PicoId name, _),l),rel[PicoId,Lab] defs) = defs[name]-l;
public default set[Lab] kill(CFGNode n, rel[PicoId,Lab] defs) =  { };

public tuple[rel[Lab,Lab] reachIn, rel[Lab,Lab] reachOut] computeReach(CFG c) {
	rel[Lab,Lab] reachIn = { };
	rel[Lab,Lab] reachOut = { };
	
	defs = computeDefs(c);
	
	solve(reachIn,reachOut) {
		reachIn = { < l, r > | l <- c.nodes, r <- reachOut[pred(c,l)] };
		reachOut = { < l, r > | l <- c.nodes, r <- (gen(c.nodes[l]) + (reachIn[l] - kill(c.nodes[l],defs))) };	
	}
	
	return < reachIn, reachOut >;
}
