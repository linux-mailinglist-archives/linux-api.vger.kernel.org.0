Return-Path: <linux-api+bounces-6535-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id d2Z1HKmhIWpYKQEAu9opvQ
	(envelope-from <linux-api+bounces-6535-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Thu, 04 Jun 2026 18:02:49 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 40466641AB6
	for <lists+linux-api@lfdr.de>; Thu, 04 Jun 2026 18:02:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amacapital-net.20251104.gappssmtp.com header.s=20251104 header.b=Ki36pezf;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6535-lists+linux-api=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-api+bounces-6535-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 61A613041AA4
	for <lists+linux-api@lfdr.de>; Thu,  4 Jun 2026 15:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A8723A9618;
	Thu,  4 Jun 2026 15:53:31 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724E73A3E74
	for <linux-api@vger.kernel.org>; Thu,  4 Jun 2026 15:53:29 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780588411; cv=pass; b=JPxN4rvZqjnGCgeYEqgdYgMz/Jxadxy2NyUVAq+FYKYAyosKJpPTY+ZuKidFrmTgRtpqpVIk1yqGmyZfbG1EKjhLEI0cyg0iJ/halqiJeadzjjLGlg9PsCrtutA9/6OsBp0nmW1s8rUjMDBrQ8qRPdXwVeXRh3Di9Ghdo/uIxPI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780588411; c=relaxed/simple;
	bh=DHE3qIm1NUuqilEHDVEIKI0Gv9gNlT3AX89YAbcKkxE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ePOBgFihLf5GTixdZwIgovHAZ6dtvx8SjRTcUXwVFT+rpsPxePWvJpVZJISHRpI/H3lUG1z+qdAqkuzli3mYS3xS4p6ceTpdMpAi9BQsRQz8NUyWlnOE9bji5tXqtPfUPbFUqiy0xxkEvYc53kDGblriR6x5iEaIIf32nk25dnU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net; spf=pass smtp.mailfrom=amacapital.net; dkim=pass (2048-bit key) header.d=amacapital-net.20251104.gappssmtp.com header.i=@amacapital-net.20251104.gappssmtp.com header.b=Ki36pezf; arc=pass smtp.client-ip=209.85.208.182
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-3967726bc47so8461281fa.1
        for <linux-api@vger.kernel.org>; Thu, 04 Jun 2026 08:53:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780588408; cv=none;
        d=google.com; s=arc-20240605;
        b=GHlrU+08uZwT5z6OaSpI2UiWCWvEjaTIO2x0Fk2FPHMq37/UytlAOtvnz89KIOb2fE
         lVGtkD53sm3SlLBVQ67PSu40go4iz3343LSdzXVjgDk+soHPKjOAjJzwIIHjYx2WreKP
         3TggNDKZG+o0lDtvKgl34+hSe1LrNE3OsnPrXAGSfxyONYOFlopxqBAC4VlDdbR+u7JR
         bRJcXzDSnXBsbdeHum/Z7gTKcR1qS1aokaSb1NDpKitf4NJyQ+uHboh1SzjcJwtgH4iv
         AH2L0u2gRAQOQr28REp52+2FGwr3iH4T7+DWAaR8VZ7PhauWf4iRoHYXp96laBE9cfRp
         DlPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=B6H/bsprACHYwfP1VnZci/atvKi9rC7jAoAwzWHNDIk=;
        fh=LIpSnNUqBTfdYsr8LNj1xohLzPXfdomZ0eKjB1gNO7U=;
        b=RS0lOiJQgr7CLqEfvU54E00fs9fJh/mBsOmdBcT0Uby9VzV2+pVonhevUmi/FNZP7A
         Q4sx3RzHMIpeKgvJvCv7QytGWwWjOr2V5h3qDO7WVRu99l4aaraWNa0NqasrBH7JaTOU
         yvXDLbMD8G1QS//9H49HOjFQQJGD2umNYGwUoSVA8O8rfGlCa397kiY7aRJ0XiVofY4o
         jamj4+iKye9RJQgZ/nY7NIVw0LwVTvXfh61CJOe8XpjqEYgc0opH0bYlo60ZVuzLGXa7
         TdY87/DnsCVbw/bhCBr0c9VoRtUAQbESpmpPEbb2E0zXNILSV8YankbmBViqw4Jucicj
         Zgtw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20251104.gappssmtp.com; s=20251104; t=1780588408; x=1781193208; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B6H/bsprACHYwfP1VnZci/atvKi9rC7jAoAwzWHNDIk=;
        b=Ki36pezfroNZ00TWgwOyv1bhwKzyXoVErW730CyWzm5FcG5SFdoDEJgmBWIeqbxWZk
         lXgsrP6YEQQyRBw67qTfBjwPT2XA0XoP3rDmxLpgxLZrGwOCIEd5bgUc8RuYI7kjsHPm
         sB6k397Sg2oYiCFyaHPFJQA7mAtq4wYrrJMRSEeVouy/rgYOjFUSOrGp28doHVbths0S
         H3YVmcETocR8ENK5pVeBF+alXPKsa3wDZ806XR6FLMn62lvKn8tKdSDIh1PENoyDLm5+
         +E86ZOQAkJig7e4pqjpW4RqfQDKF91Ghp5SoCOjeBe+v8+kTC3LF0ieeGLqf8kS5nD7n
         Aq1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780588408; x=1781193208;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=B6H/bsprACHYwfP1VnZci/atvKi9rC7jAoAwzWHNDIk=;
        b=bSVrsONYTwfN5LRvqhJ4weYu51kFYMAr8RXmgaSiMHqMnSiQmIBh7pQfApxEah6/zl
         c83twzTGg3ruK0htx204y2lyjh6nerL9FcaT3wm/5o4CAIGq5YP/hbhSiT9qkrLosHkN
         ftSqZgfVuWo4ABPjkqh7oz76mFEo89S5RrtglufdyW52WNYzDLOuLQEuo7rp/FOvyIB0
         Au15rDnZFkayK5EF35Eyl1WZE4JWYaYIxDKkkUjUOofQE3Z2IHYna2Fb46gwSDfLzIdx
         MDflHceIFVnqizNbWnZx2shhvBiYPDdaWiakRKWxlPfBn2XJmcf1SKwMWnl2xhVadaBA
         vCXA==
X-Forwarded-Encrypted: i=1; AFNElJ9+h1xXnLMCqxJCJJ/aGkXbMQgxCKNXnWjjH0cxVfHkel2eOm8QfZxnQh1D3/RkmPIINx/n2ytjIk0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLSAkj1RJ2hWVFBJEbFKJie+AgRfRx8xJGT8rSa3TwqomwxNse
	DVZJjshGVB/Kf7NLli87nkHTn18+2MIdSkD7Qo6EpsS9qmQSi1HBwPDanl6LKZ4TzWMqK5vPGfO
	yFdB7Tm+s4uyFqo6Wm6xb2lCIJ++64Ummfq/QGn0v
X-Gm-Gg: Acq92OGLHEK69HvjgnYYfH39LxCd8L0M7Wq5K3eOSBx7VFLX45PjHk46sdOldzZ3vqm
	h/aLneQtzfyVbxwg8++aJ3ndGIZssdz6mf74A6rfV5iL2FAvL1UL7GtqOvBbujX2B+xjwbZavJ+
	LxSdrejkwXz+MVJrMDqCkJY7wI+BB6dGHj4medlcDjPeG0Y2wb32FOk1OlSHjf+XTtuzN+PstJF
	P+58BBx/r9ragZNrzVezrRHzCHGCSP2UGHe9YGjjOn8mw7bOHGpQGmp0S3Qfxc5xBwz4sMt/p9b
	Z/acweWx148JcJQrVAWLUTylQg==
X-Received: by 2002:a05:6512:3186:b0:5aa:7126:c63c with SMTP id
 2adb3069b0e04-5aa7c0888ccmr2415181e87.5.1780588407521; Thu, 04 Jun 2026
 08:53:27 -0700 (PDT)
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
 <20260601172825.a51a588ec1c32617a0e12d78@linux-foundation.org> <aiEb8CTM-ovMIq7-@1wt.eu>
In-Reply-To: <aiEb8CTM-ovMIq7-@1wt.eu>
From: Andy Lutomirski <luto@amacapital.net>
Date: Thu, 4 Jun 2026 08:53:15 -0700
X-Gm-Features: AVVi8CcFmOEXliFqkwckAyyy2jg3Zlvf93FEoWWD2xBje7cN4CAoI605l5f9FiY
Message-ID: <CALCETrULMixRGJyGqAAujW7RN6PP2f_Orn2Y_0hpPMjRqQnY7Q@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[amacapital-net.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:w@1wt.eu,m:akpm@linux-foundation.org,m:rostedt@goodmis.org,m:viro@zeniv.linux.org.uk,m:torvalds@linux-foundation.org,m:brauner@kernel.org,m:safinaskar@gmail.com,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:linux-api@vger.kernel.org,m:netdev@vger.kernel.org,m:willy@infradead.org,m:axboe@kernel.dk,m:hch@infradead.org,m:dhowells@redhat.com,m:david@kernel.org,m:pfalcato@suse.de,m:miklos@szeredi.hu,m:patches@lists.linux.dev,m:linux-fsdevel@vger.kernel.org,m:jack@suse.cz,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[amacapital.net];
	FORGED_SENDER(0.00)[luto@amacapital.net,linux-api@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-6535-lists,linux-api=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[amacapital-net.20251104.gappssmtp.com:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luto@amacapital.net,linux-api@vger.kernel.org];
	FREEMAIL_CC(0.00)[linux-foundation.org,goodmis.org,zeniv.linux.org.uk,kernel.org,gmail.com,vger.kernel.org,kvack.org,infradead.org,kernel.dk,redhat.com,suse.de,szeredi.hu,lists.linux.dev,suse.cz];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-api];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amacapital-net.20251104.gappssmtp.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,goodmis.org:email,1wt.eu:email,man7.org:url,mail.gmail.com:mid,vger.kernel.org:from_smtp,linux.org.uk:email,haproxy.org:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 40466641AB6

On Wed, Jun 3, 2026 at 11:32=E2=80=AFPM Willy Tarreau <w@1wt.eu> wrote:
>
> On Mon, Jun 01, 2026 at 05:28:25PM -0700, Andrew Morton wrote:
> > On Mon, 1 Jun 2026 16:04:55 -0400 Steven Rostedt <rostedt@goodmis.org> =
wrote:
> >
> > > On Mon, 1 Jun 2026 18:33:25 +0100
> > > Al Viro <viro@zeniv.linux.org.uk> wrote:
> > >
> > > > On Mon, Jun 01, 2026 at 10:17:23AM -0700, Linus Torvalds wrote:
> > > >
> > > > > TLDR: maybe we could ghet rid of "f_op->splice_read". *That* woul=
d be
> > > > > a big simplification.
> > > >
> > > > FUSE might be interesting - fuse_dev_splice_read() and its ilk.
> > > > Communications between the kernel and fuse server at least used to
> > > > seriously want that, so that would be one place to look for unhappy
> > > > userland...
> > > >
> > > > splice-related logics in fs/fuse/dev.c is interesting; another plac=
e
> > > > like this is kernel/trace/, but I'm less familiar with that one.
> > > >
> > > > rostedt Cc'd (miklos already had been)
> > >
> > > Thanks for the Cc. The tracing ring buffer was specifically made to b=
e used
> > > by splice and the libtracefs has a lot of code to use it as well. As
> > > reading the ring buffer literally swaps out the write portion with a =
blank
> > > read portion, that portion (sub-buffer) is used to be directly fed in=
to
> > > splice, providing a zero-copy of the trace data from the write of the=
 event
> > > to going into a file.
> > >
> > > trace-cmd defaults to using splice to copy the tracing ring buffer di=
rectly
> > > into files to avoid as much copying during live recordings as possibl=
e.
> > >
> > > Whatever changes we make, I would like to make sure there's no regres=
sions
> > > in performance of trace-cmd record.
> >
> > Well yes, The patchset seems sensible from a quality POV.  But to make
> > a decision we should first have a decent understanding of its downside
> > impact.
> >
> > I haven't seen a description of that impact in the discussion thus far.
> > And that description is owed, please.
> >
> > I assume a small number of specialized applications are using
> > vmsplice() to great effect?  What are those applications?  What is the
> > impact of this change?
>
> > Once we are armed with that information, is there some middle ground in
> > which we de-feature vmsplice()?  Fall back to pread/pwrite in the
> > tricky cases and still permit vmsplicing if the application is
> > appropriately restrictive in it usage?
>
> I'm using vmsplice() + tee() + splice() in high-performance applications,
> load generators to be precise, and soon a cache. This is super convenient
> and extremely efficient:
>
>   - vmsplice() is used to prepare a "master" pipe with data to be sent
>     over TCP or kTLS
>   - then for each request, we do tee() from this master pipe to per-reque=
st
>     pipes.
>   - the per-request pipes are those that are used to deliver the data to
>     the socket via splice().
>
> So we effectively use vmsplice(), tee() and splice() here, and for exactl=
y
> the reasons they were designed: only play with page refcount and not copy
> data. The code is here for the curious:
>
>    https://git.haproxy.org/?p=3Dhaproxy.git;a=3Dblob;f=3Dsrc/haterm.c
>
> and its ancestor is here:
>
>    https://github.com/wtarreau/httpterm/blob/master/httpterm.c
>
> It simply doubles the network bandwidth compared to not using that.
> (62 Gbps per core vs 31). I would seriously miss it if I couldn't use
> this anymore.
>

Wait a moment.  This is neat, but it's literally just a benchmark,
right?  I skimmed the code, and it doesn't look like a production
workload, either.  And you manage to get around the awfulness of the
vmsplice API's complete failure to tell you when it's done with a
buffer by ... never actually changing the contents of the buffer.  Do
you have any idea how you would write correct code that uses vmsplice
for sends and then *ever* mutates the data without literally
munmapping (or madvise or something) the data do you can safely mutate
it?

> I also have mid-term plans for using vmsplice() to deliver contents from
> a cache to sockets as well via splice(). Right now our cache is split int=
o
> too small chunks (1kB) to make that useful, but as soon as we can move to
> 4kB pages, it will make sense. There the same gains are expected, and I
> would particularly dislike the idea of no longer being able to implement
> zero-copy!

If I'm understanding you correctly, you see (and measured!) a
performance improvement, and you would like to use it in production.

It seems to me that this is an excellent opportunity to remember that
vmsplice gets a performance boost in a highly synthetic situation that
sort of resembles a cache scenario and then to deprecate vmsplice and
build something better!  Or discover that we already have something
better, perhaps :)

https://man7.org/linux/man-pages/man3/io_uring_prep_send_zc.3.html

I see that this can submit a buffer without a syscall (tee + splice is
*two* syscalls!) and that it has directly addressed what I see as the
really big deficiency in vmsplice: "This second notification tells the
application that the memory associated with the send is safe to get
reused."  If I were writing the user code, I would very much want that
notification to be an explicit part of the API instead of making a
wild guess as I think I would need to do with vmsplice.

--Andy

