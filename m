Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 829121EE303
	for <lists+linux-api@lfdr.de>; Thu,  4 Jun 2020 13:11:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726026AbgFDLK6 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 4 Jun 2020 07:10:58 -0400
Received: from mail.efficios.com ([167.114.26.124]:44980 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbgFDLK6 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 4 Jun 2020 07:10:58 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id EEBF32C5456;
        Thu,  4 Jun 2020 07:10:56 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id lABorUU7fUUP; Thu,  4 Jun 2020 07:10:56 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 952022C5455;
        Thu,  4 Jun 2020 07:10:56 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 952022C5455
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1591269056;
        bh=1KUporPmaXnM01aB++UOwuHWfy+Lc+22xlsbm4M+iEY=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=iYnI6N0dTWNo/PGXrBPIgA48+Bic32iPb5gH9BB+4odj9lFzDoNsDBYddXODI6OKT
         aPiIwzA8ajSDPSDYt7pVjJU9+h2Np+I43FJ2Up2C4HxpwUA1L5143hU1eyraoJn2J5
         DSGIig7yN4OQa8MtafuSzE652+DV2C1l8R/JHiCMkxo7xszbnjCrrJzS44Xunz/D3t
         GBcE/CoS0bAhGvKU07FWiUKifyKIWg1DB70jQNtuVf9qqsBIuTRtLQsVtno64FHVl/
         M1Ckp2a4yKev6d0W9FAKgZKo+0u7Vhr5KXtNPg2zsGTn4RNTgpAAOS58PoC2Gy9CmG
         NUhO7ZI8IMLzQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id cI2TZ8maBAHa; Thu,  4 Jun 2020 07:10:56 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 822AC2C553F;
        Thu,  4 Jun 2020 07:10:56 -0400 (EDT)
Date:   Thu, 4 Jun 2020 07:10:56 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Joseph Myers <joseph@codesourcery.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Cc:     Florian Weimer <fweimer@redhat.com>, Rich Felker <dalias@libc.org>,
        libc-alpha <libc-alpha@sourceware.org>,
        linux-api <linux-api@vger.kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ben Maurer <bmaurer@fb.com>, Dave Watson <davejwatson@fb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul <paulmck@linux.vnet.ibm.com>, Paul Turner <pjt@google.com>
Message-ID: <188671972.53608.1591269056445.JavaMail.zimbra@efficios.com>
In-Reply-To: <alpine.DEB.2.21.2006031718070.7179@digraph.polyomino.org.uk>
References: <20200527185130.5604-1-mathieu.desnoyers@efficios.com> <20200527185130.5604-2-mathieu.desnoyers@efficios.com> <87d06gxsla.fsf@oldenburg2.str.redhat.com> <alpine.DEB.2.21.2006031718070.7179@digraph.polyomino.org.uk>
Subject: Re: [PATCH glibc 1/3] glibc: Perform rseq registration at C startup
 and thread creation (v20)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3928 (ZimbraWebClient - FF76 (Linux)/8.8.15_GA_3928)
Thread-Topic: glibc: Perform rseq registration at C startup and thread creation (v20)
Thread-Index: zF49gywpspZcwIriHJ+0g73PGzbsCw==
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

----- On Jun 3, 2020, at 1:22 PM, Joseph Myers joseph@codesourcery.com wrote:

> On Wed, 3 Jun 2020, Florian Weimer via Libc-alpha wrote:
> 
>> I'm still waiting for feedback from other maintainers whether the level
>> of documentation and testing is appropriate.
> 
> Looking at the documentation in the manual, it doesn't look like it has
> enough information for someone to use this functionality, or to know when
> they might want to use it, and nor does it point to external documentation
> of it.  It would seem appropriate at least to include a link to wherever
> the external documentation is of what this functionality is good for, how
> to create and use a "Restartable Sequence critical section", and how to
> "perform rseq registration to the kernel".

That external piece of documentation would be part of the Linux man-pages
project, maintained by Michael Kerrisk. I have submitted a few revisions
of the rseq(2) man page, but have been waiting for Michael to reply for more
than a year now:

  https://lore.kernel.org/r/2021826204.69809.1588000508294.JavaMail.zimbra@efficios.com

I'm thinking about hosting a rseq(2) man-page into my librseq project, would
that make sense ?

librseq is currently a development branch in my own repository for now. It still
needs to be tweaked to adapt to the various changes that went into the glibc rseq
enablement patchset, and then I plan to move it to a more "formal" home:

  https://github.com/compudj/librseq

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
