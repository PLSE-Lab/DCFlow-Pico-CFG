module generated::BuildPicoCFG

import lang::dcflow::base::CFG;
import lang::dcflow::base::CFGExceptions;
extend lang::dcflow::base::CFGUtils;
import lang::dcflow::base::FlowEdge;
import lang::dcflow::base::Label;
import lang::dcflow::base::LabelState;

import demo::lang::Pico::Abstract;

import lang::pico::cfg::CFGBase;

import Set;
import List;
import Type;

private tuple[PROGRAM,LabelState] labelAST(PROGRAM ast) {
    return labelAST(newLabelState(), ast);
}

private tuple[PROGRAM,LabelState] labelAST(LabelState ls, PROGRAM ast) {
    Lab incLabel() { 
        ls.counter += 1; 
        return lab(ls.counter); 
    }

    labeledAst = bottom-up visit(ast) {
         case PROGRAM n => n[@lab = incLabel()]
         case STATEMENT n => n[@lab = incLabel()]
         case EXP n => n[@lab = incLabel()]
        
    };

    ls.cfgNodes = ( n@lab : cfgNode(n,n@lab) | /node n := labeledAst, (n@lab)?);

    return < labeledAst, ls >;
}

private Lab entry(EXP item:add(EXP left,EXP right), LabelState ls) {
 
        list[Lab] labels = [ ];
        if (item@lab in ls.headerNodes) {
            return ls.headerNodes[item@lab];
        }
        labels = labels + entry(left, ls);
        
        validLabels = [ l | l <- labels, !(l is nothing) ];
        if (size(validLabels) > 0) {
            return validLabels[0];
        }
        
        return item@lab;
        
 
}
private Lab entry(EXP item:conc(EXP left,EXP right), LabelState ls) {
 
        list[Lab] labels = [ ];
        if (item@lab in ls.headerNodes) {
            return ls.headerNodes[item@lab];
        }
        labels = labels + entry(left, ls);
        
        validLabels = [ l | l <- labels, !(l is nothing) ];
        if (size(validLabels) > 0) {
            return validLabels[0];
        }
        
        return item@lab;
        
 
}
private Lab entry(EXP item:id(str name), LabelState ls) {
 
        list[Lab] labels = [ ];
        if (item@lab in ls.headerNodes) {
            return ls.headerNodes[item@lab];
        }
        labels = labels + item@lab;
        
        validLabels = [ l | l <- labels, !(l is nothing) ];
        if (size(validLabels) > 0) {
            return validLabels[0];
        }
        
        return item@lab;
        
 
}
private Lab entry(EXP item:natCon(int iVal), LabelState ls) {
 
        list[Lab] labels = [ ];
        if (item@lab in ls.headerNodes) {
            return ls.headerNodes[item@lab];
        }
        labels = labels + item@lab;
        
        validLabels = [ l | l <- labels, !(l is nothing) ];
        if (size(validLabels) > 0) {
            return validLabels[0];
        }
        
        return item@lab;
        
 
}
private Lab entry(EXP item:strCon(str sVal), LabelState ls) {
 
        list[Lab] labels = [ ];
        if (item@lab in ls.headerNodes) {
            return ls.headerNodes[item@lab];
        }
        labels = labels + item@lab;
        
        validLabels = [ l | l <- labels, !(l is nothing) ];
        if (size(validLabels) > 0) {
            return validLabels[0];
        }
        
        return item@lab;
        
 
}
private Lab entry(EXP item:sub(EXP left,EXP right), LabelState ls) {
 
        list[Lab] labels = [ ];
        if (item@lab in ls.headerNodes) {
            return ls.headerNodes[item@lab];
        }
        labels = labels + entry(left, ls);
        
        validLabels = [ l | l <- labels, !(l is nothing) ];
        if (size(validLabels) > 0) {
            return validLabels[0];
        }
        
        return item@lab;
        
 
}
private Lab entry(PROGRAM item:program(list[DECL] decls,list[STATEMENT] stats), LabelState ls) {

    if (ls.context.tn == "PROGRAM" && ls.context.cn == "program") {
 
        list[Lab] labels = [ ];
        if (item@lab in ls.headerNodes) {
            return ls.headerNodes[item@lab];
        }
        labels = labels + entry(stats, ls);
        
        validLabels = [ l | l <- labels, !(l is nothing) ];
        if (size(validLabels) > 0) {
            return validLabels[0];
        }
        
        return item@lab;
        

    } else {
        return item@lab;
    }
 
}
private Lab entry(STATEMENT item:asgStat(str name,EXP exp), LabelState ls) {
 
        list[Lab] labels = [ ];
        if (item@lab in ls.headerNodes) {
            return ls.headerNodes[item@lab];
        }
        labels = labels + entry(exp, ls);
        
        validLabels = [ l | l <- labels, !(l is nothing) ];
        if (size(validLabels) > 0) {
            return validLabels[0];
        }
        
        return item@lab;
        
 
}
private Lab entry(STATEMENT item:ifElseStat(EXP exp,list[STATEMENT] thenpart,list[STATEMENT] elsepart), LabelState ls) {
 
        list[Lab] labels = [ ];
        if (item@lab in ls.headerNodes) {
            return ls.headerNodes[item@lab];
        }
        labels = labels + entry(exp, ls);
        
        validLabels = [ l | l <- labels, !(l is nothing) ];
        if (size(validLabels) > 0) {
            return validLabels[0];
        }
        
        return item@lab;
        
 
}
private Lab entry(STATEMENT item:whileStat(EXP exp,list[STATEMENT] body), LabelState ls) {
 
        list[Lab] labels = [ ];
        if (item@lab in ls.headerNodes) {
            return ls.headerNodes[item@lab];
        }
        labels = labels + entry(exp, ls);
        
        validLabels = [ l | l <- labels, !(l is nothing) ];
        if (size(validLabels) > 0) {
            return validLabels[0];
        }
        
        return item@lab;
        
 
}

