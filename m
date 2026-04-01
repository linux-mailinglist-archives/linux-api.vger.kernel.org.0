Return-Path: <linux-api+bounces-6054-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KNzpFpUpzWnyaQYAu9opvQ
	(envelope-from <linux-api+bounces-6054-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Wed, 01 Apr 2026 16:20:05 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C8A37C09A
	for <lists+linux-api@lfdr.de>; Wed, 01 Apr 2026 16:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 807FB3138D41
	for <lists+linux-api@lfdr.de>; Wed,  1 Apr 2026 14:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C73DB43E9C2;
	Wed,  1 Apr 2026 14:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YH9UZTjy"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4020B2DC32C
	for <linux-api@vger.kernel.org>; Wed,  1 Apr 2026 14:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775052569; cv=none; b=sXFrq7R7Ohhj0QLGiBMwaxdGAOoYGFQG1wL2hnL8h/z5DV4CnqOAaRYvHr9JNxvdLj5nsuJ06UuRKtfzww7gyET4U/AAda1aadl5bwVNvZ/iyIdCf7OybCwmpwCVfOYUfCmbbche5OEJbF2gNgxkbL1yH8ewwFnGs0BoQfsUfco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775052569; c=relaxed/simple;
	bh=FkHhl5SAKIEruahir/S4Yn91EO6ZVJU7/+9TaXQ8gB0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L81XpDNrANYaC/2WSadkZPsN97gfIQK4YChZnGJnb8fvFn9P4S+LWn1zjoNrrOzD96JQQKwgIckm1X3itL562z3cnOsedEBYVDaLRRppCADXEz9HQ518ht4tE2HukD3ZN8aZpE26b7yretDwSOxfdxslaCumAmOnWehdhzqihkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YH9UZTjy; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-48374014a77so83652275e9.3
        for <linux-api@vger.kernel.org>; Wed, 01 Apr 2026 07:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775052566; x=1775657366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O7S8G0jPQziP2icNG+Xq9AlGcKIFYSGaYnHCga7XZDY=;
        b=YH9UZTjy3/pdQ79lXxzABHUThvXHPlEoBkr2uM26hOMLonb0pB4TOTJFXYkqTdqUL1
         uAmYbJwr/TTHkIl4EGRqqZAFR86rl5d5WB8ao+h9PbLUHExLUo7WsR46VV//tkeQP04m
         De+Vaaz54awqHQj/7hixZSVaZACSjjJgwmLvTA45KKDMZmulYc+fN+5tiyTDQn8PNx3E
         KJoOk9Oeai6SM71kEMALniwZJUd5nZ7VUhv/m03Y1YYOJgOrvsic1hAN+Jaz7ipNlw3x
         O8J7QFCxHEBvhLzdGqOqtvmmwhJ3d3IRLanmIwT1v09/tTvzatB+tB6yAKELkUQm4l3f
         NbEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775052566; x=1775657366;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O7S8G0jPQziP2icNG+Xq9AlGcKIFYSGaYnHCga7XZDY=;
        b=QtLpYsLxiFLaRSJ7J0G/p73n5qB4kBz2mSARDXEW7mkmUglytu4mhXiaLAXmipkxSm
         IxNr0bW3JdA3de8QqLOWfBkmb62yrXhpOIRtPCX1WivKAvUSpTrM6fNFDUkNK3QWUA7n
         gifeAB/e7Lqx1t6L1Kx7wAcrrB8tE3ksmZAOEPQ2U6/vphl2mzMefkjqli6Kh6XYsQ4y
         r51vG53kz5yIsM1riZu2nvKmMMCkejNa0buwgNvq/fVlMknAeeWt68BUIM5PtofOQ5Zk
         lF5WL0LnvKy3TX5NAc5ba8UKxzk5untvF6SgUFrBB5lrOYwiPTU8I+EEk3PGPVkJ4oMl
         +KoQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/Txn+kMBYxRCvipRfJwhhnPW3QxO73eB1KW+MuEE8QGjJHsr4u7vN8FSNfQ/jt5IHQE7th2sSvo8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgB6GqlM81HTBl0z/K0U/q8A6MluWUwxk//t6lxJJmYnUM1yxu
	S83meEq9bouemwAC56Gy7oeb9ePJQ9VSCkokNfqOowY4zbMN3DrHxER7
X-Gm-Gg: ATEYQzw3hEqekaz//r58a68lgcZrvc/8ikefg3XhGvSrYy1Wqd3rYtNCZEtNd+6jfYh
	zSqdHOao2d5fYeMVenF7xAJqSSx4d2yP9ta3tXnov4l5ROjRd6bxjlPFGk3sHgSJJt2OCy3cxku
	oNpjQ/HQpCGHuKhi/n5hIGvczC/3rZDx38UTaQaEdgoC2DYxsJmoTXjbQqFM/LjbKrUtcb0SyII
	RM84TXQbGdUPZWkh7NJA14xikuwXrH+WoALrOBY0LfgVG0UYL7WVeXu0ZLe/Ok+9syjQO1Bdqzd
	rvG2qtsvqImA8olJzUn9sSxlXEcWWRIYUNwQTg588lyMCXPwMoudGCsDjQfih/i1dBecASSO39z
	VE+O1zUr4o7w1DohIrwFz8aMW8IQFgEDrXLRkoYIj1aBosIaNz7wCoXkc1gqovnofxcdxKfE9N0
	OsKfZlVSk/QVKv/rtBC8U0E1OtQlSyspf3OjmQmUKht7pocLEWDeZaXCEd7ysf
X-Received: by 2002:a05:600c:3e1b:b0:485:ae14:8173 with SMTP id 5b1f17b1804b1-4888355e47fmr62749425e9.1.1775052565221;
        Wed, 01 Apr 2026 07:09:25 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887c8b12aesm40093505e9.22.2026.04.01.07.09.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 07:09:24 -0700 (PDT)
Date: Wed, 1 Apr 2026 15:09:22 +0100
From: David Laight <david.laight.linux@gmail.com>
To: "Arnd Bergmann" <arnd@arndb.de>
Cc: "Jori Koolstra" <jkoolstra@xs4all.nl>, "Andy Lutomirski"
 <luto@kernel.org>, "Thomas Gleixner" <tglx@kernel.org>, "Ingo Molnar"
 <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>, "Dave Hansen"
 <dave.hansen@linux.intel.com>, x86@kernel.org, "Alexander Viro"
 <viro@zeniv.linux.org.uk>, "Christian Brauner" <brauner@kernel.org>, "Jeff
 Layton" <jlayton@kernel.org>, "Chuck Lever" <chuck.lever@oracle.com>, shuah
 <shuah@kernel.org>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "H.
 Peter Anvin" <hpa@zytor.com>, "Jan Kara" <jack@suse.cz>, "Alexander Aring"
 <alex.aring@gmail.com>, "Peter Zijlstra" <peterz@infradead.org>, "Oleg
 Nesterov" <oleg@redhat.com>, "Andrey Albershteyn" <aalbersh@redhat.com>,
 "Jiri Olsa" <jolsa@kernel.org>, "Mathieu Desnoyers"
 <mathieu.desnoyers@efficios.com>, Thomas =?UTF-8?B?V2Vpw59zY2h1aA==?=
 <thomas.weissschuh@linutronix.de>, "Namhyung Kim" <namhyung@kernel.org>,
 "Arnaldo Carvalho de Melo" <acme@redhat.com>, "Aleksa Sarai"
 <cyphar@cyphar.com>, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, Linux-Arch
 <linux-arch@vger.kernel.org>, linux-kselftest@vger.kernel.org,
 cmirabil@redhat.com, "Masami Hiramatsu" <mhiramat@kernel.org>
Subject: Re: [RFC PATCH 1/2] vfs: syscalls: add mkdirat_fd()
Message-ID: <20260401150922.0990d935@pumpkin>
In-Reply-To: <c2ea52f2-b232-404b-9ec6-75d8efae6bea@app.fastmail.com>
References: <20260331172011.3512876-1-jkoolstra@xs4all.nl>
	<20260331172011.3512876-2-jkoolstra@xs4all.nl>
	<c2ea52f2-b232-404b-9ec6-75d8efae6bea@app.fastmail.com>
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
	TAGGED_FROM(0.00)[bounces-6054-lists,linux-api=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[33];
	FREEMAIL_CC(0.00)[xs4all.nl,kernel.org,redhat.com,alien8.de,linux.intel.com,zeniv.linux.org.uk,oracle.com,linuxfoundation.org,zytor.com,suse.cz,gmail.com,infradead.org,efficios.com,linutronix.de,cyphar.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lwn.net:url]
X-Rspamd-Queue-Id: F1C8A37C09A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 31 Mar 2026 21:13:34 +0200
"Arnd Bergmann" <arnd@arndb.de> wrote:

> On Tue, Mar 31, 2026, at 19:19, Jori Koolstra wrote:
> > Currently there is no way to race-freely create and open a directory.
> > For regular files we have open(O_CREAT) for creating a new file inode,
> > and returning a pinning fd to it. The lack of such functionality for
> > directories means that when populating a directory tree there's always
> > a race involved: the inodes first need to be created, and then opened
> > to adjust their permissions/ownership/labels/timestamps/acls/xattrs/...,
> > but in the time window between the creation and the opening they might
> > be replaced by something else.
> >
> > Addressing this race without proper APIs is possible (by immediately
> > fstat()ing what was opened, to verify that it has the right inode type),
> > but difficult to get right. Hence, mkdirat_fd() that creates a directory
> > and returns an O_DIRECTORY fd is useful.
> >
> > This feature idea (and description) is taken from the UAPI group:
> > https://github.com/uapi-group/kernel-features?tab=readme-ov-file#race-free-creation-and-opening-of-non-file-inodes
> >
> > Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>  
> 
> I checked that the calling conventions are fine, i.e. this will work
> as expected across all architectures. I assume you are also aware
> that the non-RFC patch will need to add the syscall number to all
> .tbl files.
> 
> The hardest problem here does seem to be the naming of the
> new syscall, and I'm sorry to not be able to offer any solution
> either, just two observations:
> 
> - mkdirat/mkdirat_fd sounds similar to the existing
>   quotactl/quotactl_fd pair, but quotactl_fd() takes a file
>   descriptor argument rather than returning it, which makes
>   this addition quite confusing.
> 
> - the nicest interface IMO would have been a variation of
>   openat(dfd, filename, O_CREAT | O_DIRECTORY, mode)
>   but that is a minefield of incompatible implementations[1],
>   so we can't do that without changing the behavior for
>   existing callers that currently run into an error.

Just require O_TMPFILE to be set as well :-)
You know you'll never regret it one Apr-1 is over.

Can something be done with the flags to openat2().
That might save allocating an extra system call.

	David


> 
>        Arnd
> 
> [1] https://lwn.net/Articles/926782/
> 


