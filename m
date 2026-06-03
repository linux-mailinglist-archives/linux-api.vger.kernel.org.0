Return-Path: <linux-api+bounces-6519-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SXN8Ek+dIGoz5wAAu9opvQ
	(envelope-from <linux-api+bounces-6519-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Wed, 03 Jun 2026 23:31:59 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C1D5E63B655
	for <lists+linux-api@lfdr.de>; Wed, 03 Jun 2026 23:31:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amacapital-net.20251104.gappssmtp.com header.s=20251104 header.b=JXSpeC88;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6519-lists+linux-api=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-api+bounces-6519-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 191353021258
	for <lists+linux-api@lfdr.de>; Wed,  3 Jun 2026 21:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC3E4968F2;
	Wed,  3 Jun 2026 21:31:56 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29ECD37189C
	for <linux-api@vger.kernel.org>; Wed,  3 Jun 2026 21:31:53 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780522316; cv=pass; b=Vhb/xu1KiPWVtSzeSCMsro7XbeIrNbn0ljt0gaq9E75qscY6gZrf93249eyshCDXV+4sZQV+LBacpFF2vvTyOgzpztZvcNz3/itfD/OAZolLij2PDlFF3VIpY1m2FREME13LRKAlPri1ZFG8DJMuGfxncGZJ543HDxI3hJIz9b4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780522316; c=relaxed/simple;
	bh=NAfifc52uhBVXwuP3W/flWSVRj5fkupSNdXoG/ZGuU0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WdYIX2MTiRieHeJFL1J5XbvP2xLaItHUp3Y6qcV0qOo7qh6maw1nvR3c+ritpje3lDc3nD0CVzZSCwEOqS19CiNH4ywoJ18YU8r7Zp1WbM1lFxi8AfvFky4EkLBxzfcY245ueJT5/HakJIIO/e7XdMZpk2Q7Lsw6pZQy27nsdWI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net; spf=pass smtp.mailfrom=amacapital.net; dkim=pass (2048-bit key) header.d=amacapital-net.20251104.gappssmtp.com header.i=@amacapital-net.20251104.gappssmtp.com header.b=JXSpeC88; arc=pass smtp.client-ip=209.85.167.42
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5aa5be9ab1aso6021828e87.1
        for <linux-api@vger.kernel.org>; Wed, 03 Jun 2026 14:31:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780522312; cv=none;
        d=google.com; s=arc-20240605;
        b=c6sskrLSVGi42be13enVgIEKo4OuHEjxcuRpHQURB+DUdIOgrZZplRn2XIyhRW+uCV
         ZFHhjwmWvDWybGTPU5TZwmTL1t2t0MgOVKP6hTt2o+CqhCBgos0slOe+3+RFyf/Owsyt
         wYDjYlniYbw0mgq5sp6H3lvRIxzosbES44km2t3EPJ/TinxBlIjW1UWgMOt6Ci4BVLzm
         3AXy7VxxOM9smA3FRlTyxOlLYMg0iRFHMJadrj/LrkEuWPEKD9qUOxu9Ts907kaZh13Y
         NVo4JmvuFt8wL6AXlmb3Y4shVSsmpzaTGzsLICQw6ZWH1rwo3787VkooJY/Os/4Xu2Wa
         lVXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Q5iqrCHjutj+wP2G1wPc50Z6+aExdn36Rac6q6pqNP8=;
        fh=PzsPBqTA99vITTyptDtpZOC47+WXG/KVbOeKy5kSayA=;
        b=djExEbKbxYMWKKLZ9rZC3tpNTUkZgVqu2Rla3aGi93APkZ90K9f397RIrNNaACHk1c
         /MCRN6qbzNwqRw+OKJothY5c3WsUZ8gsD++QBy5TJJcVZMlaL4wA/bEu/8AiRX7glXR4
         jZlllvbl8jX5ExC6iidbluQZVyKtM2tAr5GVb/RsDeYNXLHoThgTRCFu9EzpgkcyicOk
         bQxBjd9gh46mcM/Bj5nhafSzEJJ9rQnpoikIorIZuQmLYkzUHxySCrrOjCj+JNk7xr4Z
         wNP24XsrS6Koh+u2EGA520JjcT6zvEIWPFRjW9+hlomX308oeq/Irnyh63u8YDxEukFU
         Cieg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20251104.gappssmtp.com; s=20251104; t=1780522312; x=1781127112; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q5iqrCHjutj+wP2G1wPc50Z6+aExdn36Rac6q6pqNP8=;
        b=JXSpeC88DCzpIYBTZmaB4UGGZsK22FOhzdRXvUA31bsKwgf+fo3cT9lQKMc4Qahj4y
         S5pQekdR6hAnnr9YYrt+8cwIcP3mcAo0ZrF1JCA7H7XfU0lUHipKoj5IZaSFhnSEZnLD
         3921bwBeS0o8MULW7TG7QvwopEPGsT5Lf51WmE9f2dyYmbbBcV8cVlvj9L8hmulBidw3
         ATzvYun0sfcZGjV7EgpaFsjfAi4tVE9DaRCUTxxo7tDbvSMyA7Ru5Mp9nv1XS7kYQcnI
         8OQF4obm8JAueSIqNpkn1MwbQoeaOTHlpiE/0wVssO+PQUN/3uR5WS7527DuesH1JvMk
         6l3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780522312; x=1781127112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q5iqrCHjutj+wP2G1wPc50Z6+aExdn36Rac6q6pqNP8=;
        b=Il4Uq9Tzui71btUMSMBNrgybZmHIhGisbfRFuM+eNkA8XVsi+VfLE6t4gmWF4QKvJ8
         ddeapDbtczA3L/l/KhN/FtPeqRDS4w0iOuQlrnOC1qoMtEzWhgED///lfdgo2V2/1Nsz
         5YrSk/77wv30TOKIjPWNVtuTBMNeLWUjiEoknelM+c7QG4Ps3yF8hJyaXpT1fff0RNta
         eOqW4HvRs8Fs1R9ZgrVir1817RszRE+OumUX+UII4G1G1a3macXSLs3m4yz4Oi5ialoB
         fB8QmzyDE6lkE5PQMx5Bove8l3g06eXnzUU0jUaKhiXlODSXlOrg17uHEUz52qzCvBxj
         d6dw==
X-Forwarded-Encrypted: i=1; AFNElJ+o5h3/KH+EvrkbWS/zqLP6t6t9sqBcpW71jUOL03Gf/L8TSdpeiQkU//pcRZMYPhGG0ZoXZjZDP7c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLA86rnHTszOgn49DwVFW6OsDLBR8ONhY+uU4glebuLUj0Wxy6
	LKiiZ4x9i/t5HKMB+BwlZ7AU8gCMavOHzko+z005jQoig4uPn8qNfqfQ4aKtNzmSMHg1hozslCs
	1f12WvG/UVzvbMn2sE/V/sNQqMmBBKkfkGkmuHLEg
X-Gm-Gg: Acq92OH7QqW4jz7bFiyg2kSunGrycABS2rrwqdQtKG0akEGDn19YF8TBRr6elILFY3p
	pU1d0Jy1rZz/L49U2ZaSIAEWTn/8PyZsXLbSG9ZdtCWM8HwvD+dqrgUGPfK/xqMMOHdu8opuY8U
	bXfVBreggcblEaY75ra7YsPCYJXXgqgjXspgc5XijpE36igpJLZOrXoppafgi8y1EuALr2aVd0d
	E2wXU+e6b0gM0ifi/Cj1ngha6itwW1ynI6D/SaLhhz5zu/HfQvveLA6ptxlBb1CrKOA5oXeNWAL
	HTMcHGRhAnXHCsWDW2Q=
X-Received: by 2002:a05:6512:66c9:10b0:5aa:6c1f:d300 with SMTP id
 2adb3069b0e04-5aa7c061ed1mr1281308e87.11.1780522312203; Wed, 03 Jun 2026
 14:31:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wiAqf0PdZ4AKj_4riUnnEb=g_ZNPkLnXrByA9BBHYiFRg@mail.gmail.com>
 <20260602225426.122258-1-safinaskar@gmail.com> <CAHk-=wgKy4dP0oQCNKyMQQf3-uVpaigmDyH6_T0Via76gWST9g@mail.gmail.com>
 <CALCETrWx8-Q5-rK1KnAPCxCbXaWCd=Yfs_Pr8qVMa8k8L6of1w@mail.gmail.com>
 <CAHk-=wizkDXRut5xLXRF-CVUVYMaZ5AOexxeghOAoXPb4yAvQg@mail.gmail.com>
 <CALCETrXzxubt4eWue3+wv7Fq9C2m7uu6bWPstqFh6Mo57bPwQQ@mail.gmail.com> <CAHk-=wiEwSjfbjfO74xu=UmkkdHXkJg5QNQ8pP-3iYmunmeV9g@mail.gmail.com>
In-Reply-To: <CAHk-=wiEwSjfbjfO74xu=UmkkdHXkJg5QNQ8pP-3iYmunmeV9g@mail.gmail.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Wed, 3 Jun 2026 14:31:40 -0700
X-Gm-Features: AVHnY4LsKDQ8qf8M6LcHYa40LO1DYv3gySsCGNMqZCGh4-xivJwaSH-NzjuOFXE
Message-ID: <CALCETrW3XcNLuB1Y6PSkxQDSK2o+=EB2AAd25SjWQqcJemwnbw@mail.gmail.com>
Subject: Re: [PATCH 0/3] vmsplice: make vmsplice a trivial wrapper for preadv2/pwritev2
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Askar Safin <safinaskar@gmail.com>, akpm@linux-foundation.org, axboe@kernel.dk, 
	brauner@kernel.org, david@kernel.org, dhowells@redhat.com, hch@infradead.org, 
	jack@suse.cz, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, miklos@szeredi.hu, 
	netdev@vger.kernel.org, patches@lists.linux.dev, pfalcato@suse.de, 
	viro@zeniv.linux.org.uk, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[amacapital-net.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:torvalds@linux-foundation.org,m:safinaskar@gmail.com,m:akpm@linux-foundation.org,m:axboe@kernel.dk,m:brauner@kernel.org,m:david@kernel.org,m:dhowells@redhat.com,m:hch@infradead.org,m:jack@suse.cz,m:linux-api@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:miklos@szeredi.hu,m:netdev@vger.kernel.org,m:patches@lists.linux.dev,m:pfalcato@suse.de,m:viro@zeniv.linux.org.uk,m:willy@infradead.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[amacapital.net];
	FORGED_SENDER(0.00)[luto@amacapital.net,linux-api@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-6519-lists,linux-api=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[amacapital-net.20251104.gappssmtp.com:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luto@amacapital.net,linux-api@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,linux-foundation.org,kernel.dk,kernel.org,redhat.com,infradead.org,suse.cz,vger.kernel.org,kvack.org,szeredi.hu,lists.linux.dev,suse.de,zeniv.linux.org.uk];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-api];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid,amacapital.net:from_mime,amacapital.net:email,linux-foundation.org:email,amacapital-net.20251104.gappssmtp.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C1D5E63B655

On Wed, Jun 3, 2026 at 11:29=E2=80=AFAM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, 3 Jun 2026 at 11:10, Andy Lutomirski <luto@amacapital.net> wrote:
> >
> > So maybe we should make sure that, if we go down the route of
> > disabling all the splice magic, that we leave an API, maybe the
> > existing sendfile or maybe something else, that does an optimized copy
> > from one fd to another and that is at least capable of sending from a
> > file to the network with at most one CPU-side copy.
>
> Why?
>
> That is *LITERALLY* the attack surface - and the complexity - that we
> should be removing.

I think I buried the lede too much and you're arguing against what I
was trying not to say.

Maybe we should keep an API that does an optimized copy, from one fd
to another, that can send from a file to the network with at most ONE
cpu-side copy.  Not aiming for zero like sendfile / splice.  Aiming
for one.

If sendfile and splice get completely deoptimized (which I think makes
a considerable amount of sense), then I think that, as you said,
there's a risk that the most efficient way to send the contents of a
file to the network is to read it into user memory and then send it,
which is *two* copies to get it from pagecache to the outgoing socket
buffer.  But I think that just one copy can be done with essentially
no funny business.

copy_splice_read is conceptually not terrible at all -- it allocates
memory and copies from page cache.  But splice_to_socket involves
MSG_SPLACE_PAGES, which I think is a part of the mess that you
dislike.  And the path where one does copy_splice_read and then
splice_to_socket has to be a bit complex because of tee and (I think)
because splice_to_socket cannot assume that the incoming data is just
ordinary unshared buffers.

What I'm suggesting is that, at least for network families/protocols
that care to support such a thing, there could be a slightly tedious
but otherwise utterly boring path to *copy* from pagecache to socket
buffers.  So, once the copy is done, the skbs would be ordinary skbs,
exactly as if the user had called plain send(), and nothing downstream
(the network drivers, crazy crypto code, etc) would ever see the
difference.

I don't think I'm suggesting keeping *splice* as the user-visible API,
but maybe plain sendfile could do this, and maybe someone would add
io_uring support, but all the complexity would be confined to the code
that does the actual copy and not spread to anywhere else in the
network stack.

--Andy


>
> sendfile() was a mistake. It is literally the "file->socket" thing
> that has been buggy.
>
> I absolutely refuse to get rid of splice code but keep the buggy sh*t
> cases that caused all the problems in the first place.
>
> Because *THAT* would just be completely insane and pointless.
>
> > Even if we=E2=80=99re just doing that, I continue to find it strange th=
at we
> > require that a pipe be involved. What=E2=80=99s so special about pipes
>
> Again: it was never splice or the pipe that was the problem. Stop
> barking up the wrong tree.
>
> It was "file data to socket" that was the truly horrendous issue.
>
> That said, to explain the pipe: The reason for the pipe is to act as
> the kernel-side buffer.
>
> Now, these days we have much more capable iov_iter interfaces than we
> used to, and in that sense the "pipe as a buffer" is certainly not the
> obvious choice now.
>
> But even then you need to have a *handle* to the buffers for the
> general case, and that's what the pipe fd ends up then still
> effectively being.
>
> It was also done to avoid the M:N translation problem, because people
> wanted to do zero-copy between other things than just "file ->
> socket".
>
> But again: we're ABNSOLUTELY NOT keeping that "file -> socket" thing
> and getting rid of splice.  That's literally keeping the bath-water
> and throwing out the baby.
>
> Splice is the *good* part (well, relatively - splice is bad too).
>
> ile->socket needs to DIE IN A FIRE considering the security problems it h=
as had.
>
> I hope Jakub is right that the problems have been all fixed, and this
> is all theoretical, but having seen just *how* many there were, I'm a
> bit sceptical.
>
> Because if people think splice is complicated, you haven't looked at
> the skb rules. They are completely arbitrary and complex and spread
> all over the tree.
>
>                Linus



--
Andy Lutomirski
AMA Capital Management, LLC