private set[Lab] exit(EXP item:add(EXP left,EXP right), LabelState ls) {
 
        if (item@lab in ls.footerNodes) {
            return { ls.footerNodes[item@lab] };
        }
        if (item@lab in ls.linkNodes) {
            return { ls.linkNodes[item@lab] };
        }
        set[Lab] labels = { };
        labels = labels + item@lab;
        
        
        if (size(labels) == 0) {
            return { item@lab };
        }
        

        return labels;
 
}
private set[Lab] exit(EXP item:conc(EXP left,EXP right), LabelState ls) {
 
        if (item@lab in ls.footerNodes) {
            return { ls.footerNodes[item@lab] };
        }
        if (item@lab in ls.linkNodes) {
            return { ls.linkNodes[item@lab] };
        }
        set[Lab] labels = { };
        labels = labels + item@lab;
        
        
        if (size(labels) == 0) {
            return { item@lab };
        }
        

        return labels;
 
}
private set[Lab] exit(EXP item:id(str name), LabelState ls) {
 
        if (item@lab in ls.footerNodes) {
            return { ls.footerNodes[item@lab] };
        }
        if (item@lab in ls.linkNodes) {
            return { ls.linkNodes[item@lab] };
        }
        set[Lab] labels = { };
        labels = labels + item@lab;
        
        
        if (size(labels) == 0) {
            return { item@lab };
        }
        

        return labels;
 
}
private set[Lab] exit(EXP item:natCon(int iVal), LabelState ls) {
 
        if (item@lab in ls.footerNodes) {
            return { ls.footerNodes[item@lab] };
        }
        if (item@lab in ls.linkNodes) {
            return { ls.linkNodes[item@lab] };
        }
        set[Lab] labels = { };
        labels = labels + item@lab;
        
        
        if (size(labels) == 0) {
            return { item@lab };
        }
        

        return labels;
 
}
private set[Lab] exit(EXP item:strCon(str sVal), LabelState ls) {
 
        if (item@lab in ls.footerNodes) {
            return { ls.footerNodes[item@lab] };
        }
        if (item@lab in ls.linkNodes) {
            return { ls.linkNodes[item@lab] };
        }
        set[Lab] labels = { };
        labels = labels + item@lab;
        
        
        if (size(labels) == 0) {
            return { item@lab };
        }
        

        return labels;
 
}
private set[Lab] exit(EXP item:sub(EXP left,EXP right), LabelState ls) {
 
        if (item@lab in ls.footerNodes) {
            return { ls.footerNodes[item@lab] };
        }
        if (item@lab in ls.linkNodes) {
            return { ls.linkNodes[item@lab] };
        }
        set[Lab] labels = { };
        labels = labels + item@lab;
        
        
        if (size(labels) == 0) {
            return { item@lab };
        }
        

        return labels;
 
}
private set[Lab] exit(PROGRAM item:program(list[DECL] decls,list[STATEMENT] stats), LabelState ls) {

    if (ls.context.tn == "PROGRAM" && ls.context.cn == "program") {
 
        if (item@lab in ls.footerNodes) {
            return { ls.footerNodes[item@lab] };
        }
        if (item@lab in ls.linkNodes) {
            return { ls.linkNodes[item@lab] };
        }
        set[Lab] labels = { };
        labels = labels + exit(stats, ls);
        
        
        if (size(labels) == 0) {
            return { item@lab };
        }
        

        return labels;

    } else {
        return { item@lab };
    }
 
}
private set[Lab] exit(STATEMENT item:asgStat(str name,EXP exp), LabelState ls) {
 
        if (item@lab in ls.footerNodes) {
            return { ls.footerNodes[item@lab] };
        }
        if (item@lab in ls.linkNodes) {
            return { ls.linkNodes[item@lab] };
        }
        set[Lab] labels = { };
        labels = labels + item@lab;
        
        
        if (size(labels) == 0) {
            return { item@lab };
        }
        

        return labels;
 
}
private set[Lab] exit(STATEMENT item:ifElseStat(EXP exp,list[STATEMENT] thenpart,list[STATEMENT] elsepart), LabelState ls) {
 
        if (item@lab in ls.footerNodes) {
            return { ls.footerNodes[item@lab] };
        }
        if (item@lab in ls.linkNodes) {
            return { ls.linkNodes[item@lab] };
        }
        set[Lab] labels = { };
        labels = labels + exit(thenpart, ls);
        labels = labels + exit(exp, ls);
        labels = labels + exit(elsepart, ls);
        labels = labels + exit(exp, ls);
        
        
        if (size(labels) == 0) {
            return { item@lab };
        }
        

        return labels;
 
}
private set[Lab] exit(STATEMENT item:whileStat(EXP exp,list[STATEMENT] body), LabelState ls) {
 
        if (item@lab in ls.footerNodes) {
            return { ls.footerNodes[item@lab] };
        }
        if (item@lab in ls.linkNodes) {
            return { ls.linkNodes[item@lab] };
        }
        set[Lab] labels = { };
        labels = labels + exit(exp, ls);
        
        
        if (size(labels) == 0) {
            return { item@lab };
        }
        

        return labels;
 
}

