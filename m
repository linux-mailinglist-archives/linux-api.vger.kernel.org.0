Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9AA215D75
	for <lists+linux-api@lfdr.de>; Mon,  6 Jul 2020 19:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729599AbgGFRvI (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 6 Jul 2020 13:51:08 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:41131 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729568AbgGFRvH (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 6 Jul 2020 13:51:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594057866;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yIZDy7/npTujE+1qmA6wlNDx90xTHHdDBj7AS75+Fas=;
        b=bmCL+piRR3lmy/8y6HhulsWJnaPUtEtiLvLTSqJEWgJGfFtbLC6hE3iDVZs4XWvuJ2Y+Tm
        quQDghWV9hfwTMFWUUN8p5weZn4MAKRGooVHv+TBCrMlmh9kQIW944E/38Ekdk4hYjIOxQ
        1f0WTCWKAb+YuQWHAlsgHyIExBD24x8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-302-x4PEWjVBOVCAbFwNXlw4ig-1; Mon, 06 Jul 2020 13:51:05 -0400
X-MC-Unique: x4PEWjVBOVCAbFwNXlw4ig-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 057EC100CC84;
        Mon,  6 Jul 2020 17:51:02 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (ovpn-112-118.ams2.redhat.com [10.36.112.118])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AC753B3A7E;
        Mon,  6 Jul 2020 17:50:55 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     carlos <carlos@redhat.com>, Joseph Myers <joseph@codesourcery.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        libc-alpha <libc-alpha@sourceware.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ben Maurer <bmaurer@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Paul <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Paul Turner <pjt@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>
Subject: Re: [PATCH 2/3] Linux: Use rseq in sched_getcpu if available (v9)
References: <20200629190036.26982-1-mathieu.desnoyers@efficios.com>
        <20200629190036.26982-3-mathieu.desnoyers@efficios.com>
        <877dvg4ud4.fsf@oldenburg2.str.redhat.com>
        <942999672.22574.1594046978937.JavaMail.zimbra@efficios.com>
        <1679448037.22891.1594056826859.JavaMail.zimbra@efficios.com>
Date:   Mon, 06 Jul 2020 19:50:54 +0200
In-Reply-To: <1679448037.22891.1594056826859.JavaMail.zimbra@efficios.com>
        (Mathieu Desnoyers's message of "Mon, 6 Jul 2020 13:33:46 -0400
        (EDT)")
Message-ID: <87k0zg3535.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

* Mathieu Desnoyers:

> Now we need to discuss how we introduce that fix in a way that will
> allow user-space to trust the __rseq_abi.cpu_id field's content.

I don't think that's necessary.  We can mention it in the glibc
distribution notes on the wiki.

> The usual approach to kernel bug fixing is typically to push the fix,
> mark it for stable kernels, and expect everyone to pick up the
> fixes. I wonder how comfortable glibc would be to replace its
> sched_getcpu implementation with a broken-until-fixed kernel rseq
> implementation without any mechanism in place to know whether it can
> trust the value of the cpu_id field. I am extremely reluctant to do
> so.

We have already had similar regressions in sched_getcpu, and we didn't
put anything into glibc to deal with those.

Just queue the fix for the stable kernels.  I expect that all
distributions track stable kernel branches in some way, so just put into
the kernel commit message that this commit is needed for a working
sched_getcpu in glibc 2.32 and later.

Once the upstream fix is in Linus' tree, I'm going to file a request to
backport the fix into the Red Hat Enterprise Linux 8.

Thanks for finding the root cause so quickly,
Florian

