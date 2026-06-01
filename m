Return-Path: <linux-api+bounces-6486-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +IWwMGe/HWpidQkAu9opvQ
	(envelope-from <linux-api+bounces-6486-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Mon, 01 Jun 2026 19:20:39 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ADF162331A
	for <lists+linux-api@lfdr.de>; Mon, 01 Jun 2026 19:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5E0B8300734C
	for <lists+linux-api@lfdr.de>; Mon,  1 Jun 2026 17:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C60F3DEACE;
	Mon,  1 Jun 2026 17:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="SpcAMQii"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47BBB3DDDAB
	for <linux-api@vger.kernel.org>; Mon,  1 Jun 2026 17:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780334267; cv=none; b=XUQ2aa+Iw3ZWmmvp2RY8OYINEqq2gXnw86I8x9aMz419z6Ry61earYmtu1+B62+d4TI4nUKH0AjMq7IXuBt1HmfcHAb4Z86C/2my0wpGddAgSTO5K4+Gq+H3JRgEPgAskNjwnAItp1uRvxlUnHGJfE2ZAiHR4V/if9fAixNZpaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780334267; c=relaxed/simple;
	bh=QOF4HTo9NC+sG07UWNWNGhB1bOa8fZKjrboF6NtGYig=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aaF0BypwI7J1GHN/14StBvuncIWdWiavFd//BnG5/6gv72eS3a685+TxH6U3dr/TmUcIkEMZezD0IoLK/j2Q21AD0PnxWPqlAnTmgjeg67fqqcrGOFgg5GwYRMd/2sSbaWj89nz0cAIhqilS9eO5zvJX48EdYIzviw6lJsu84qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=SpcAMQii; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-68bfcf11050so5801016a12.0
        for <linux-api@vger.kernel.org>; Mon, 01 Jun 2026 10:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1780334261; x=1780939061; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8glRJeBkbbvtPfYZZguJlBO/diWKKHW+QvqawLEed2k=;
        b=SpcAMQiiUsug+WLUvjNQ2Dw44Wr6QC2K4QDO2bm89wvYxeurSxhngg9Baquqk23/eB
         RlDPUJR2py7NMyPXxIVStD1Ng7zWCyBgmrfMSlsfgUsLaQjdeHJLdju7oXMyE127w1ov
         n7tQf6V496EhQB6n7fCJXjFXmoZfbmw9UWdSY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780334261; x=1780939061;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8glRJeBkbbvtPfYZZguJlBO/diWKKHW+QvqawLEed2k=;
        b=rVrdImbM2+EKxVcopvSQVoI55H9E5juFiDkg+3NFMqXFnlwRUGdbZm9JXDO89LCjkY
         ngxSwNGyGSFuPqy2kdGuCtt9YIyUpbqRBVuowCjeYoE1PSnQYvc4AMzpU0laVFje5uw3
         eRY5WoUDvkABrOS7rE6foyoysGPKEim+LcFHklPH8U6+1zXTiMGGd3PZqJNH+lQh0UZ8
         sm8nQCiANCCpIS7hY/empYad+B7zxpgtcuv3NEv81kuih2Z0LHTPzBUwmYTTdfnHtIgM
         nCawF4l5DFxuFKARGVsA3nCihKatCEOQo6a3e9RzTZ8cB5DbsidP7SrqxS24l5DDaC2D
         Qz3Q==
X-Forwarded-Encrypted: i=1; AFNElJ88at7qxUCZJlTMh0bqltHAu8c4ioyZRqgAOXZYPY0XDF3dON04e/jd29OllCIK27b+7P2b7OoYNC0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzzv9bv+TkUq2DW/OZK5ucN2JWml+CnWLD4K5NtLpQjBesngRyN
	QiGuyNCLRtqsVbe9dkW543kvXUloidL4q6+SZUy92qXU9qoO5xkWJQviVw+4yol12YZg87vDBDS
	d2XS7BNQ=
X-Gm-Gg: Acq92OESWxXkBSdFCaantlYmGwihFwiCsZS1h7Rd9NQR3bvzTE3w2+6y0/0klGb3L9O
	qu/bimxJm+NU6+dPbDWvV9STA/Ez6aJN70s3BVyNz0jUIqJNfw6pouAjMOIf3NucxYLEA7dyJd7
	Jk5BnTsC2FX6zrPC/kNJx9kj787tDq1KjSEf5wKKUevcvCROTgA4ZiVdGuqknkjLnl/rijpj9iH
	q7+07z3dqoKA6WKgwNOi7LXgj8cmKkug3KPPuKgQUNp2Z1BcfstIcvtotMmGIgHePLhuC/r0/KH
	mnKXjtsqKAN55Rv6q6n7EZ8ebUvbzGu8Kg9As8uUs40VIuw9UkhcH7n6mLXDJfo/QK52CS825/W
	TGhzLKo76Jp+4cSEqUEwD5EczFinKJMUqolgc2lGhRm7VoRvYO1fSFvT+c/yM7LFmYPMFvkOftq
	tZHOeg3OpfgSIRXIizky74QCuhuZqV5PmnE4hCZt3H+sOKKWlTByj37eh7TqwN5ux/m61pR9eC3
	q6VshrW/5Q=
X-Received: by 2002:a17:907:d9e:b0:bc3:b598:7f47 with SMTP id a640c23a62f3a-beab3851734mr722159766b.42.1780334261270;
        Mon, 01 Jun 2026 10:17:41 -0700 (PDT)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-beed0fc69c9sm25896366b.32.2026.06.01.10.17.40
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jun 2026 10:17:40 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-beb2a97cc9aso437336966b.2
        for <linux-api@vger.kernel.org>; Mon, 01 Jun 2026 10:17:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+M5GNigxsHQEWc1+tl+41AwoJGUrNhIbgYbriQest+YhaMZnuejyZdvUffTYNu30tlgRAFiAL2VXM=@vger.kernel.org
X-Received: by 2002:a17:906:4583:b0:bef:12f:347e with SMTP id
 a640c23a62f3a-bef012f3d6fmr16123966b.24.1780334260114; Mon, 01 Jun 2026
 10:17:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260531010107.1953702-1-safinaskar@gmail.com> <20260601-enthusiasmus-canceln-anlehnen-0e62317a9784@brauner>
In-Reply-To: <20260601-enthusiasmus-canceln-anlehnen-0e62317a9784@brauner>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 1 Jun 2026 10:17:23 -0700
X-Gmail-Original-Message-ID: <CAHk-=wifX_rrDjRGnDnOqE-usptAukuXKrmuPuVDP5bOCBWzGQ@mail.gmail.com>
X-Gm-Features: AVHnY4KexWf0o1w3H7pefWBidQ5elZSrUhqo_ATAUmEnAO4iwBaX4DnfDRLKUYk
Message-ID: <CAHk-=wifX_rrDjRGnDnOqE-usptAukuXKrmuPuVDP5bOCBWzGQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] vmsplice: make vmsplice a trivial wrapper for preadv2/pwritev2
To: Christian Brauner <brauner@kernel.org>
Cc: Askar Safin <safinaskar@gmail.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-api@vger.kernel.org, netdev@vger.kernel.org, 
	Matthew Wilcox <willy@infradead.org>, Jens Axboe <axboe@kernel.dk>, 
	Christoph Hellwig <hch@infradead.org>, David Howells <dhowells@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Pedro Falcato <pfalcato@suse.de>, Miklos Szeredi <miklos@szeredi.hu>, patches@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6486-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[linux-foundation.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,kvack.org,infradead.org,kernel.dk,redhat.com,linux-foundation.org,kernel.org,suse.de,szeredi.hu,lists.linux.dev,zeniv.linux.org.uk,suse.cz];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[torvalds@linux-foundation.org,linux-api@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid,linux-foundation.org:dkim]
