Return-Path: <linux-api+bounces-6426-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oBd0JIOuFmokogcAu9opvQ
	(envelope-from <linux-api+bounces-6426-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Wed, 27 May 2026 10:42:43 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 25CB05E1405
	for <lists+linux-api@lfdr.de>; Wed, 27 May 2026 10:42:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DF24D30173B8
	for <lists+linux-api@lfdr.de>; Wed, 27 May 2026 08:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 523CB3E0099;
	Wed, 27 May 2026 08:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BQwii13a"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7CA43E00B2
	for <linux-api@vger.kernel.org>; Wed, 27 May 2026 08:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779871347; cv=none; b=amFubPhweBexjyj+QHrJ+B5cqNTmlEr9Q3kwb2mAZC/LLFq/4LpLbJZtDhwmi+GOCNBhAl/Ft+sTpjb4K/OOshDMoAywOXX5dasrpFy3IFlbzFEg/EXRLtUeJjfTKQSv0b0EIm2/A/kQxtOV978CPki7lCCx1ybLJ383oxj0Yc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779871347; c=relaxed/simple;
	bh=iHt8FTv7u9NOPzFk7EycFfGirAEiJY3Pc8cpAWX5Cb8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MK6+r1Iib3nydnXnFsro460+HfcGCHbDhuvPYt/zmoMuacmzDH7P1PqRqOzFwv7ubsQQVPLpuegGxqqGYTNZWqufu+oJ41cHoQv8meh9oUd5cBYlcVDRnDEPLoCg3i8wydg6Mk7Ufun1F4K/3Cj5xEVDGdSlzZF0MfdfUNn5ubc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BQwii13a; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-49056b9f04aso50835475e9.0
        for <linux-api@vger.kernel.org>; Wed, 27 May 2026 01:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779871344; x=1780476144; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aKtMgPU0sFudicJhz4wUk7NigX5dEPGgvFzj77+8qJI=;
        b=BQwii13avubalvU2n5ruGVcuUpEyULB2lnW1NDG2KAdoKa7e6vCr4+ixZHyPE++dPu
         OarcoM9NbRqDoQMsuiBf9BMIPZQ8vNMItno0g89LkSHRNrou3YV/id9QqH2XYwkcMdUu
         8Y+7EpW1eX+X3QJXpyld/hRxB8j1N8ygPAp2PUpiBNHTgbKb8FoSunh77tHisUNnolyD
         WsIxhsUqZPRVEXfTxyFeHe/iJiSw/6PU5WLa5w9OZkPvjRvHAIIrHcTQy3WYGRliJXD7
         Eae8cHNkyxAXAFR+78jomlAOEwViGFiJJ/hTKDiHbts6I68ElOQLHEzZ1KwMWkCEbXEx
         fT0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779871344; x=1780476144;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aKtMgPU0sFudicJhz4wUk7NigX5dEPGgvFzj77+8qJI=;
        b=qo2q5Z5+WOz2NfVitIcePe3hm4AWDg37S5bLFLpiloYFF2+TH9+166FxL1TiyveO/v
         qW2mJKVJP5cir72ZnxBC5bx3E7RYZXqKYDMWmDrlaExOt+QmvIseGh4yeM3St0icE6hX
         DABFDEF6Np+RIsVNlNRtxBW3P2FYmkzhXRiXCJlxRYfEIrKNKPH7F1GTLFL7qw4siQhy
         4gCB/TWe6wbQ89dEKduA9IN/xVTzw2wONiF1o/o/57Qs2FNcx/aQb6FHHuYKBgcwOYQ3
         8P0ChUz9nCXizNyiAgiNTp6HWKvWiq42tarXB4gRyDfT5YwHPQ4A5lltjgsLI9aeoDDf
         8W/A==
X-Forwarded-Encrypted: i=1; AFNElJ8iCDonF+e5O2DhlKlm3pUYZg3nTNtxumkiMmIicGjStuVb9uv0eIo3UwaDC0KCLpMryMtCbMw/3bw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYRdjt9Wgi/S//cVJ4gk8CRNDv4WBy3QQs6VmohTE+uCpC0WWF
	8d0WgFBjAj8mfczP2KILUHUbQk3lE0mBrtIa+P7++wKJIBWSd8iZMd9c
X-Gm-Gg: Acq92OED5xrNB7/l/FHBKr4SeogEdBDEkerchaEAUXgX9jZ1z1mRPiyC84Xpi4tNtf0
	NDBoIR4GctA6V/8ywnSSuVGM3do4ksUbwfLycCK3Do9p0g7ykuxSacInEvnHXxLMLfIHQVBpPj2
	12yUZbF0UIdxZ9zxrRgh82lUlHeh66NYyFVxlkgqPv1l4lUsEc9/LZ80zFOkQbwmbOCYnrpK1nY
	VuFoO8/A3Ha/KoUsyBQFhKCrRV94KGir9T821pAD2fg7Gnh8JzA9FMsM69gwVjeB155Y5DqxkNv
	S6MYsobaXNrmwh+qbt0ppHDxYkAafFl1AiJyE6dUEEJU4gFTIl3ZWHiNm/5YG1PehJiwRndk/fj
	/Vxn9J6F7CVXRzui52nKL/8phqg713YKIKWVHoE0cma9Nkbh8W2jkZUwSh2w4fxmJ2howo6jC0/
	yL1APnqmnfubX6hLr5V0Sxg8auCpr9JTht3k28tiqvLWw7B7zZ3ahJSPtmC8j+zuIkxlL6ql64g
	eI=
X-Received: by 2002:a05:600c:5298:b0:490:778:4fe4 with SMTP id 5b1f17b1804b1-490428e03c3mr379889165e9.26.1779871343975;
        Wed, 27 May 2026 01:42:23 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4907e6a60c4sm19108485e9.1.2026.05.27.01.42.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 01:42:23 -0700 (PDT)
Date: Wed, 27 May 2026 09:42:21 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: =?UTF-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>, Peter Zijlstra
 <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Christian Brauner <brauner@kernel.org>, Kees
 Cook <kees@kernel.org>, Shuah Khan <shuah@kernel.org>, willy@infradead.org,
 mathieu.desnoyers@efficios.com, Linus Torvalds
 <torvalds@linux-foundation.org>, akpm@linux-foundation.org, Yafang Shao
 <laoar.shao@gmail.com>, andrii.nakryiko@gmail.com, arnaldo.melo@gmail.com,
 Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
 kernel-dev@igalia.com, linux-mm@kvack.org, linux-api@vger.kernel.org,
 Bhupesh <bhupesh@igalia.com>
Subject: Re: [PATCH v2 4/6] sched: Extend task command name to 64 bytes
Message-ID: <20260527094221.2f5b49d9@pumpkin>
In-Reply-To: <20260526123103.4facbaed@gandalf.local.home>
References: <20260524-tonyk-long_name-v2-0-332f6bd041c4@igalia.com>
	<20260524-tonyk-long_name-v2-4-332f6bd041c4@igalia.com>
	<20260525114107.7fa5b4c1@pumpkin>
	<20260525114241.4b6f3050@pumpkin>
	<20260526123103.4facbaed@gandalf.local.home>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6426-lists,linux-api=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[21];
	FREEMAIL_CC(0.00)[igalia.com,infradead.org,redhat.com,linaro.org,kernel.org,efficios.com,linux-foundation.org,gmail.com,suse.com,vger.kernel.org,kvack.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,goodmis.org:email]
X-Rspamd-Queue-Id: 25CB05E1405
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 26 May 2026 12:31:03 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Mon, 25 May 2026 11:42:41 +0100
> David Laight <david.laight.linux@gmail.com> wrote:
> 
> > > >  	error = security_task_prctl(option, arg2, arg3, arg4, arg5);
> > > > @@ -2601,16 +2601,16 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
> > > >  			error = -EINVAL;
> > > >  		break;
> > > >  	case PR_SET_NAME:
> > > > -		comm[sizeof(me->comm) - 1] = 0;
> > > > +		comm[TASK_COMM_LEN - 1] = 0;
> > > >  		if (strncpy_from_user(comm, (char __user *)arg2,
> > > > -				      sizeof(me->comm) - 1) < 0)
> > > > +				      TASK_COMM_LEN - 1) < 0)      
> > > 
> > > Nak - you can't do that.
> > > You are reading data that the application doesn't expect you to read.    
> > 
> > Or have I got confused over the names...  
> 
> You may have gotten confused by names, as sizeof(me->comm) is the same as
> TASK_COMM_LEN. Basically, the above doesn't change anything.

The name of the patch doesn't help:
	sched: Extend task command name to 64 bytes

If you want to catch/check all the uses I suspect that all the
occurrences of TASK_COMM_LEN need changing.
For clarity this one should probably be TASK_COMM_LEN_OLD.
(that might be problematic for the uapi headers)

-- David

> 
> -- Steve


