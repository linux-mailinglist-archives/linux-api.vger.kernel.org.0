Return-Path: <linux-api+bounces-5697-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qBEMHIAqcWniewAAu9opvQ
	(envelope-from <linux-api+bounces-5697-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Wed, 21 Jan 2026 20:35:28 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C505C46E
	for <lists+linux-api@lfdr.de>; Wed, 21 Jan 2026 20:35:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AE341B0D2C1
	for <lists+linux-api@lfdr.de>; Wed, 21 Jan 2026 18:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE11330B17;
	Wed, 21 Jan 2026 18:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b="pXK65Fml"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66FA328B53
	for <linux-api@vger.kernel.org>; Wed, 21 Jan 2026 18:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769018435; cv=pass; b=oaeXigep+TsikuHfw6xkoNedqc6uBlihtzsFxeCN4DI3v0CBeZGtbzcKtGveLo1psn5OQpcphtPTIr7+rDVmqGQCPqqQsdCTPtabKvAqDV4HJvPKmgKZp7ECGtHtFheuTU9O8cWVkI/URgSo2wp+Ko2oaVe0BtBUN8GuaxhQswM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769018435; c=relaxed/simple;
	bh=9fUfO4M1OR0hA17huHEVgs6JgJd2UYGS587dIvnVGRc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G2k6jLmzQDPBaNcQtNiq79GZo3bynOsF/T2SfYEW8M/Qb9l6P4ZVmcT232J/pw/NASZ2hS/MK/fMAOBdICZ6QvbHP4vZK7DByjtw3cdaACYeI60a3Ij10n+s6IeJZliIs9oXs3f8I4a/UoHGR77o+I/VXRii3eQccG0OegKyvBM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net; spf=pass smtp.mailfrom=amacapital.net; dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b=pXK65Fml; arc=pass smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-59b710d46ceso27389e87.3
        for <linux-api@vger.kernel.org>; Wed, 21 Jan 2026 10:00:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769018432; cv=none;
        d=google.com; s=arc-20240605;
        b=PyaUus22x/NSn+SNb+S/YFmzs4HzF5m1Z8u2XtKot5RPxvXCkVvXW0/bjwFOnq5Bhw
         rx2j330l2rknAa3ci8dqru8pOMmHpR0qNqQkCN49PLl34f+FTrS/4MdDIY+DHLtaA8WR
         LfieVoG4Wio62mOXe9B7sNRETJBa85K5DGRXqB1Id1ZjbEAe8/0E8bQt/zeT2of8a/IQ
         FcJb+asz0x+0p12PnMoik5YcvZWu5Mme4JPaO+M1Bzzo6IbE62JqMizXHcZn82uHqxzC
         YIESm5uG2layuEStIZAUaHKY5OKYT4yICaUMwkU3qZiM32DEblkeUmS69yCygLBZaWMl
         d6BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TnUAur1XuHkI/gglF6Mz+7XnQMlmdnUuVjG0jwsSsno=;
        fh=Yz0aNIPYd9ULY1t7jEdpOp3axUhbd1X9Ocv5kZu1QiA=;
        b=jT6LHEFioWKPQ+7KbYdAyGzBFryynQzx7cTt3eEPuqytSgZ95cteTcxsALSboQ1gCl
         zh2GBxwiPlsmyK0ofgUJMHkPlGdONa2yB8yTx9NDh3Noz3VR3KrUGguqdaxN7/QPDbre
         iHR47WTMQahL18peXusoKZbqcWp49Br9nxDcKiR0yJaNCKd4VuMQgfGWZqwLx9aM4rna
         gZNY602awNUTSJvF6iw4oj+dr/V/iphiTrhDBRyBW55Ba/Vq2lLty3/ISlkUFN1t0+R5
         f+sQjYA0z9JccvOpIJV5Ki1k+vRU9yRubduiTpv12pi+uHm1qQJgxrcRiWQzu6Qu9VUq
         vq3w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20230601.gappssmtp.com; s=20230601; t=1769018432; x=1769623232; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TnUAur1XuHkI/gglF6Mz+7XnQMlmdnUuVjG0jwsSsno=;
        b=pXK65FmlR/ikv0hyYSDauFJl7evsrenS2c8I4guizWR+XmM16PmLT/Xg/o4ecieRaQ
         av1tbDpFyXbcM6Sn/sSp5i81VWi6pR4CJ1KB3tHm5+dZuUW8S0AwkKMQGDzapwdkMj3p
         WTpW30coyhhYujAakIxYEU85FKrOO213vGA0y3Kx9WfvkqSOMWodt6J4j37/leqFu1oK
         vTgDqdzl/4et0VknLshBHlNs6ruD7StL+KVTNdX0W+0gNzxeiw2EU78eMS/A86r7lzAi
         64d364HKh/BTOhAfwo1OXJsho4Mgg8KOEQMHY1g/iScSfV9VL9qc7qgqgHpWDio/F1Vt
         /yYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769018432; x=1769623232;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TnUAur1XuHkI/gglF6Mz+7XnQMlmdnUuVjG0jwsSsno=;
        b=RlfknjBSERYKqN+e8K+ob3Wkvzub/PaBXjvFKnKKSMoooIUs+pO3O9Vb3RMYdz9Rvz
         DRqA2bdejTGneWkkadOWCgBt9csDJP4M59p2IzIeiux55FyyfeHyV1YJ/EncfNcPa0fS
         V7efHYlOoaLN32SbU5WV7w4VN7wf+6fSRUfYyfM6eWfWBTzB72nMtTl8BcKvkSCNcHyo
         hYsys+rCjmpUoRDuXnL7//8TnDdYVRv8q2Dec635qVys2O43096vy0Ap5idVOWNGTzjk
         /whbQKPAWrgLpUmsiWM1zPcFwx8pGHAQEu5g/IluTcNsbYM1FENmoPwxqo9RetQp1XrB
         z90Q==
X-Forwarded-Encrypted: i=1; AJvYcCX9l9mOdPZbImeqRZ6ABiQnhCB/zErk+pR4vsZ9CXW3iWSJy+rWEefdiejCmNJwrhBNHAvPE2vW/n0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwU1zxSZvASb523cy0BkcjOC/U6Bb4NhgHH1vuaBvwMS69Msm8
	DADRGCu5EyljDbNnO+wW7WTmEyc5OetDQA7OCuWU4sgSLwQJh/scCG9FdmBAZtpctnHZwTpITzj
	gsPLSoo616thDsmlj5WbGPzjS8RZrFJicQ3ARYqBP
X-Gm-Gg: AZuq6aLGQDEfDWpAM31Lw8H4+R7fThV3kp5zsBC2q5GPa5XzVglhzNqY8OgtU/m9jrJ
	gUx6Ht89AWubTqv43KFr48QAnwQ2Dt8rYSAx0meLdhGu8N48xaojqqbB4q6EgKgkULyJhybQWqY
	1cRBak3BQ2JLXTCKNY145wLmV+83xnQzfa5+CslpwU0z/ls8VGjl6is9TyeFY14Lbj/U0DzxnLN
	6x/er519iJzcc6395MneYZfOAKBYhFpWK45YHlGcZS4ay9vjTsrnWDNVr4LPQnI8mP/tXpAbJm6
	gT0=
X-Received: by 2002:a05:6512:3f0d:b0:59b:6c03:74a5 with SMTP id
 2adb3069b0e04-59dc8f11cbamr2090430e87.8.1769018431803; Wed, 21 Jan 2026
 10:00:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251229-work-empty-namespace-v1-0-bfb24c7b061f@kernel.org>
 <20260119171101.3215697-1-safinaskar@gmail.com> <CALCETrWs59ss3ZMdTH54p3=E_jiYXq2SWV1fmm+HSvZ1pnBiJw@mail.gmail.com>
 <acb859e1684122e1a73f30115f2389d2c9897251.camel@kernel.org>
In-Reply-To: <acb859e1684122e1a73f30115f2389d2c9897251.camel@kernel.org>
From: Andy Lutomirski <luto@amacapital.net>
Date: Wed, 21 Jan 2026 10:00:19 -0800
X-Gm-Features: AZwV_Qj4HThaSaYzNn-qIgAjYFvcri9rsxrh7J0CX4Os2pMzxyAuji1p2rkqKzY
Message-ID: <CALCETrUZC+sdfpVqqjeC_pqmd+-W84Rq7ron8Vx9MaSSohhJ2g@mail.gmail.com>
Subject: Re: [PATCH 0/2] mount: add OPEN_TREE_NAMESPACE
To: Jeff Layton <jlayton@kernel.org>
Cc: Askar Safin <safinaskar@gmail.com>, brauner@kernel.org, amir73il@gmail.com, 
	cyphar@cyphar.com, jack@suse.cz, josef@toxicpanda.com, 
	linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk, 
	Lennart Poettering <mzxreary@0pointer.de>, David Howells <dhowells@redhat.com>, 
	Yunkai Zhang <zhang.yunkai@zte.com.cn>, cgel.zte@gmail.com, 
	Menglong Dong <menglong8.dong@gmail.com>, linux-kernel@vger.kernel.org, 
	initramfs@vger.kernel.org, containers@lists.linux.dev, 
	linux-api@vger.kernel.org, news@phoronix.com, lwn@lwn.net, 
	Jonathan Corbet <corbet@lwn.net>, Rob Landley <rob@landley.net>, emily@redcoat.dev, 
	Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[amacapital-net.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[amacapital.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-5697-lists,linux-api=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amacapital-net.20230601.gappssmtp.com:+];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luto@amacapital.net,linux-api@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,cyphar.com,suse.cz,toxicpanda.com,vger.kernel.org,zeniv.linux.org.uk,0pointer.de,redhat.com,zte.com.cn,lists.linux.dev,phoronix.com,lwn.net,landley.net,redcoat.dev,lst.de];
	TAGGED_RCPT(0.00)[linux-api];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: D4C505C46E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> On Jan 19, 2026, at 2:21=E2=80=AFPM, Jeff Layton <jlayton@kernel.org> wro=
te:
>
> =EF=BB=BFOn Mon, 2026-01-19 at 11:05 -0800, Andy Lutomirski wrote:
>>> On Mon, Jan 19, 2026 at 10:56=E2=80=AFAM Askar Safin <safinaskar@gmail.=
com> wrote:
>>>
>>> Christian Brauner <brauner@kernel.org>:
>>>> Extend open_tree() with a new OPEN_TREE_NAMESPACE flag. Similar to
>>>> OPEN_TREE_CLONE only the indicated mount tree is copied. Instead of
>>>> returning a file descriptor referring to that mount tree
>>>> OPEN_TREE_NAMESPACE will cause open_tree() to return a file descriptor
>>>> to a new mount namespace. In that new mount namespace the copied mount
>>>> tree has been mounted on top of a copy of the real rootfs.
>>>
>>> I want to point at security benefits of this.
>>>
>>> [[ TL;DR: [1] and [2] are very big changes to how mount namespaces work=
.
>>> I like them, and I think they should get wider exposure. ]]
>>>
>>> If this patchset ([1]) and [2] both land (they are both in "next" now a=
nd
>>> likely will be submitted to mainline soon) and "nullfs_rootfs" is passe=
d on
>>> command line, then mount namespace created by open_tree(OPEN_TREE_NAMES=
PACE) will
>>> usually contain exactly 2 mounts: nullfs and whatever was passed to
>>> open_tree(OPEN_TREE_NAMESPACE).
>>>
>>> This means that even if attacker somehow is able to unmount its root an=
d
>>> get access to underlying mounts, then the only underlying thing they wi=
ll
>>> get is nullfs.
>>>
>>> Also this means that other mounts are not only hidden in new namespace,=
 they
>>> are fully absent. This prevents attacks discussed here: [3], [4].
>>>
>>> Also this means that (assuming we have both [1] and [2] and "nullfs_roo=
tfs"
>>> is passed), there is no anymore hidden writable mount shared by all con=
tainers,
>>> potentially available to attackers. This is concern raised in [5]:
>>>
>>>> You want rootfs to be a NULLFS instead of ramfs. You don't seem to wan=
t it to
>>>> actually _be_ a filesystem. Even with your "fix", containers could com=
municate
>>>> with each _other_ through it if it becomes accessible. If a container =
can get
>>>> access to an empty initramfs and write into it, it can ask/answer the =
question
>>>> "Are there any other containers on this machine running stux24" and th=
en coordinate.
>>
>> I think this new OPEN_TREE_NAMESPACE is nifty, but I don't think the
>> path that gives it sensible behavior should be conditional like this.
>> Either make it *always* mount on top of nullfs (regardless of boot
>> options) or find some way to have it actually be the root.  I assume
>> the latter is challenging for some reason.
>>
>
> I think that's the plan. I suggested the same to Christian last week,
> and he was amenable to removing the option and just always doing a
> nullfs_rootfs mount.
>
> We think that older runtimes should still "just work" with this scheme.
> Out of an abundance of caution, we _might_ want a command-line option
> to make it go back to old way, in case we find some userland stuff that
> doesn't like this for some reason, but hopefully we won't even need
> that.

What I mean is: even if for some reason the kernel is running in a
mode where the *initial* rootfs is a real fs, I think it would be nice
for OPEN_TREE_NAMESPACE to use nullfs.

