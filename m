Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1E441ED4FC
	for <lists+linux-api@lfdr.de>; Wed,  3 Jun 2020 19:30:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726046AbgFCRaB (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 3 Jun 2020 13:30:01 -0400
Received: from esa1.mentor.iphmx.com ([68.232.129.153]:27176 "EHLO
        esa1.mentor.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbgFCRaB (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 3 Jun 2020 13:30:01 -0400
X-Greylist: delayed 426 seconds by postgrey-1.27 at vger.kernel.org; Wed, 03 Jun 2020 13:30:00 EDT
IronPort-SDR: gYEvL9RR6n7QuRr4AOQdxKkoG3j4KYQnpN5LtnvvTLPutPLTJhhGYtjFwooi5fRBEJYrGT4Vx3
 /xSFbDYpQgKXJk/4JvHhdB8p664K6hjxjRuKWv3p9xQrKqV25UcxPai5c9377T7gBj2/kfm1q4
 nRW+kR1+T+GCM5+pKVrc59pCwgy6ENqZeGYgDWwBOWmoCtFvpoRgeqMf5I2HL33hlNT8FZn0gP
 frm5n3SvdT7MByoj5t4b9GCzmD4iakIDr8pbniPWtP2HoMPIay2lDtGcSRAQxgakhiQT/qW0Ka
 aPs=
X-IronPort-AV: E=Sophos;i="5.73,468,1583222400"; 
   d="scan'208";a="51537015"
Received: from orw-gwy-01-in.mentorg.com ([192.94.38.165])
  by esa1.mentor.iphmx.com with ESMTP; 03 Jun 2020 09:22:54 -0800
IronPort-SDR: VYzD3cG7OQGM/KCsYl7lBRJK8hLhcfaZSJgsx65378x1byGXgOeApjsXtUHPOtwzuUEEHDYhSd
 HaAA9gm9gVdG0Q3Ee/XfNDoGsCkLSRP9ofe4Gw0AhgBbLQgp7lnhnBZaCWrt7BRppp0J8R9B+o
 J4ojxl1Pm/Yqtlyt016eclFV+cvZd2Pb56PDz5RvCorz/a3QTOFL2aGHP/UYmTQUS5FUz2DLRz
 Wa8HdvNcTmAGSPQ8iFBel4T+xGp4S//oYEjDdSOjW4fWyYBUAxVfSZJA3k09eIYfw+wKdXIQfi
 o3k=
Date:   Wed, 3 Jun 2020 17:22:47 +0000
From:   Joseph Myers <joseph@codesourcery.com>
X-X-Sender: jsm28@digraph.polyomino.org.uk
To:     Florian Weimer <fweimer@redhat.com>
CC:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Rich Felker <dalias@libc.org>, <libc-alpha@sourceware.org>,
        <linux-api@vger.kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ben Maurer <bmaurer@fb.com>, Dave Watson <davejwatson@fb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Paul Turner <pjt@google.com>
Subject: Re: [PATCH glibc 1/3] glibc: Perform rseq registration at C startup
 and thread creation (v20)
In-Reply-To: <87d06gxsla.fsf@oldenburg2.str.redhat.com>
Message-ID: <alpine.DEB.2.21.2006031718070.7179@digraph.polyomino.org.uk>
References: <20200527185130.5604-1-mathieu.desnoyers@efficios.com> <20200527185130.5604-2-mathieu.desnoyers@efficios.com> <87d06gxsla.fsf@oldenburg2.str.redhat.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: svr-ies-mbx-02.mgc.mentorg.com (139.181.222.2) To
 svr-ies-mbx-02.mgc.mentorg.com (139.181.222.2)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, 3 Jun 2020, Florian Weimer via Libc-alpha wrote:

> I'm still waiting for feedback from other maintainers whether the level
> of documentation and testing is appropriate.

Looking at the documentation in the manual, it doesn't look like it has 
enough information for someone to use this functionality, or to know when 
they might want to use it, and nor does it point to external documentation 
of it.  It would seem appropriate at least to include a link to wherever 
the external documentation is of what this functionality is good for, how 
to create and use a "Restartable Sequence critical section", and how to 
"perform rseq registration to the kernel".

-- 
Joseph S. Myers
joseph@codesourcery.com
