Return-Path: <linux-api+bounces-6646-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id utoqHH3COmpTGAgAu9opvQ
	(envelope-from <linux-api+bounces-6646-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Tue, 23 Jun 2026 19:29:33 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D0B16B90E1
	for <lists+linux-api@lfdr.de>; Tue, 23 Jun 2026 19:29:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=i+h9W57Y;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6646-lists+linux-api=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-api+bounces-6646-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A3CED301F3BB
	for <lists+linux-api@lfdr.de>; Tue, 23 Jun 2026 17:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7BCE38B142;
	Tue, 23 Jun 2026 17:29:28 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF4638B13C
	for <linux-api@vger.kernel.org>; Tue, 23 Jun 2026 17:29:26 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782235768; cv=pass; b=UyFQ7/Ny4vOtoHfEYquoy/ww4bRc7+FPxcRXtlpzyD4rZjvq9lCA4aleIwSWAVrwUx89MphVVeqWjBOcS+2gIFcYHLbUq5zO7+Nd4dLJTY7NDwgqI+08UElxvcULm0vr/CVjk3nNos754NyHdfrqYHIpJW3OTK19qZsy7x6vyKA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782235768; c=relaxed/simple;
	bh=R/Fe5SnmFz4pInrDHbvj1u/lF1jaDqBAJE2REUZG8sY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jgvbH4yL8I1hHS2xpz9H8N2BPTz8AJY/ZPK1U2JzTX02G2UycxijWqV9h6lQ/L3i2K8EG781jUHOqhrHjdBv9i6a0PT+ZUrHUsI+kjC1a/ZtdRTp1LB+RpkHRQ9oQ6gbmx1fHet4XI5sI6zFLjeaGM8AlYLwn3sHN9MYhx8tQ9A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i+h9W57Y; arc=pass smtp.client-ip=209.85.160.43
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-44747d96185so131737fac.1
        for <linux-api@vger.kernel.org>; Tue, 23 Jun 2026 10:29:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782235766; cv=none;
        d=google.com; s=arc-20240605;
        b=CIYNEp51FQbdCMooDksYWm5YARtSUNRicIcUqpMXebNU4C1CJFG3M7Ng0M+hMojAc4
         uVYj/QvL8XFsqkrb2TIttcLlmHTuDJefp2WfzXfHwVOz758/JcbsOwXNAZjVaUYYOCE8
         Vssm7Zulo8y2r9CErHUpJxmte6GDlaI532A0n3za8hJLaWtdifN/lQ7p5b8Cur4l07Gi
         x3LTVKCMywfee6HqXnfQDh4WBJEEpcWQqn2sUZsBJ5iWAzesGKOTRoKyA/LE9nWEzI5P
         zxjuOetffWfv1DCM7EXL4XMyBfsCXjRZNi5Ncyu8a5qsYRBLltRCXKYDXOo+ow3OLUZs
         kwGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SOKLBFVXea5OkC+RzUd8udE2QmUOJ4Ga+YnSpSPdn2Y=;
        fh=+Z4L3cBVHdyVaaB3Y9rAUT21/4yfk+j6ZW0elyquOYk=;
        b=Wx2HJpFm9DYKgz0S5gEPwMv1h1dSmzNtKn7uYda6PzYpDvsYis65U+WzUNzA8E99Af
         tFXLumG6LZ9F1J4DFpaA9QZf04Pro45MIT+ZwZnl7md8natwSVMPiYovU8x7YZHKimUS
         7uflci67OA0iCwgsGcRFnw3t2LM2lEtLyvuTOOMowIRQeBl5gTarFly9e0V9qhq2kLPA
         M8O50xm2UFkv0uaeDRN6UtcthdAM1AEe4jaWsJ7kI1pEN/e4hAJy/5XQ5Ic8X+s23PML
         maX7BCse8GKvL4/0EIUe1y0j8lWNg/CuPTQe2EYVet0FIFKuJcr7MboMgFHgbX4IpJpD
         wVsw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782235766; x=1782840566; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SOKLBFVXea5OkC+RzUd8udE2QmUOJ4Ga+YnSpSPdn2Y=;
        b=i+h9W57YyBRyyYtCHPYl9/tnRJUtnRTPfM16N/cco/qK130BDC4MUMVg2u9JZYg6tA
         stG74N9TiPZ5FBHi7Hzes1ZNSG7QnZsdLA1fmMvXyNsWJAv0xHvrNNAfJJygvfa5sp5h
         U8ymc4hP3oJuJ0gpPdHMNEc6/sUEfrKVldijc/oh8Fn1cv1xtLhKIi9UZe9LS5SzDsy+
         olLPcUDO6HRp3uvLQjVIUP/lXlCfOfOmgQSGtVDUmyTJpmgI1/Mbva0mdg+LUyToPf+n
         6m6e8i/9SoQKVRZHH3epBe0uNdk5uyghFyOoaM6iBfswtkBsvBL/xQ0mQOHZ6JTAFmLe
         ZY6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782235766; x=1782840566;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SOKLBFVXea5OkC+RzUd8udE2QmUOJ4Ga+YnSpSPdn2Y=;
        b=oOyu+zCN932nkA6uZkDrKh7odadBbizHz1wAqrmIJ6KSN+r84SqTzhN96+sj6k78p8
         100VW9v7Uz1TN/zv2b6T+YoV948CooztYfx5bm3ODC0mDXVy2XIN9lJa8hsl2V5XBpVV
         Usk4FAO1GrcKq0ofeT67bm884c2/Ow92eth8rY2bjmkN0Mvizk/NAaafSKwaMMeZEAoe
         e9rNlP0wSag9wONn6gm6iVc1ZGKVAOwDKy/agA1cUF9wExIlEdUu9nIVGlq7qnqVEdvx
         v8TnQJVEY4xF3R1DthnWeGEZEFmyqeMwRgfsKJXZ5QPYh8RAR/tSYEC50GbP/LsGFT4o
         fYdg==
X-Forwarded-Encrypted: i=1; AHgh+RramX+oX2h+JWmnhEmm8W2hWZ3GYeIK1Yu1//DoCjOzPFpYaTThJN4CsM35qi6VRXSg/ZmXum4VNao=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhzoyTI3KJPnW/ceRS0WBo4i+BHZFRotFnb7TZFxxv81lFHTxG
	aNlRwjHa+Uw4b7EIlv5jbPP/D5BSrZZ3ks58VX6DEvXEwnlKiZGaUzByx2g5FA2N0fjy+tqv5NJ
	sVRewTGiK2OmdSassvWyHriJhc2iQQc4=
X-Gm-Gg: AfdE7cmWhnVOl11VzOtmoDMVSJZab798//kJ9uSsVB8RIZzmKxXtNnvoc6LKI4aTGHW
	j+IDlJemE5suRboTuqY1ROC8+B/YO/s0o2xrUjDovUtl4iJLC2wSFdr+DU5CBSaVbq7YcFDPyug
	zml45/bS4MD6FgKhS1raDBeaCb3TsjvsHzStEqmhTHeI667fK79MyOs4FDGYuqaS5yIKmqSj5ci
	w6bdPHlcVbzL/LcexZg+Ztfj9xdIGNNPolvkfiVr5pBx4ZUJcLQ0X+BwCfzfyhUMfCLM+Y=
X-Received: by 2002:a05:6870:c22e:b0:430:29c3:9d15 with SMTP id
 586e51a60fabf-447b653ffaamr2576825fac.1.1782235765975; Tue, 23 Jun 2026
 10:29:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANaxB-xVCP5HSUNwphFrKPdW0Qh1pA33A6npac60WArkZMFt7w@mail.gmail.com>
 <20260623094211.1080873-1-safinaskar@gmail.com>
In-Reply-To: <20260623094211.1080873-1-safinaskar@gmail.com>
From: Andrei Vagin <avagin@gmail.com>
Date: Tue, 23 Jun 2026 10:29:13 -0700
X-Gm-Features: AVVi8CdxhzkHtkOXOPWSv5LcqN-nC_Tc8xPzc65F7h69_IRaRTA8RjzQbS4VMPM
Message-ID: <CANaxB-wcNOSs9vHpZ_wG7Q8WJVV0D2nhtCFGyZ1_5Rg=+256cw@mail.gmail.com>
Subject: Re: [PATCH 0/3] vmsplice: make vmsplice a trivial wrapper for preadv2/pwritev2
To: Askar Safin <safinaskar@gmail.com>
Cc: akpm@linux-foundation.org, alexander@mihalicyn.com, axboe@kernel.dk, 
	bernd@bsbernd.com, brauner@kernel.org, criu@lists.linux.dev, david@kernel.org, 
	dhowells@redhat.com, fuse-devel@lists.linux.dev, hch@infradead.org, 
	jack@suse.cz, joannelkoong@gmail.com, linux-api@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, miklos@szeredi.hu, netdev@vger.kernel.org, 
	patches@lists.linux.dev, pfalcato@suse.de, rostedt@goodmis.org, 
	torvalds@linux-foundation.org, val@packett.cool, viro@zeniv.linux.org.uk, 
	willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:safinaskar@gmail.com,m:akpm@linux-foundation.org,m:alexander@mihalicyn.com,m:axboe@kernel.dk,m:bernd@bsbernd.com,m:brauner@kernel.org,m:criu@lists.linux.dev,m:david@kernel.org,m:dhowells@redhat.com,m:fuse-devel@lists.linux.dev,m:hch@infradead.org,m:jack@suse.cz,m:joannelkoong@gmail.com,m:linux-api@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:miklos@szeredi.hu,m:netdev@vger.kernel.org,m:patches@lists.linux.dev,m:pfalcato@suse.de,m:rostedt@goodmis.org,m:torvalds@linux-foundation.org,m:val@packett.cool,m:viro@zeniv.linux.org.uk,m:willy@infradead.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[avagin@gmail.com,linux-api@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-6646-lists,linux-api=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[avagin@gmail.com,linux-api@vger.kernel.org];
	FREEMAIL_CC(0.00)[linux-foundation.org,mihalicyn.com,kernel.dk,bsbernd.com,kernel.org,lists.linux.dev,redhat.com,infradead.org,suse.cz,gmail.com,vger.kernel.org,kvack.org,szeredi.hu,suse.de,goodmis.org,packett.cool,zeniv.linux.org.uk];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6D0B16B90E1

On Tue, Jun 23, 2026 at 2:42=E2=80=AFAM Askar Safin <safinaskar@gmail.com> =
wrote:
>
> Andrei Vagin <avagin@gmail.com>:
> > Actually, this change introduces a performance and functional
> > regression for CRIU.
> >
> > Here is a brief overview of how CRIU currently dumps memory pages:
> >
> > CRIU injects a parasite code blob into the target process's address
> > space. The parasite invokes vmsplice() with the SPLICE_F_GIFT flag to
> > pin physical pages directly inside a pipe without copying them. The mai=
n
> > CRIU process then takes over from outside the target context, calling
> > splice() on the other end of the pipe to stream the data directly into
> > checkpoint image files or a remote network socket.
> >
> > I ran a simple test that creates an anonymous mapping and touches every
> > page within it:
> > Without this patch, CRIU takes 9 seconds to dump the test process.
> > With this patch, It takes 18 seconds...
> >
> > Plus, it obviously introduces some memory overhead.
> >
> > If these changes are merged, we will need to completely rework the
> > memory dumping mechanism in CRIU. Using vmsplice() in this proposed for=
m
> > no longer makes any sense for our architecture...
>
> I just have read some docs for CRIU. I found this statement:
>
> > #### Why `splice` is Better:
> > *   **Consistency via COW**: The `SPLICE_F_GIFT` flag ensures that if t=
he process modifies a "gifted" page after resuming, the kernel performs a *=
*Copy-on-Write (COW)**. The pipe buffer > continues to hold the *original* =
version of the page as it existed at the moment of the `vmsplice()` call, e=
nsuring a perfectly consistent snapshot of that page.
>
> This is wrong (with released kernels). I confirmed this by testing this o=
n my current kernel (6.12.90).
>
> See the code in the end of this message.
>
> If you actually rely on mentioned consistency, then, it seems, CRIU is br=
oken.
>
> So, in fact, my patch actually brings consistency to CRIU. :)

Askar, unfortunately, the statement about "Consistency via COW" is just
"AI imagination". The under-the-hood docs were recently transferred from
the criu.org wiki using some AI transformations, which introduced this
wrong statement. The original document can be found here:
https://criu.org/Memory_dumping_and_restoring.

To clarify, CRIU does not rely on page consistency for intermediate
pre-dumps. The pre-dump mechanism is designed to be iterative: During a
pre-dump, tasks are briefly frozen to vmsplice dirty pages into pipes.
Then the tasks are resumed, and CRIU drains the pipes. If the process
modifies a page after it has been spliced, the data in the pipe may
become inconsistent. However, any such modification is tracked by the
soft-dirty page tracker. In the next pre-dump iteration (or the final
dump), these modified pages will be identified as dirty again and
re-dumped. During restore, the images are applied sequentially, and the
final dump (taken while the process is fully frozen) ensures we
reconstruct a consistent final state.

But what really matters in this scheme is the vmsplice performance.
The proposed change significantly slows it down. In the case of CRIU,
vmsplice performance is critical because the target process is frozen
during these calls. Minimizing the freeze time is the primary goal of
pre-dumping to make migration almost invisible to the user workload.

Thanks,
Andrei

