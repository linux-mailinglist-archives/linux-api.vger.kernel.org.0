Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 629841F6EB5
	for <lists+linux-api@lfdr.de>; Thu, 11 Jun 2020 22:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726331AbgFKU0d (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 11 Jun 2020 16:26:33 -0400
Received: from esa1.mentor.iphmx.com ([68.232.129.153]:23442 "EHLO
        esa1.mentor.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbgFKU0d (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 11 Jun 2020 16:26:33 -0400
IronPort-SDR: eXjIEvI/AV1uMGRiA4t8tELcGfVzixuh0UNB0BNzL0su2p3avlq1iUN1MY4AxrXGlesZnTbiZ4
 7j8UGGndfA1S63XTS4KuXZwdCpmQZLgRp0IUmtJw5XdGDYky4rojkMByQqHRjlcH1xzmxs03BG
 9Y7/9rBajes+Yrcd6/u+6KhCnaIIST30FTk/jcosZYerKTPS+/WLBHtZMU4kGepUu+z+5Xnp39
 YAHUYqTGqWqOhi7elahHOrrt5vUu3uJ56j2haHlm/2kME+t+v5BrSLaBGKCbzvjR8h4aD82Tyt
 QJE=
X-IronPort-AV: E=Sophos;i="5.73,501,1583222400"; 
   d="scan'208";a="51845782"
Received: from orw-gwy-01-in.mentorg.com ([192.94.38.165])
  by esa1.mentor.iphmx.com with ESMTP; 11 Jun 2020 12:26:32 -0800
IronPort-SDR: keSQDGxnKeVtZ2RRemIwwShIoZzllc7C69jdIbWEiZ8i0XzU+1AY852RjbEhW1CwHo/1P9i8Zr
 8QpqHkk8ZU0LMlcb6VWLI5ERiZiCfFmOMk4Y+auX6ZKSbTO/StO7mBK540w9e7/nokjZB30cwg
 SUI5qsng9LtlcXRMTJp9vuiAknHVJPqxCo0AmOwMJkoSG6LrSBY+5ZsKfx9oNLjQWhr37V23LF
 BufE2M0CBUmXSGjX2oMBScY8i+TTpwN0UPT9qKetVvIa3ztWLOlqmetXjeIYl7HMbMsLsHu/V9
 pYw=
Date:   Thu, 11 Jun 2020 20:26:25 +0000
From:   Joseph Myers <joseph@codesourcery.com>
X-X-Sender: jsm28@digraph.polyomino.org.uk
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC:     Michael Kerrisk <mtk.manpages@gmail.com>,
        Florian Weimer <fweimer@redhat.com>,
        Rich Felker <dalias@libc.org>,
        libc-alpha <libc-alpha@sourceware.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-api <linux-api@vger.kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ben Maurer <bmaurer@fb.com>, Dave Watson <davejwatson@fb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul <paulmck@linux.vnet.ibm.com>, Paul Turner <pjt@google.com>
Subject: Re: [PATCH glibc 1/3] glibc: Perform rseq registration at C startup
 and thread creation (v20)
In-Reply-To: <419546979.1229.1591897672174.JavaMail.zimbra@efficios.com>
Message-ID: <alpine.DEB.2.21.2006112026090.18393@digraph.polyomino.org.uk>
References: <20200527185130.5604-1-mathieu.desnoyers@efficios.com> <20200527185130.5604-2-mathieu.desnoyers@efficios.com> <87d06gxsla.fsf@oldenburg2.str.redhat.com> <alpine.DEB.2.21.2006031718070.7179@digraph.polyomino.org.uk>
 <188671972.53608.1591269056445.JavaMail.zimbra@efficios.com> <alpine.DEB.2.21.2006041745360.8237@digraph.polyomino.org.uk> <419546979.1229.1591897672174.JavaMail.zimbra@efficios.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: SVR-IES-MBX-07.mgc.mentorg.com (139.181.222.7) To
 svr-ies-mbx-02.mgc.mentorg.com (139.181.222.2)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, 11 Jun 2020, Mathieu Desnoyers wrote:

> I managed to get a repository up and running for librseq, and have integrated
> the rseq.2 man page with comments from Michael Kerrisk here:
> 
> https://git.kernel.org/pub/scm/libs/librseq/librseq.git/tree/doc/man/rseq.2
> 
> Is that a suitable URL ? Can we simply point to it from glibc's manual ?

Yes, that seems something reasonable to link to.

-- 
Joseph S. Myers
joseph@codesourcery.com