private tuple[FlowEdges,LabelState] internalFlow(EXP item:add(EXP left,EXP right), LabelState ls) {
    FlowEdges edges = { };
    < edges, ls > = addEdges(edges, ls, left);
    < edges, ls > = addEdges(edges, ls, right);
    for(exlab <- exit(left,ls)) {
    < edges, ls > = linkItemsLabelLabel(edges, ls, exlab, entry(right,ls) );
}
    for(exlab <- exit(right,ls)) {
    < edges, ls > = linkItemsLabelLabel(edges, ls, exlab, item@lab );
}
    
    return < edges, ls >;
}
private tuple[FlowEdges,LabelState] internalFlow(EXP item:conc(EXP left,EXP right), LabelState ls) {
    FlowEdges edges = { };
    < edges, ls > = addEdges(edges, ls, left);
    < edges, ls > = addEdges(edges, ls, right);
    for(exlab <- exit(left,ls)) {
    < edges, ls > = linkItemsLabelLabel(edges, ls, exlab, entry(right,ls) );
}
    for(exlab <- exit(right,ls)) {
    < edges, ls > = linkItemsLabelLabel(edges, ls, exlab, item@lab );
}
    
    return < edges, ls >;
}
private tuple[FlowEdges,LabelState] internalFlow(EXP item:id(str name), LabelState ls) {
    FlowEdges edges = { };
    
    return < edges, ls >;
}
private tuple[FlowEdges,LabelState] internalFlow(EXP item:natCon(int iVal), LabelState ls) {
    FlowEdges edges = { };
    
    return < edges, ls >;
}
private tuple[FlowEdges,LabelState] internalFlow(EXP item:strCon(str sVal), LabelState ls) {
    FlowEdges edges = { };
    
    return < edges, ls >;
}
private tuple[FlowEdges,LabelState] internalFlow(EXP item:sub(EXP left,EXP right), LabelState ls) {
    FlowEdges edges = { };
    < edges, ls > = addEdges(edges, ls, left);
    < edges, ls > = addEdges(edges, ls, right);
    for(exlab <- exit(left,ls)) {
    < edges, ls > = linkItemsLabelLabel(edges, ls, exlab, entry(right,ls) );
}
    for(exlab <- exit(right,ls)) {
    < edges, ls > = linkItemsLabelLabel(edges, ls, exlab, item@lab );
}
    
    return < edges, ls >;
}
private tuple[FlowEdges,LabelState] internalFlow(PROGRAM item:program(list[DECL] decls,list[STATEMENT] stats), LabelState ls) {
    FlowEdges edges = { };
    for(i <- stats) {
	< edges, ls > = addEdges(edges, ls, i);
}
< edges, ls > = addSeqEdges(edges, ls, stats);
    
    return < edges, ls >;
}
private tuple[FlowEdges,LabelState] internalFlow(STATEMENT item:asgStat(str name,EXP exp), LabelState ls) {
    FlowEdges edges = { };
    < edges, ls > = addEdges(edges, ls, exp);
    for(exlab <- exit(exp,ls)) {
    < edges, ls > = linkItemsLabelLabel(edges, ls, exlab, item@lab );
}
    
    return < edges, ls >;
}
private tuple[FlowEdges,LabelState] internalFlow(STATEMENT item:ifElseStat(EXP exp,list[STATEMENT] thenpart,list[STATEMENT] elsepart), LabelState ls) {
    FlowEdges edges = { };
    < edges, ls > = addEdges(edges, ls, exp);
    for(i <- thenpart) {
	< edges, ls > = addEdges(edges, ls, i);
}
< edges, ls > = addSeqEdges(edges, ls, thenpart);
    for(exlab <- exit(exp,ls)) {
    < edges, ls > = linkItemsLabelLabel(edges, ls, exlab, entry(thenpart,ls) ,conditionTrue());
}
    for(i <- elsepart) {
	< edges, ls > = addEdges(edges, ls, i);
}
< edges, ls > = addSeqEdges(edges, ls, elsepart);
    for(exlab <- exit(exp,ls)) {
    < edges, ls > = linkItemsLabelLabel(edges, ls, exlab, entry(elsepart,ls) ,conditionFalse());
}
    
    return < edges, ls >;
}
private tuple[FlowEdges,LabelState] internalFlow(STATEMENT item:whileStat(EXP exp,list[STATEMENT] body), LabelState ls) {
    FlowEdges edges = { };
    if (item@lab notin ls.linkNodes) {
	< fn, ls > = createLink(ls);
    ls.linkNodes[item@lab] = fn.l;
}

    < edges, ls > = addEdges(edges, ls, exp);
    for(i <- body) {
	< edges, ls > = addEdges(edges, ls, i);
}
< edges, ls > = addSeqEdges(edges, ls, body);
    for(exlab <- exit(exp,ls)) {
    < edges, ls > = linkItemsLabelLabel(edges, ls, exlab, entry(body,ls) ,conditionTrue());
}
    for(exlab <- exit(body,ls)) {
    < edges, ls > = linkItemsLabelLabel(edges, ls, exlab, entry(exp,ls) ,backedge());
}
    for(exlab <- exit(exp,ls)) {
    < edges, ls > = linkItemsLabelLabel(edges, ls, exlab, ls.linkNodes[item@lab] ,conditionFalse());
}
    
    return < edges, ls >;
}

