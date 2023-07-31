Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7DB1769F88
	for <lists+linux-api@lfdr.de>; Mon, 31 Jul 2023 19:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232017AbjGaRfj (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 31 Jul 2023 13:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjGaRfj (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 31 Jul 2023 13:35:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 831551A7;
        Mon, 31 Jul 2023 10:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lTOWnu3zwzGzxXTifAzpar25WacWZCvrAPjR7GRF9q0=; b=YKElOls1NCOo+4DlFr9uqupgpf
        7vEWbot+ei7BWq4dkDtwLfWKp+2dtn6S4r6EOefuqdwZJC85+IL0h9cl5CMve6pUz6J9gt7rhmQZF
        rfW+nTk166umsFArqx52ffgKGkb8NtHKNPQdTgY/ZOBBlL1ZN7UE9qWVRn81MJEI+lpHPKRQO1RJS
        GLITUOZGb0i0SGhGdmcnwJeF2ImMEqw3POjOqsaZdUSDvHGHSmZ//X6uRdu9qKrJmTeR8A4AEMYQR
        1RSjKVjC0vlfRHA0UFOgq556OUO195+Ib5zEtYHxRwYpTfLda6+BuE+6YpEN6rPK869Q469RVkoIW
        uqIih4TQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qQWnd-002vRm-4V; Mon, 31 Jul 2023 17:35:18 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3CE39300134;
        Mon, 31 Jul 2023 19:35:16 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id F39B1203C0B01; Mon, 31 Jul 2023 19:35:15 +0200 (CEST)
Date:   Mon, 31 Jul 2023 19:35:15 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     axboe@kernel.dk, linux-kernel@vger.kernel.org, mingo@redhat.com,
        dvhart@infradead.org, dave@stgolabs.net, andrealmeid@igalia.com,
        Andrew Morton <akpm@linux-foundation.org>, urezki@gmail.com,
        hch@infradead.org, lstoakes@gmail.com,
        Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        malteskarupke@web.de
Subject: Re: [PATCH v1 02/14] futex: Extend the FUTEX2 flags
Message-ID: <20230731173515.GP29590@hirez.programming.kicks-ass.net>
References: <20230721102237.268073801@infradead.org>
 <20230721105743.819362688@infradead.org>
 <87edkonjrk.ffs@tglx>
 <87v8e0m26q.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v8e0m26q.ffs@tglx>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Jul 31, 2023 at 07:16:29PM +0200, Thomas Gleixner wrote:
> On Mon, Jul 31 2023 at 18:11, Thomas Gleixner wrote:
> > On Fri, Jul 21 2023 at 12:22, Peter Zijlstra wrote:
> >> -#define FUTEX2_MASK (FUTEX2_32 | FUTEX2_PRIVATE)
> >> +#define FUTEX2_MASK (FUTEX2_64 | FUTEX2_PRIVATE)
> >>  
> >>  /**
> >>   * futex_parse_waitv - Parse a waitv array from userspace
> >> @@ -207,7 +207,12 @@ static int futex_parse_waitv(struct fute
> >>  		if ((aux.flags & ~FUTEX2_MASK) || aux.__reserved)
> >>  			return -EINVAL;
> >
> > With the above aux.flags with FUTEX2_32 set will result in -EINVAL. I
> > don't think that's intentional.
> 
> Also if you allow 64bit wide futexes, how is that supposed to work with
> the existing code, which clearly expects a 32bit uval throughout the
> place?

Not allowed yet, these patches only allow 8,16,32. I still need to audit
the whole futex core and do 'u32 -> unsigned long' (and everything else
that follows from that), and only when that's done can the futex2
syscalls allow FUTEX2_64 on 64bit archs.

So for now, these patches:

  - add the FUTEX2_64 flag,
  - add 'unsigned long' interface such that
    64bit can potentiall use it,
  - explicitly disallow having it set.