X-Rspamd-Queue-Id: 2ADF162331A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 1 Jun 2026 at 09:42, Christian Brauner <brauner@kernel.org> wrote:
>
> Applied to the vfs-7.2.vmsplice branch of the vfs/vfs.git tree.

Btw, if people want to work further on this - assuming we don't get
any huge screams of pain from having effectively gotten rid of
vmsplice() - I don't think it would hurt to look at limiting the
"regular" splice() too.

We already have the code to just turn it into a pure copy on the
"splice to pipe" case: copy_splice_read(). In many ways it would be
*lovely* to just always force that path.

We already do that explicitly for DAX and O_DIRECT, but we made a lot
of special files do it implicitly too, so quite a lot of the splice
reading cases already use that "just read() into a kernel space
buffer" model for splicing.

It would be interesting to hear who would even notice if we just
always used that copy case, and made "f_op->splice_read" never trigger
at all.

And it turns out that the only thing that ever uses
"f_op->splice_write" is splice_to_socket. Which was actually the
problematic buggy case.

Everybody else pretty much seems to just use iter_file_splice_write(),
which does the "emulate it with just a write from kernel buffers".

So *if* we get rid of f_op->splice_read, we do leave the case that
really caused problems, but nobody will ever care. Because once splice
only deals with private buffers that can't be shared with anything
else, a f_op->splice_write() that gets things wrong is pretty much a
non-event.

(We'd have to look at 'tee()' too: I don't think anybody really uses
it, but it does do the "no copy linking" by just incrementing
refcounts on the pipe buffers. So to really protect against
splice_write users messing up, that should do copies too, but as long
as it's all "private ephemeral buffers" that get their refcounts
updated, I don't think anybody *really* cares)

TLDR: maybe we could ghet rid of "f_op->splice_read". *That* would be
a big simplification.

                Linus

