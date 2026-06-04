Return-Path: <linux-api+bounces-6530-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id L0K0IxjbIGoj8gAAu9opvQ
	(envelope-from <linux-api+bounces-6530-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Thu, 04 Jun 2026 03:55:36 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E3CDC63C4E6
	for <lists+linux-api@lfdr.de>; Thu, 04 Jun 2026 03:55:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux-foundation.org header.s=google header.b=ZCyHWoya;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6530-lists+linux-api=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-api+bounces-6530-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A22D03027948
	for <lists+linux-api@lfdr.de>; Thu,  4 Jun 2026 01:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CEA828DB49;
	Thu,  4 Jun 2026 01:52:37 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3E5239085
	for <linux-api@vger.kernel.org>; Thu,  4 Jun 2026 01:52:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780537956; cv=none; b=m16RMxX2qrYLpB1yiAOUC0SRK/LoBsrgCN3w0oBC9A4N329lyj3hH/FZn2iWT1S0GnirCbG+yDWJsXb7f2qT9mrnsnqaXONDO1fvfovpOJXQQRp/63BNZGP9EbFWJnCEqwIYwZ9fqJfTel/E4fn8P820BJlRcjx+b62HSLYK/oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780537956; c=relaxed/simple;
	bh=n1SkdCcNZQRg1IgD5sSmDSj8j+GpuHeY4/Td660VL9M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TwqrE80k5nUEZAWONyqkevxhXtQz1V0h4X3rnCYGgZiLvx/xFExwJLtjYn21RS/RIOXHoNhFZ1aXmxbh3gEO6CdOybQ8AZqQCWaux49vfWgXtsK6SwbT6Nd4htkXwOGdZlz4blC1UbMSftSUhxXTzh3X9GC4kvL/8tUr0/Dp0h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ZCyHWoya; arc=none smtp.client-ip=209.85.208.53
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-68ca6f01079so134933a12.0
        for <linux-api@vger.kernel.org>; Wed, 03 Jun 2026 18:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1780537954; x=1781142754; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ti3H/yNlOCN9jiz2PA4OGwlivuSMT91KkxAffb1eRD4=;
        b=ZCyHWoyagQn4jEw8+2BqwvYDxEsb3NKp8UQt5a7vjIM7b49dA31y5YQ6nLrvmLkxwk
         m2U87KFya7eSVerBTp1zyFzoBLbCQbyWNqE+Q2NVnA6lCr+jbohqhEDvR2usn7lNca7N
         tN290XPLwVYPJOb55/oaR6T/LJe5GhmDWXZco=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780537954; x=1781142754;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ti3H/yNlOCN9jiz2PA4OGwlivuSMT91KkxAffb1eRD4=;
        b=L5qiS167nBy2+UsEeWaP7cqkOdg+SlH7Vpw2uZwwV06EOLV8gev30mgNzatSLK6QZ2
         K29E5Y3h+Yum7psTPkAsO2o9jH2IcOW2q1leEfJ2rzXYP/B1HrHvjtA/lbSAZuqxerpM
         3o3ngN3LAF1DoRsY8P6J6ZUVzQiNhhSahm7LBcAABNsWEqZJHoDNsdkIrDgs15bC788p
         YQOhlTB7qNE7s4ekJvf0uXL5fPOk9Wr5XLPv8u9oUbVeldkd+xuoYQRB0ZiJR+cayIez
         Sl4iAqqkcvS2wewiLwlqeIC9F0rds82oLRy8epxBTXq/8rV1Ps4wB0+xomsGpSqZrQrj
         YROA==
X-Forwarded-Encrypted: i=1; AFNElJ/gCdv4mV15F3/GVS+/7UriDBAO3pi8oVT/9IZSdHwM+88r7K85mW4znmIevHMJuKh3uRW/zwJk1aI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoihIM1mRYBiMfZuNltQdMPu+A4uJSEJqm5GEEbVhZJxi20yyr
	y6VZ3w1MJmyTSUQEnnKuJP/0+I+vv7V5JT/34zSfc3uvUv+gD14n4Gd/wLqoPcrRTo6C1qZEnPt
	pncIb3P2Gbg==
X-Gm-Gg: Acq92OHoPhFXwX+OARO/5IN5l0BFj5ojzO92g3zSBj7oo3oyyROoTzfS/8dy1BIQ9j7
	OE2AJz6SPG2eIGvxHZFGWnuXpeRO1THo0+mAJEi1Tvwk/x82QQ9fqZw97UQVAYqO5S13DQOKZQ+
	fIP9sy4UuIgIUwExO3ByQm8o/5nNYyIaE/AtgEXL6V+wOiBUyuzBR0tqqQHc/wmjvQFNAfcKcno
	jYkQcW0i32t5pEba/5FN+UeBObTBcby5WAUeR1/gvCwe2FovJAnt+NGtR+DEd1l9LeGzZh2uhXa
	WFFPKW1JLY0NhT2AzfGlT4b9K4jYsRcZ2crkTKGeZJCKXEc/Htjp9jrPx1Np3uRSW/11EYktm59
	ohP5L/wkIY7Qu+DZ78ukOc1v8/5IebIAwP0HfDcHx5JWLkAuMdsPsk+FMuEMsd04qf27H9psQDj
	E01aId4vBAitlF2p70zoDJH9U2JlYMUD5udkNbtLpsRAYREL4M+bivuLL/vEv5U2EH9Z/YUZQmJ
	uC4QAUUEywIFubnf1PKkQ==
X-Received: by 2002:a17:907:3d90:b0:bed:38b8:9b4b with SMTP id a640c23a62f3a-bf0ae3ff64dmr310309666b.27.1780537953705;
        Wed, 03 Jun 2026 18:52:33 -0700 (PDT)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf055307a35sm230614366b.52.2026.06.03.18.52.32
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2026 18:52:33 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6886be3d39bso170460a12.3
        for <linux-api@vger.kernel.org>; Wed, 03 Jun 2026 18:52:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+19sobR0ka/JRuBZRDqa8B1jcNAE4dynp9bOnQvHj6BoYJz1MXq7uxZ/qwhbrMebRjqjUwX0Q7PA0=@vger.kernel.org
X-Received: by 2002:a05:6402:550a:b0:66d:d2f9:520c with SMTP id
 4fb4d7f45d1cf-68e72250122mr2844444a12.19.1780537952777; Wed, 03 Jun 2026
 18:52:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260531010107.1953702-1-safinaskar@gmail.com> <20260604004559.1112474-1-safinaskar@gmail.com>
In-Reply-To: <20260604004559.1112474-1-safinaskar@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 3 Jun 2026 18:52:15 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgPzxQL9Bdze=qnSa5v8A2D6cPaU0Bi=j4N38+ja1NkzQ@mail.gmail.com>
X-Gm-Features: AVHnY4Ia6Rugs2gzhFv567LCSFsgwGvMvJbpyqp7BVsPOVMqNGKAIqxMQwoy6bY
Message-ID: <CAHk-=wgPzxQL9Bdze=qnSa5v8A2D6cPaU0Bi=j4N38+ja1NkzQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] vmsplice: make vmsplice a trivial wrapper for preadv2/pwritev2
To: Askar Safin <safinaskar@gmail.com>
Cc: akpm@linux-foundation.org, axboe@kernel.dk, brauner@kernel.org, 
	david@kernel.org, dhowells@redhat.com, hch@infradead.org, jack@suse.cz, 
	linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, miklos@szeredi.hu, 
	netdev@vger.kernel.org, patches@lists.linux.dev, pfalcato@suse.de, 
	viro@zeniv.linux.org.uk, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:safinaskar@gmail.com,m:akpm@linux-foundation.org,m:axboe@kernel.dk,m:brauner@kernel.org,m:david@kernel.org,m:dhowells@redhat.com,m:hch@infradead.org,m:jack@suse.cz,m:linux-api@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:miklos@szeredi.hu,m:netdev@vger.kernel.org,m:patches@lists.linux.dev,m:pfalcato@suse.de,m:viro@zeniv.linux.org.uk,m:willy@infradead.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[linux-foundation.org];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[torvalds@linux-foundation.org,linux-api@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-6530-lists,linux-api=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[torvalds@linux-foundation.org,linux-api@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,linux-foundation.org:from_mime,linux-foundation.org:dkim,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E3CDC63C4E6

On Wed, 3 Jun 2026 at 17:46, Askar Safin <safinaskar@gmail.com> wrote:
>
> For example, in vmsplice I do "CLASS(fd, f)(fd)" and then I pass
> "fd" (i. e. integer) to "do_writev/do_readv". I don't know whether
> this is okay to do so.

Oh, good point.

It's ok in the sense that it will work, and it's not really going to
cause problems, but it does mean that the 'struct file' will be looked
up twice.

And *technically* it's a TOCTOU race, where the first time you look it
up - in the vmsplice() wrapper - it could be one file, and you make
decisions based on that. And then pass it off to do_writev(), and it
will look it up again, and now it might be a different file.

Does it *matter*? No. Even if the file changed, and is now something
else, it's just going to be a different file that the user does
writev() on. do_writev() will still do all the appropriate safety
checks etc, so it doesn't really change anything. It just means that
you could pass what you *think* is a pipe (because you did that

+       if (!get_pipe_info(fd_file(f), /* for_splice = */ false))
+               return -EBADF;

and by the time do_writev() then looks up the fd again it might be
something else, and now the user used vmsplice() as a really odd way
to write to a another non-pipe file instead. But the user could have
done that with a regular writev(), so it's just the user being silly -
not something that really confuses the kernel.

Coimpletely harmless, in other words.

But it would probably be *cleaner* to pass in the 'struct file *'
pointer that you already looked up once instead, and use vfs_writev()
instead of do_writev().

And I do suspect that the wrapper system call should use the same

   SYSCALL_DEFINE4(vmsplice, int, fd, ..

that the original used. Because it somebody crazy had the high bits
set in 'fd', the old vmsplice() system call didn't care, but your new
emulation system call will actually see the high bits on a 64-bit
architecture.

Again - that doesn't actually *matter*, because "CLASS(fd)" takes an
"int fd" and those high bits will be masked out at use time both in
vmsplice() and in do_readv/writev().

So it won't affect any behavior, but it does look a bit odd in the conversion.

And I already answered Christian wrt the change in behavior: I think
RWF_NOWAIT should always be set on the writing side - because splice()
never waited after it filled a pipe - and instead that
SPLICE_F_NONBLOCK flag should be used before write to check for
whether we'll wait *before* doing the write like it used to do with

        ret = wait_for_space(pipe, flags);

in vmsplice_to_pipe().

(On the other side, vmsplice_from_pipe() used to do
pipe_clear_nowait(), but I think that becomes a non-issue with the
conversion to readv()).

And once you need wait_for_space(), that probably means that the new
vmsplice() wrapper simpler needs to remain inside fs/splice.c, and we
just need to make vfs_readv/vfs_writev non-static.

              Linus