public map[loc,CFG] createCFG(PROGRAM p) {
    map[loc,CFG] res = ( );
    < pLabeled, ls > = labelAST(p);

    for (/PROGRAM item := pLabeled, item is program) {
        locForItem = getItemLoc(item);
        ls.context = < "PROGRAM", "program" >;
        < itemCFG, ls > = createPROGRAMprogramCFG(item, locForItem, ls);
        ls = resetLabelState(ls);
        res[locForItem] = itemCFG; 
    }

    return res;
}
private tuple[CFG,LabelState] createPROGRAMprogramCFG(PROGRAM item, loc itemLoc, LabelState ls) {
    FlowEdges edges = { };
    < enode, ls > = createEntry(ls);
    < xnode, ls > = createExit(ls);
    ls = addEntryExitNodes(ls, enode, xnode);

    ls.jumpTargets = findUnstructuredJumpTargets(ls, item);

    < edges, ls > = internalFlow(item, ls);
    < edges, ls > = linkItemsLabelLabel(edges, ls, enode.l, entry(item,ls));
    for (el <- exit(item,ls)) {
        < edges, ls > = linkItemsLabelLabel(edges, ls, el, xnode.l);
    }

    edges = addMissingEdgeLabels(ls, edges);
    edges = consolidateEdges(edges);
    edges = removeImpossibleEdges(edges);
    < edges, ls > = removeLinks(edges, ls);

    nodeMap = deriveNodeMap(ls,edges);
    return < cfg(itemLoc, nodeMap, edges, ls.labeledNodes), ls >;
}

			  