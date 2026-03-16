Return-Path: <linux-api+bounces-5988-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qNOfDOart2nkUAEAu9opvQ
	(envelope-from <linux-api+bounces-5988-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Mon, 16 Mar 2026 08:06:14 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E70832955F1
	for <lists+linux-api@lfdr.de>; Mon, 16 Mar 2026 08:06:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E3BB13012C8D
	for <lists+linux-api@lfdr.de>; Mon, 16 Mar 2026 07:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C62FD34D4EB;
	Mon, 16 Mar 2026 07:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rrvNm/sp"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516A3349B1F
	for <linux-api@vger.kernel.org>; Mon, 16 Mar 2026 07:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773644769; cv=pass; b=ekpCL7RfjbHCO9os0InG6DHSYfvxYob/GH5M+drClrqc3egSMl+iWclU9UcLzJuzP09kRm+7KBSpMzuVvQC4WgWW7E1TEDDUNDAulXMb8AZEVBXuyS0QxZsJi0Yt3k9i8ImjyiKJEi/f+pqtsxzwcbD+ZNe4afNnz6H6gGnOOz0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773644769; c=relaxed/simple;
	bh=DWa/MwbMbU4Cgy8HcLpzA6KnltFCFdwdVTLoxcjvQIo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MGxDwCfQnDggsFARzItD5A7X6ZUezKxEf/JE38rINShInrXpI/Y5Nz8AnbVmereSE4iofY94MmZGt1O6ooEFre3mG/NPiqNrrnhDDM7oCq5uGKLfBaY7Uw4HvUyJ3UjyNS7t2t92gZBhPxqt97YuIE3iUYYyjZhr3b1st5KvYqc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rrvNm/sp; arc=pass smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-38a3fd333eeso33992031fa.1
        for <linux-api@vger.kernel.org>; Mon, 16 Mar 2026 00:06:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773644766; cv=none;
        d=google.com; s=arc-20240605;
        b=k6jiyon+wQYhAKCfyJBKW2W8mu/1Cl7ZED7pdKM5x8EywIGXwWm2eW45g3rAvmsxVO
         CZG5JNyt1kcNd10taeiRdqOXOf14+O2NGt+eOKzDTUc02riyL671N9l3rRT9ZPDjaKK9
         fFlwBKvYDmWw9tY51rCTPE+tmGqhoNgRWv2+Jz5cKFmaz0PDv1FG4NMP6xa3W+KQ8YNr
         6kwl5S9Rx5elFVfuNI1NnQ7dGq59SuihQcO4q7Otw4nQJMi0b2KLUCKColBJYXdZJryG
         sMzfcfc7WVjAddZbMXjsdUZGVAdagd5GMcQ3reRPs6LPzzyAr+OeUfrvstPqUyB/crUt
         uEHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=DWa/MwbMbU4Cgy8HcLpzA6KnltFCFdwdVTLoxcjvQIo=;
        fh=YfirBAX7zSvcnhK5EvCavYHDywzUEoZ3NUyNU6ehkBc=;
        b=NKbEc5TsCQQOMjFprlUt4J92PEUa+aywxk1mTEB3q5wh9bm3hCJuH2r4t3d0mcMEcC
         tI3pYuosw4bD6g3YdpgLhqx9fPnrBwananJSM7fyGwlto9ZhkFFghdcc65bXnvdIVgy/
         EVlsiKXe+UOF/jcsmPKzFXsH7Cyhhh222FyRtno7FkFu2eeH7PA6Fi4+qIgD6t4+It0I
         k1XqBEKT5vtkbSIZDRVF9aP93ISVao8TsCJa+yvgV69+zZ/abWnvUeG29OGWU87b8zM/
         7ah+ClZreJdjI4f5FSp4/NMYJBIL8G+VfWGdKFeuFSY1OFstsjpigOe10XyDi7cTGYS1
         Iorw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773644766; x=1774249566; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DWa/MwbMbU4Cgy8HcLpzA6KnltFCFdwdVTLoxcjvQIo=;
        b=rrvNm/sp0ejqtQpts4YJvKIZJai0U7h6SimZ1+626FCi7l4L6Dzs/D5AfC15pRBoWr
         kv/dIm7CfHnm9HMv/wH+hAenKg7VAAA/E7tVULHXPbxFq6YGS4qlbY3FPnHscS4jfzMo
         D3dH3ecOve/eQGzSnAb4Ojy44wq5Nw/0FFYtscPxcItm710bCdD1kjJ/hOB3448XZy8f
         K4xi4VdbUD1F+Vo4MhfBcbKbgnUdds5xx8LCHziC6xxbqHA6MvyjhOKbbiisyPVocwZ3
         KxoLuACxgOlrc3AY0BNPbelvSOBLVO9w1iQzbOC3uVjI5svhEljwS33qC/sFSOyzUjaG
         pJow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773644766; x=1774249566;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DWa/MwbMbU4Cgy8HcLpzA6KnltFCFdwdVTLoxcjvQIo=;
        b=X2n5YT/boxMv/AAxIr2/kVs6lk7Vdwb2EXwqOLSj71m/diImqlgURBiI5eDXnw5m7B
         PEN9nSDNHLCOweEV0MAYsUKgQa8Q/MUEu5kP+BKvEbthSZx9OF67vLDtwb6P/weW+VCQ
         mx0hqDJyuzvlw7B0NL3GJFjeE0inxIOIubXWUQLR9a0zQ+EIu1ScJYmGsJUD9pLzAT8Z
         sMBOEfZaoXjfq7V4Exrx3lYxbhfFIJES5f9e9NOZLmUROl8uToJ9ByUSG+M7KG90s9vA
         ZHfAC7oYX0VEMAGSYR+99HX7R/A+BSCd5WZH3jFfuTrzruAaM2RTKpEPVlpBfCWdd7BE
         ZAAA==
X-Forwarded-Encrypted: i=1; AJvYcCUUL0wkDWO6BFmz9OfVrZ/KKkmqyeX+sNAesoTrAAwsJ7dOrFbUP0AekPyFzmrX8Uy28re8bKgKjME=@vger.kernel.org
X-Gm-Message-State: AOJu0YzImq+P7nEJxJMFOlJPjDAfDFHJZas3kbeC1VJeFhGLVy8TLjID
	ktf07vBh05VBsy2H47qYup70+mOAN/EKTEtykvgR5batdp3x/2IFvkQJa5HjAEGGwVZgVz9osdw
	+dprf+Uz6aKmsbHhzhbG6IQ2RjHDvqbCMc4CdtVek
X-Gm-Gg: ATEYQzxa8bpWwBcFA+BlCjRozd3lRL0hwFO8v2o3tJK7Gg9AtghOp3soDG/O0pVFosK
	P2M0DjEkxMIUSS33Awz2ySG7fe+PLFNaOULdf4KFQ9KPyVQupKOnzkN7anNWSi8W1O3NIkjEdJZ
	EWAdJUQwNVw5dz7ah40TW3w71UpMZ2BJviWC6u1GKVjEFzlY3t7m/kKrb7smYUT/2F2NxAlsW3S
	1839zRl1NG3v7oi9w+hJxQ10tpT9dL113+gCX1VHXlDeQuVgrzF16tsqJEuCHdn+zzF4jqS9rl7
	hwYK9x2QbTZ+GnlJG+iqbHsWuS3+A42oPwpbaMQdwGyzpurI5o/Q7HDPrMMLo0ep20cjMA==
X-Received: by 2002:a05:651c:4356:10b0:38a:2db9:eb72 with SMTP id
 38308e7fff4ca-38a8864c94amr30667511fa.16.1773644766146; Mon, 16 Mar 2026
 00:06:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260313150928.2637368-1-sashal@kernel.org> <20260314111822.63a2ba4a@kernel.org>
In-Reply-To: <20260314111822.63a2ba4a@kernel.org>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Mon, 16 Mar 2026 08:05:53 +0100
X-Gm-Features: AaiRm53tuutFjpddzDm8MgJQk_X6I9zzb6Uz-8-_BFX3BICSXZm9HxgKcE0xoPQ
Message-ID: <CACT4Y+arWePyxnV3hWk5RanWZpoc7=ALQ6DV_2MCuQkNoTtJUw@mail.gmail.com>
Subject: Re: [PATCH 0/9] Kernel API Specification Framework
To: Jakub Kicinski <kuba@kernel.org>, syzkaller <syzkaller@googlegroups.com>
Cc: Sasha Levin <sashal@kernel.org>, linux-api@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, workflows@vger.kernel.org, tools@kernel.org, 
	x86@kernel.org, Thomas Gleixner <tglx@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jonathan Corbet <corbet@lwn.net>, 
	Randy Dunlap <rdunlap@infradead.org>, Cyril Hrubis <chrubis@suse.cz>, Kees Cook <kees@kernel.org>, 
	Jake Edge <jake@lwn.net>, David Laight <david.laight.linux@gmail.com>, 
	Askar Safin <safinaskar@zohomail.com>, Gabriele Paoloni <gpaoloni@redhat.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, 
	Masahiro Yamada <masahiroy@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-5988-lists,linux-api=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,linuxfoundation.org,lwn.net,infradead.org,suse.cz,gmail.com,zohomail.com,redhat.com,zeniv.linux.org.uk,linux-foundation.org,arndb.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dvyukov@google.com,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-api];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,raw.githubusercontent.com:url,mail.gmail.com:mid]
X-Rspamd-Queue-Id: E70832955F1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, 14 Mar 2026 at 19:18, Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Fri, 13 Mar 2026 11:09:10 -0400 Sasha Levin wrote:
> > This enables static analysis tools to verify userspace API usage at compile
> > time, test generation based on formal specifications, consistent error handling
> > validation, automated documentation generation, and formal verification of
> > kernel interfaces.
>
> Could you give some examples? We have machine readable descriptions for
> Netlink interfaces, we approached syzbot folks and they did not really
> seem to care for those.

I think our reasoning wrt syzkaller was that not all interfaces in all
relevant kernels are described with netlink yml descriptions, so we
need to continue using the extraction of interfaces from the source
code. And if we have that code, then using yml as an additional data
source only adds code/complexity. Additionally, we may extract some
extra constraints/info from code that are not present in yml.

Realistically system call descriptions may have the same problem for
us at this point, since we extract lots of info from the source code
already:
https://raw.githubusercontent.com/google/syzkaller/refs/heads/master/sys/linux/auto.txt
(and LLMs obviously can allow us to extract more)

