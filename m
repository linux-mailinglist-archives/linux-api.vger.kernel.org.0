Return-Path: <linux-api+bounces-6540-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id w3bvJ8u2IWrwMAEAu9opvQ
	(envelope-from <linux-api+bounces-6540-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Thu, 04 Jun 2026 19:32:59 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 10477642512
	for <lists+linux-api@lfdr.de>; Thu, 04 Jun 2026 19:32:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amacapital-net.20251104.gappssmtp.com header.s=20251104 header.b=pc+Wnp0p;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6540-lists+linux-api=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-api+bounces-6540-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 15D3C308D6BD
	for <lists+linux-api@lfdr.de>; Thu,  4 Jun 2026 17:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB1744C6EFF;
	Thu,  4 Jun 2026 17:26:10 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104454BCAB5
	for <linux-api@vger.kernel.org>; Thu,  4 Jun 2026 17:26:08 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780593970; cv=pass; b=jZXWDc61Z7pPjMCcCLzQesY63FS6VluTeOa+zEoLhlQqTn6eaawdYx4+vT1IK1DKt8WQB916uCr1HpKr7Z8EvafL+LDvCyLarmifnjjpt0Hw0vvntewfgTlkZKLzMxdo+8ZY2ZU9Y2hnh3A1RojrrFabXr3l/s/+HkPRLLng08M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780593970; c=relaxed/simple;
	bh=Go/9hYcTJsTk00KMpiEauqrMUG2V1Ijgh9IZbgopL4c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U7AtM26DtxSto9I7XGOEwySCLBhcRayVpHfKEH2JB/dNWCLuKbH9/7QmBB3/DovmXjKGs4JqEpOjbduC5LCz2mCMwGkPh9n0ZbhbRSPIDVS1cfln7GvQPQbLskje8KTCfLD7THFOE3viifyr0lghBiaGHZDGngy1ez9YjAf7bRM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net; spf=pass smtp.mailfrom=amacapital.net; dkim=pass (2048-bit key) header.d=amacapital-net.20251104.gappssmtp.com header.i=@amacapital-net.20251104.gappssmtp.com header.b=pc+Wnp0p; arc=pass smtp.client-ip=209.85.208.178
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-39676d82b7fso10235441fa.0
        for <linux-api@vger.kernel.org>; Thu, 04 Jun 2026 10:26:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780593967; cv=none;
        d=google.com; s=arc-20240605;
        b=hT54IN0FoSfmVemcgi+NKekmO7aoobooGvGw3S+0y6DaCwhn3eJKDPqd+S7dTRRbwa
         VFsKYzUuHKjITqHJgw/lghi/uJgR2D/8gpq7YsfRu56csxdgfgg3qUVUk1Bjab5uTn7q
         LTiBYrBJeSgIGxHF6N/9ZkRtEb1ruT0UCB7gQZeDSlXDkSBBm90YkCJdXNNkcW3IL4HV
         v+JCbD76innTnUwEBIuwy2llmNdZhR9IgZc2Vh2+VH6fdobPqMlRIjPOCsWDJXP3FR6d
         SwQTLK3WY8woYQjCWAD006ttKZBhAF4YOkIvP8gAbfPl8mZcNy82qxDMeEOMA+x+aotC
         BF7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=D2Ypl5piwY28pT58DbtYmX3qX3B63YsIgDUM1eIk9WU=;
        fh=lP+TqlaLAVMbX5o6oylVx0yQiJ1L0DwbbQsqxuWAPss=;
        b=GhfKGSadggXVuQbHvVpq8iTfhk357eg/pIhlVKVm1ltgVDrV8Hk2VChFjqKUOwEHKN
         4GGC6u9Vru0vIY7XuuVA1oDsawWT+qDzkfJIrwXRjJJ8LCgYGeNQV2MRGQTgbW26w9WO
         PKXpLLExUJQMzXGfwNPKBgbYP49XDFovpVXgV1psyfZWCTAfQYj7U4hs4BXn6neuEQW1
         xkjzrPB1FI25Vl+e7pg5+YxK/r92eat6PRlTK5JKlhN9WzXpgGVzEPhftHkkFNmat1CR
         Cx45b6zVuF3KcmifMAkNJgG/slPmAHgbj+qbwl3PFbGcYf71PdRFl1FXcsQJ6K/ZLUd4
         oCZQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20251104.gappssmtp.com; s=20251104; t=1780593967; x=1781198767; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D2Ypl5piwY28pT58DbtYmX3qX3B63YsIgDUM1eIk9WU=;
        b=pc+Wnp0p6kW/80Djax9neBwdMNPiVsExiI3Ofw4GjI1RdXZL4WFaHSR8/G5T98KSSg
         V7fQ/Tt/b+zMLuhOfP1WSfknAjOyP+8CCaXkLfrfGzYVBpZATX6C41QNukgzafe2f7kR
         wAGYA7p1ocgghhs32kmqnrtug6dk9TS7QN/za9gtVhf2NqTr83oDFVolLB+LQqDofmCe
         UIargN8YqLWLrUtkcIb/258MnLPvKshFSDEUs9GK7/nbA0NStTwnc85M+oGbfXP3q8oU
         TtPCVVOXGn752BEaxNjvBhg61LhsA0iW8QHBTjU1ZIkAp/E0gZMrQh0MPR25/9cv1A3U
         oVqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780593967; x=1781198767;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=D2Ypl5piwY28pT58DbtYmX3qX3B63YsIgDUM1eIk9WU=;
        b=IsWm+E9GphdSm69JH05I8guj/YmLoaB3joUHhgN85y3YzipuMlUv1TYXB/S8eI3LNQ
         ElI307f2T2Drk0f1Dkudn2WqrBCqnyxUwOY748j+9VRBd/BbadgepJYyKWBRICooLaqU
         6KJy37FVL8lduIm+JOmyteaVypLKrKYj2xO8TYCFoURXkAFSfRMLxQdI/cXoJ0jGcwsU
         fG0jQ4A4AJ+YYhtXV+iv4XF20sjUSuoqigKLMPSJiKN4+JDu40fgbqZzF3XkEJOYn/bW
         A7VsxPPGcf2A2H7EAK3zYD9QAqXiRz2pmQcd9CO7xBMdbIU2hYW2m0lafJAbk7XxRbzS
         xaQA==
X-Forwarded-Encrypted: i=1; AFNElJ8VvZNhc9ar6c3HU95Hi0U56qidn/YsPaSGgKJ1ZaYPbX0M6t6uaQNaXihsdQmpHSQvsd5/D0cdbmQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNenZZwPU8ZVhgPzBeDXj5iKnilcvjqyPxA0pjDtpLCUnOp5/X
	Ku3uK9uBMcLSFNfEMtA+eQp3g1/eRmAT2oT9d5jn5nx+HmAPOdKED00gRRnvafgnQ/CEHXdLyXL
	51SoSRwQhIQ/oNWpjUFBm9ZHU6lCY+4jxI2TP7DZC
X-Gm-Gg: Acq92OGJfa4U7OGKq+ICltBEbvAMjljCRE6JO1EcmrpuVbtdKykDjbZ7YuZRqrhs6Q5
	NtS4zYdlcboh/w6SsnQb16MoXnAyrIu4w5sHkIGy3/6X5qJqQinN5Og/KihjMNPhXkewb915vMa
	ohpvKT7qYVWFk/ziQ+m5Jcvarx4uuNRWYvSX8NKwfZIQU+cWeC2fCoOScjMAF9hDFyDiDq5zo0O
	BdcxM8Ej/p+W/o+N0yrwWhMMQS9Qhg8/iwXE0TMnyCEGJwzzrMD7OMW9+Kaxxc6rQCuLcZhRjKl
	wq/3lQot4dUsFSA=
X-Received: by 2002:a2e:bc0f:0:b0:396:7fcc:6864 with SMTP id
 38308e7fff4ca-396af184c47mr26680891fa.11.1780593967025; Thu, 04 Jun 2026
 10:26:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260531010107.1953702-1-safinaskar@gmail.com>
 <20260601-enthusiasmus-canceln-anlehnen-0e62317a9784@brauner>
 <CAHk-=wifX_rrDjRGnDnOqE-usptAukuXKrmuPuVDP5bOCBWzGQ@mail.gmail.com>
 <20260601173325.GH2636677@ZenIV> <20260601160455.2c187574@gandalf.local.home>
 <20260601172825.a51a588ec1c32617a0e12d78@linux-foundation.org>
 <aiEb8CTM-ovMIq7-@1wt.eu> <CALCETrULMixRGJyGqAAujW7RN6PP2f_Orn2Y_0hpPMjRqQnY7Q@mail.gmail.com>
 <aiGjUqI59e966oBu@1wt.eu>
In-Reply-To: <aiGjUqI59e966oBu@1wt.eu>
From: Andy Lutomirski <luto@amacapital.net>
Date: Thu, 4 Jun 2026 10:25:55 -0700
X-Gm-Features: AVVi8CcvIM4HOiXbU2YWmKHDS7Pmkfl5RMnbxKamS5RAB8P23IrY-5hOK2SZPKo
Message-ID: <CALCETrX=DzbbG_ns2Y1A83F_Vpd8NQqZfKr4nUkteGgOLrkngA@mail.gmail.com>
Subject: Re: [PATCH 0/3] vmsplice: make vmsplice a trivial wrapper for preadv2/pwritev2
To: Willy Tarreau <w@1wt.eu>
Cc: Andrew Morton <akpm@linux-foundation.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Christian Brauner <brauner@kernel.org>, Askar Safin <safinaskar@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-api@vger.kernel.org, netdev@vger.kernel.org, 
	Matthew Wilcox <willy@infradead.org>, Jens Axboe <axboe@kernel.dk>, 
	Christoph Hellwig <hch@infradead.org>, David Howells <dhowells@redhat.com>, 
	David Hildenbrand <david@kernel.org>, Pedro Falcato <pfalcato@suse.de>, Miklos Szeredi <miklos@szeredi.hu>, 
	patches@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[amacapital-net.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:w@1wt.eu,m:akpm@linux-foundation.org,m:rostedt@goodmis.org,m:viro@zeniv.linux.org.uk,m:torvalds@linux-foundation.org,m:brauner@kernel.org,m:safinaskar@gmail.com,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:linux-api@vger.kernel.org,m:netdev@vger.kernel.org,m:willy@infradead.org,m:axboe@kernel.dk,m:hch@infradead.org,m:dhowells@redhat.com,m:david@kernel.org,m:pfalcato@suse.de,m:miklos@szeredi.hu,m:patches@lists.linux.dev,m:linux-fsdevel@vger.kernel.org,m:jack@suse.cz,s:lists@lfdr.de];
	DMARC_NA(0.00)[amacapital.net];
	FORGED_SENDER(0.00)[luto@amacapital.net,linux-api@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-6540-lists,linux-api=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[amacapital-net.20251104.gappssmtp.com:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luto@amacapital.net,linux-api@vger.kernel.org];
	FREEMAIL_CC(0.00)[linux-foundation.org,goodmis.org,zeniv.linux.org.uk,kernel.org,gmail.com,vger.kernel.org,kvack.org,infradead.org,kernel.dk,redhat.com,suse.de,szeredi.hu,lists.linux.dev,suse.cz];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-api];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,1wt.eu:email,amacapital-net.20251104.gappssmtp.com:dkim,linux.org.uk:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 10477642512

On Thu, Jun 4, 2026 at 9:09=E2=80=AFAM Willy Tarreau <w@1wt.eu> wrote:
>
> On Thu, Jun 04, 2026 at 08:53:15AM -0700, Andy Lutomirski wrote:
> > On Wed, Jun 3, 2026 at 11:32 PM Willy Tarreau <w@1wt.eu> wrote:
> > >
> > > On Mon, Jun 01, 2026 at 05:28:25PM -0700, Andrew Morton wrote:
> > > > On Mon, 1 Jun 2026 16:04:55 -0400 Steven Rostedt <rostedt@goodmis.o=
rg> wrote:
> > > >
> > > > > On Mon, 1 Jun 2026 18:33:25 +0100
> > > > > Al Viro <viro@zeniv.linux.org.uk> wrote:
> > > > >
> > > > > > On Mon, Jun 01, 2026 at 10:17:23AM -0700, Linus Torvalds wrote:
> > > > > >
> > > > > > > TLDR: maybe we could ghet rid of "f_op->splice_read". *That* =
would be
> > > > > > > a big simplification.
> > > > > >
> > > > > > FUSE might be interesting - fuse_dev_splice_read() and its ilk.
> > > > > > Communications between the kernel and fuse server at least used=
 to
> > > > > > seriously want that, so that would be one place to look for unh=
appy
> > > > > > userland...
> > > > > >
> > > > > > splice-related logics in fs/fuse/dev.c is interesting; another =
place
> > > > > > like this is kernel/trace/, but I'm less familiar with that one=
.
> > > > > >
> > > > > > rostedt Cc'd (miklos already had been)
> > > > >
> > > > > Thanks for the Cc. The tracing ring buffer was specifically made =
to be used
> > > > > by splice and the libtracefs has a lot of code to use it as well.=
 As
> > > > > reading the ring buffer literally swaps out the write portion wit=
h a blank
> > > > > read portion, that portion (sub-buffer) is used to be directly fe=
d into
> > > > > splice, providing a zero-copy of the trace data from the write of=
 the event
> > > > > to going into a file.
> > > > >
> > > > > trace-cmd defaults to using splice to copy the tracing ring buffe=
r directly
> > > > > into files to avoid as much copying during live recordings as pos=
sible.
> > > > >
> > > > > Whatever changes we make, I would like to make sure there's no re=
gressions
> > > > > in performance of trace-cmd record.
> > > >
> > > > Well yes, The patchset seems sensible from a quality POV.  But to m=
ake
> > > > a decision we should first have a decent understanding of its downs=
ide
> > > > impact.
> > > >
> > > > I haven't seen a description of that impact in the discussion thus =
far.
> > > > And that description is owed, please.
> > > >
> > > > I assume a small number of specialized applications are using
> > > > vmsplice() to great effect?  What are those applications?  What is =
the
> > > > impact of this change?
> > >
> > > > Once we are armed with that information, is there some middle groun=
d in
> > > > which we de-feature vmsplice()?  Fall back to pread/pwrite in the
> > > > tricky cases and still permit vmsplicing if the application is
> > > > appropriately restrictive in it usage?
> > >
> > > I'm using vmsplice() + tee() + splice() in high-performance applicati=
ons,
> > > load generators to be precise, and soon a cache. This is super conven=
ient
> > > and extremely efficient:
> > >
> > >   - vmsplice() is used to prepare a "master" pipe with data to be sen=
t
> > >     over TCP or kTLS
> > >   - then for each request, we do tee() from this master pipe to per-r=
equest
> > >     pipes.
> > >   - the per-request pipes are those that are used to deliver the data=
 to
> > >     the socket via splice().
> > >
> > > So we effectively use vmsplice(), tee() and splice() here, and for ex=
actly
> > > the reasons they were designed: only play with page refcount and not =
copy
> > > data. The code is here for the curious:
> > >
> > >    https://git.haproxy.org/?p=3Dhaproxy.git;a=3Dblob;f=3Dsrc/haterm.c
> > >
> > > and its ancestor is here:
> > >
> > >    https://github.com/wtarreau/httpterm/blob/master/httpterm.c
> > >
> > > It simply doubles the network bandwidth compared to not using that.
> > > (62 Gbps per core vs 31). I would seriously miss it if I couldn't use
> > > this anymore.
> > >
> >
> > Wait a moment.  This is neat, but it's literally just a benchmark,
> > right?
>
> No, it's a benchmark *tool*: it's being used to stress production code,
> which is important and super hard at high loads. You place it after your
> proxy and you measure the performance of the proxy (which is supposed not
> to be as capable as the testing tools otherwise the methodology revolves
> to testing the testing tools, which is not the point).
>
> > I skimmed the code, and it doesn't look like a production
> > workload, either.  And you manage to get around the awfulness of the
> > vmsplice API's complete failure to tell you when it's done with a
> > buffer by ... never actually changing the contents of the buffer.  Do
> > you have any idea how you would write correct code that uses vmsplice
> > for sends and then *ever* mutates the data without literally
> > munmapping (or madvise or something) the data do you can safely mutate
> > it?
>
> I'm not sure what you mean here Andy. I *do not* need to change the
> data, it's just a pre-made pattern.

What I mean is: this particular pattern seems limited for use in an
actual webserver as a opposed to a load-tester.

> > Or discover that we already have something better, perhaps :)
> >
> > https://man7.org/linux/man-pages/man3/io_uring_prep_send_zc.3.html
>
> io_uring is different. We tried it "the dirty way" in the past, by
> emulating a poller, and it's not worth it this way. And in order to
> do it the right way, it needs to be done totally differently, which
> has impacts all over the stack. The code in the file pointed to above
> is just for the httpterm testing feature, but the rest is much more
> complex.

I'm curious how this kludge does:

https://github.com/amluto/zc_bench

I vibe-coded this up without much care, and I don't have the hardware
needed to actually run it in an interesting manner.  But, on a Linux
VM on an Apple M4, I can push about 130Gbps on a single core over
loopback.  In theory this will do zerocopy sends (but not over
loopback), and I would hope that it runs *faster* than vmsplice + tee.

(I have a fancy workstation that can do a whopping 2.5Gbps.  I could
probably jury-rig a test over Thunderbolt at higher speeds.  I have
systems that are not available for this test right now that can do
10Gbps.  But someone probably needs 40Gbps or better hardware for a
genuinely interesting test.)

--=20
Andy Lutomirski
AMA Capital Management, LLC

