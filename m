Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A886F13508
	for <lists+linux-api@lfdr.de>; Fri,  3 May 2019 23:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbfECV4i (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 3 May 2019 17:56:38 -0400
Received: from smtprelay0045.hostedemail.com ([216.40.44.45]:49935 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726727AbfECV4i (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 3 May 2019 17:56:38 -0400
X-Greylist: delayed 610 seconds by postgrey-1.27 at vger.kernel.org; Fri, 03 May 2019 17:56:37 EDT
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave01.hostedemail.com (Postfix) with ESMTP id 3F5B31801E8C1
        for <linux-api@vger.kernel.org>; Fri,  3 May 2019 21:46:28 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 42668180143F7;
        Fri,  3 May 2019 21:46:26 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::::::::::::::::::::::::::::::::::,RULES_HIT:41:355:379:599:800:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1539:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2692:2693:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3872:3873:4321:5007:6742:6743:10004:10400:10848:11026:11473:11658:11914:12043:12740:12760:12895:13069:13311:13357:13439:14181:14659:14721:21063:21080:21627:30054:30056:30090:30091,0,RBL:84.16.30.4:@perches.com:.lbl8.mailshell.net-62.14.6.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:28,LUA_SUMMARY:none
X-HE-Tag: cars17_8e972f856e746
X-Filterd-Recvd-Size: 2628
Received: from XPS-9350 (unknown [84.16.30.4])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Fri,  3 May 2019 21:46:19 +0000 (UTC)
Message-ID: <5a671727418034dd1de54ad67f3f028f3cde9516.camel@perches.com>
Subject: Re: [PATCH for 5.2 00/12] Restartable Sequences selftests updates
From:   Joe Perches <joe@perches.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        shuah <shuah@kernel.org>, Andy Whitcroft <apw@canonical.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@arm.linux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <andi@firstfloor.org>,
        Chris Lameter <cl@linux.com>, Ben Maurer <bmaurer@fb.com>,
        rostedt <rostedt@goodmis.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Joel Fernandes <joelaf@google.com>
Date:   Fri, 03 May 2019 14:46:17 -0700
In-Reply-To: <1137649333.995.1556911352713.JavaMail.zimbra@efficios.com>
References: <20190429152803.7719-1-mathieu.desnoyers@efficios.com>
         <678952111.699.1556908562445.JavaMail.zimbra@efficios.com>
         <68a135d7-7b30-71c7-c570-c7608d6f75d5@kernel.org>
         <1137649333.995.1556911352713.JavaMail.zimbra@efficios.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, 2019-05-03 at 15:22 -0400, Mathieu Desnoyers wrote:
> ----- On May 3, 2019, at 2:53 PM, shuah shuah@kernel.org wrote:
> > ERROR: need consistent spacing around '%' (ctx:WxV)
> > #227: FILE: tools/testing/selftests/rseq/rseq-x86.h:104:
> > +		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_CPU_ID_OFFSET(%[rseq_abi]), %l[error1])
> > 
> > Will you be able to fix them and resend?
[]
> (CCing the che checkpatch maintainers)
> 
> checkpatch appears to be wrong for these errors. I suspect it thinks those are
> '%' modulo operators (for which the style requires space before/after),
> but those are actually part of the asm input and goto target operands.

checkpatch doesn't really understand asm.
Ignore checkpatch when it's silly.


