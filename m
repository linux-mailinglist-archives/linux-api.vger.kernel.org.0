Return-Path: <linux-api+bounces-6073-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wPsPB41Z12lqMwgAu9opvQ
	(envelope-from <linux-api+bounces-6073-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Thu, 09 Apr 2026 09:47:25 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CFF03C739C
	for <lists+linux-api@lfdr.de>; Thu, 09 Apr 2026 09:47:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A0C52306489A
	for <lists+linux-api@lfdr.de>; Thu,  9 Apr 2026 07:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC0DB3815D9;
	Thu,  9 Apr 2026 07:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SO+NcJvH"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6E537D131
	for <linux-api@vger.kernel.org>; Thu,  9 Apr 2026 07:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775720669; cv=none; b=JRmoNfsQ+zJvNYQk2lts/hro2wlZ02NN/+Ve1K7KR/hNHOXIqq5Ytd6Pz1avsjGSm4MT1BexOHT4Qm//rA/9FjmVaxt3qxsG75C2Rx15hiv9o75UWdFK+ytG+KjfoBc4g3Nh0/KJ3fOu0eCcHKj/Ygxq+fIL/iyG4IWbD/o1DR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775720669; c=relaxed/simple;
	bh=JHc0rpT0VXACQqLal9pb1BOk7zluaiOXSCKc5SYV09c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q6B8vEpWLchAGafScxVFHm0Tj3apUN3UNYDcZwHoe7oBNS0zmXalz6JB7y/VmoiwDLVvcrRzIHnFjrKDVlUfLYigXquxcNyMqZwT/f+SGNRLRy8V+vSwDjNZkA7bR2MGsvnuJ1LgzeArk4+jRvrUzTxXlI4QEJEE2P7e3pcYX2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SO+NcJvH; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4887f49ec5aso7602275e9.1
        for <linux-api@vger.kernel.org>; Thu, 09 Apr 2026 00:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775720667; x=1776325467; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5zM/QUh5nNxcZ3yr09S8to3CJRO3tIlUiWsJb2TzILo=;
        b=SO+NcJvHFD/9qe5Egn3P6W48F9CZYzAPtrX4GdPVGj6g81/E7eZhu2lVIvZxQfA118
         G5PONf+ut98XxNhHFDxd8IR/kHOMMgXsvkfBd/T/Pxy1MdGs5R5bz3l4+XjhJtGN16wq
         bc5nQ0YyAldvDNkDM++3VlkHs3oEt3dxlCVePCwOBYBpe+8MUIXzoFWdXcQFpZkwLc/N
         d8Lxf8uss1M+AkpgRWnHIdL+G8b6bNVN3MZninzXxN8cSoV6F6ISO1qrOB4a9EYiTJ0Z
         IUczTDc2hIDx2Z86juPoCMQGvDV6hYARmUak2ZPTM2wj9tneB7YoO5LOd97QpepX52tp
         1/eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775720667; x=1776325467;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5zM/QUh5nNxcZ3yr09S8to3CJRO3tIlUiWsJb2TzILo=;
        b=ZXLydkRr8YJc3BwdDhMcD3IXL8ihiiDSppMbBPprdjuywWilX1BM0o2fP2njUAWaJD
         AaZYRJKDORdDSgn4mySFeSYDJ6NBMI1b/Stg8WMDyUc994XglFBHsL2hjvNMgG9roxya
         kLJ6kT7S4uoMoShqd7KoYVnHFX239N312X3KpJdI6g7sOPG6eMVVPniLL3hEM744CQg1
         PIiCYCYT1Q6ckAKk3TUM9uuP0C0HsTmERBUV0w+wwYKckjuF+rjw+2OReaF2Rhp6t01v
         tUjoiRgHVhsBX/ZgJBj5L4nxvli0Tt8QnMAJ6AX/1ujpmLanS+0P2Mvbfspv+NyFVQ+M
         oHOA==
X-Forwarded-Encrypted: i=1; AJvYcCVp1IwGAGuWDOq96TlVPNRocux4z9b6H6tYiH0R0fNNGKOwVxrcom2QESNIOZ6K5wrZdQNJt+ra+Mg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtglulalxpD+oPAXWwQBf1Ve6zF4zMyF3EF1RA6hJvwjO3PMeY
	eunrhuFlpBGDSrJSTt9yCYCP9H7UwyaztyKh1Vxr3wMZqIFBQyEuJZNH
X-Gm-Gg: AeBDiet+e5AUkVw0+nnvjt+eW1UBgirEMYROPhPV23qwMr4Nu/xiqF52Uh23daVnR3q
	yiw0wu9rxcsrVJ3y64nGsb0TNAA+gGJZsVn1ppU25YAIwvZ7l9Vz69oiaOchN12Tl3bTzhYykFc
	H2w1N4IK7uv3S2M8XHOUb61W7e58E21AHyJrMoqBUF5nobIUrOsZrC2yHmsDxDo+1S693PhyvMp
	/xpsukzQZuVgu27EDgx8C1vJnTeFBWd42cvAayiBgqJR2EuKbgjpydjMWSrwrzv3B2khaSkH1F7
	BKCRKgCAty3wmw1V0G2VP4LSIGm+OYNiZXNP7UlkJj+nBf8409WuDoINMGoS1J4dzaOGMfyMxYI
	FQpGI4j9HX3Fggz+lnSg7s8CK6MIwKD8KuZRuqLdBl1kjp/YNalEgLGeWRIElMM6MVUH0lEAC7k
	oNoDlIOYa4x4OoRQnXpyEwbd0CNgeeDgq/pLZycZpgXo21fRwN4R4EmpV2/QlkpO1J
X-Received: by 2002:a05:600c:5292:b0:488:8c89:cfaa with SMTP id 5b1f17b1804b1-488996b021fmr370012665e9.3.1775720666526;
        Thu, 09 Apr 2026 00:44:26 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488cfa759bdsm33438345e9.12.2026.04.09.00.44.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 00:44:26 -0700 (PDT)
Date: Thu, 9 Apr 2026 08:44:24 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: Mateusz Guzik <mjguzik@gmail.com>, Andy Lutomirski <luto@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav
 Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner
 <brauner@kernel.org>, Jeff Layton <jlayton@kernel.org>, Chuck Lever
 <chuck.lever@oracle.com>, Arnd Bergmann <arnd@arndb.de>, Shuah Khan
 <shuah@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "H.
 Peter Anvin" <hpa@zytor.com>, Jan Kara <jack@suse.cz>, Alexander Aring
 <alex.aring@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Oleg
 Nesterov <oleg@redhat.com>, Andrey Albershteyn <aalbersh@redhat.com>, Jiri
 Olsa <jolsa@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Thomas =?UTF-8?B?V2Vpw59zY2h1aA==?=
 <thomas.weissschuh@linutronix.de>, Namhyung Kim <namhyung@kernel.org>,
 Arnaldo Carvalho de Melo <acme@redhat.com>, Aleksa Sarai
 <cyphar@cyphar.com>, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org,
 cmirabil@redhat.com, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Subject: Re: [RFC PATCH 1/2] vfs: syscalls: add mkdirat_fd()
Message-ID: <20260409084424.6030eea2@pumpkin>
In-Reply-To: <1333067272.1649333.1775682991132@kpc.webmail.kpnmail.nl>
References: <20260331172011.3512876-1-jkoolstra@xs4all.nl>
	<20260331172011.3512876-2-jkoolstra@xs4all.nl>
	<pbobkjhtuli53o3z34ajyxztaosmztwlygxfxhhjq5ajt47inc@ngtoge3ucdm5>
	<1632825771.784338.1775039101736@kpc.webmail.kpnmail.nl>
	<CAGudoHE-zSfiL2aVf41UHOtMsE53gCqLpVoy-NxoB8HeXtdgEA@mail.gmail.com>
	<1333067272.1649333.1775682991132@kpc.webmail.kpnmail.nl>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6073-lists,linux-api=lfdr.de];
	FREEMAIL_TO(0.00)[xs4all.nl];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[34];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,linux-api@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,redhat.com,alien8.de,linux.intel.com,zeniv.linux.org.uk,oracle.com,arndb.de,linuxfoundation.org,zytor.com,suse.cz,infradead.org,efficios.com,linutronix.de,cyphar.com,vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.996];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,xs4all.nl:email]
X-Rspamd-Queue-Id: 8CFF03C739C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 8 Apr 2026 23:16:31 +0200 (CEST)
Jori Koolstra <jkoolstra@xs4all.nl> wrote:

> > Op 07-04-2026 11:00 CEST schreef Mateusz Guzik <mjguzik@gmail.com>:
...
> > I am not saying it's impossible. I am saying mkdir was always a
> > separate codepath and in order to change that you would need to add a
> > branchfest to open. I don't see any reason to go that route.

The open code is complex enough that an extra branch won't matter. 

> That's a fair point. But there's also upsides like Aleksa has mentioned.
> I'm not very opinionated on the matter, especially since I don't know why
> those paths were ever separated.

I doubt they were ever joined.
mkdir() is more likely to have been separated from mknod() when the code
to add the "." and ".." entries was moved into the kernel filesystem code.
I'm not sure when that would have happened, mvdir() was done in userspace
with the link() and unlink() system calls until (at least) the mid 1980s.
It was probably the complexity of locking in SMP kernels that make both "."
and ".." be 'canned' names rather than just references to another directory.
(Yes, it used to be easy to make ".." refer to the 'wrong' place and get
find to loop.)
Of course, this all predates Linux.

	David

> 
> Thanks,
> Jori.
> 


