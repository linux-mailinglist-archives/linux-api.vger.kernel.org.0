Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 488D9BE43A
	for <lists+linux-api@lfdr.de>; Wed, 25 Sep 2019 20:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbfIYSEq (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 25 Sep 2019 14:04:46 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:41832 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726482AbfIYSEq (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 25 Sep 2019 14:04:46 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iDBe8-0006bq-19; Wed, 25 Sep 2019 18:04:12 +0000
Date:   Wed, 25 Sep 2019 19:04:12 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Aleksa Sarai <cyphar@cyphar.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        GNU C Library <libc-alpha@sourceware.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 1/4] lib: introduce copy_struct_from_user() helper
Message-ID: <20190925180412.GK26530@ZenIV.linux.org.uk>
References: <20190925165915.8135-1-cyphar@cyphar.com>
 <20190925165915.8135-2-cyphar@cyphar.com>
 <CAHk-=wjFeNjhtUxQ8npmXORz5RLQU7B_3wD=45eug1+MXnuYvA@mail.gmail.com>
 <20190925172049.skm6ohnnxpofdkzv@yavin>
 <CAHk-=wjagt257WHiOr2v1Bx_3q7tuzogabw_1EnodKm0vt+-WQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjagt257WHiOr2v1Bx_3q7tuzogabw_1EnodKm0vt+-WQ@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Sep 25, 2019 at 10:48:31AM -0700, Linus Torvalds wrote:
> On Wed, Sep 25, 2019 at 10:21 AM Aleksa Sarai <cyphar@cyphar.com> wrote:
> >
> > Just to make sure I understand, the following diff would this solve the
> > problem? If so, I'll apply it, and re-send in a few hours.
> 
> Actually, looking at it more, it's still buggy.
> 
> That final "size smaller than unsigned long" doesn't correctly handle
> the case of (say) a single byte in the middle of a 8-byte word.
> 
> So you need to do something like this:
> 
>     int is_zeroed_user(const void __user *from, size_t size)
>   {
>         unsigned long val, mask, align;
> 
>         if (unlikely(!size))
>                 return true;
> 
>         if (!user_access_begin(from, size))
>                 return -EFAULT;
> 
>         align = (uintptr_t) from % sizeof(unsigned long);
>         from -= align;
>         size += align;
> 
>         mask = ~aligned_byte_mask(align);
> 
>         while (size >= sizeof(unsigned long)) {
>                 unsafe_get_user(val, (unsigned long __user *) from, err_fault);
>                 val &= mask;
>                 if (unlikely(val))
>                         goto done;
>                 mask = ~0ul;
>                 from += sizeof(unsigned long);
>                 size -= sizeof(unsigned long);
>         }
> 
>         if (size) {
>                 /* (@from + @size) is unaligned. */
>                 unsafe_get_user(val, (unsigned long __user *) from, err_fault);
>                 mask &= aligned_byte_mask(size);
>                 val &= mask;
>         }

IMO it's better to lift reading the first word out of the loop, like this:

	align = (uintptr_t) from % sizeof(unsigned long);
	from -= align;

	unsafe_get_user(val, (unsigned long __user *) from, err_fault);
	if (align) {
		size += align;
		val &= ~aligned_byte_mask(align);
	}

	while (size > sizeof(unsigned long)) {
		if (unlikely(val))
			goto done;
		from += sizeof(unsigned long);
		size -= sizeof(unsigned long);
		unsafe_get_user(val, (unsigned long __user *) from, err_fault);
	}

	if (size != size(unsigned long))
		val &= aligned_byte_mask(size);
done:

Do you see any problems with that variant?
