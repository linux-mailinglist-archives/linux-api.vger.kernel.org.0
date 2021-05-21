Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF1F38C13D
	for <lists+linux-api@lfdr.de>; Fri, 21 May 2021 10:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbhEUIFl (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 21 May 2021 04:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbhEUIFl (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 21 May 2021 04:05:41 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA000C061574;
        Fri, 21 May 2021 01:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RDgWCR4as9+eENzKBkhKC/zFJosoat/YxaBkxON2NdE=; b=Kn3McS5avMP7Srb1l9zIfm8iGo
        T6zACjqa6GCGoxgPBv5bjYSninoWr4tk1y7aFIkWeeQ+tVMk2TkSvJIOrnguR5EFKBQmcW9hciXIl
        yOxm0czykddW036LBW74/F+HfLIoSX+R8LzIeE6oHJ2bCPI7uE8RuTWGIvtHf9l4Yr3y+mjOfHV5p
        I1Iw9Z3nrf9hi8U0WP3ggOWz6mzICxeYrRxFkEaoFJEKsqBYwmmj15uFjP7KnH8up6Sz/GlyLd1Mj
        3QRXO+jUMJaiyh5pP/7XbzidRcBXX79OjkI7oYO31H8w1FZURZo+SjSO0vh6VSzef4wl/riGVXsdS
        8Xf7msBQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lk08b-004MMw-Co; Fri, 21 May 2021 08:04:05 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6EFA330022A;
        Fri, 21 May 2021 10:04:04 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 537732C6D2B86; Fri, 21 May 2021 10:04:04 +0200 (CEST)
Date:   Fri, 21 May 2021 10:04:04 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Peter Oskolkov <posk@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>,
        Paul Turner <pjt@google.com>, Ben Segall <bsegall@google.com>,
        Peter Oskolkov <posk@posk.io>,
        Joel Fernandes <joel@joelfernandes.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrei Vagin <avagin@google.com>,
        Jim Newsome <jnewsome@torproject.org>
Subject: Re: [RFC PATCH v0.1 0/9] UMCG early preview/RFC patchset
Message-ID: <YKdpdG5j/ELa9PR6@hirez.programming.kicks-ass.net>
References: <20210520183614.1227046-1-posk@google.com>
 <87mtspm7fe.fsf@meer.lwn.net>
 <CAPNVh5eV+CtY74_JMv6_Bm5aCVBh_F9hkWLT6v3BT=H0UwodUg@mail.gmail.com>
 <c924d722-eee0-03ee-991d-c977089ecdbc@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c924d722-eee0-03ee-991d-c977089ecdbc@infradead.org>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, May 20, 2021 at 05:15:41PM -0700, Randy Dunlap wrote:

> > There is this Linux Plumbers video: https://www.youtube.com/watch?v=KXuZi9aeGTw
> > And the pdf: http://pdxplumbers.osuosl.org/2013/ocw//system/presentations/1653/original/LPC%20-%20User%20Threading.pdf
> > 
> > I did not reference them in the patchset because links to sites other
> > than kernel.org are strongly discouraged... I will definitely add a
> > documentation patch.
> 
> Certainly for links to email, we prefer to use lore.kernel.org archives.
> Are links to other sites discouraged?  If so, that's news to me.

Discouraged in so far as that when an email solely references external
resources and doesn't bother to summarize or otherwise recap the
contents in the email proper; I'll ignore the whole thing.

Basically, if I have to click a link to figure out basic information of
a patch series, the whole thing is a fail and goes into the bit bucket.

That said; I have no objection against having links, as long as they're
not used to convey the primary information that _should_ be in the
cover letter and/or changelogs.

